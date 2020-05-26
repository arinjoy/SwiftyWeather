//
//  HTTPClient.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

final class HTTPClient: FutureDataSource {
    
    /// The single shared instance of `HTTPClient`
    static let shared = HTTPClient()
    
    // MARK: - Open Properties
    
    /// The shared default session
    let defaultSession = URLSession.shared
    
    /// A cache for storing image data loaded from urls
    let cache = URLCache.shared
    
    // MARK: - Private Properties
    
    private var subscriptions = Set<AnyCancellable>()

    private init() {}

    // MARK: - FutureDataSource

    @discardableResult
    func fetchFutureObject<T>(with request: BaseRequest) -> Future<T, APIError> where T: Decodable {
        
        return Future<T, APIError> { [unowned self] promise in
            
            self.defaultSession.dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                guard response.statusCode == 200 else {
                    throw self.mapHTTPError(from: response.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    promise(.failure(self.mapError(from: error)))
                }
            }, receiveValue: { result in
                promise(.success(result))
            })
            .store(in: &self.subscriptions)
        }
    }
    
    // MARK: - Private Helpers - Custom Error mapping
    
    private func mapHTTPError(from statusCode: Int) -> APIError {
        switch statusCode {
        case 401:
            return .unAuthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 503:
            return .seviceUnavailable
        case 500 ... 599:
            return .server
        default:
            return .unknown
        }
    }
    
    private func mapError(from error: Error) -> APIError {
        if let connectivityError = self.mapConnectivityError(from: error) {
            return connectivityError
        } else {
            switch error {
            case let urlError as URLError:
                return .urlError(urlError)
            case _ as DecodingError:
                return .dataConversionFailed
            default:
                return error as? APIError ?? .unknown
            }
        }
    }
    
    private func mapConnectivityError(from error: Error) -> APIError? {
        switch (error as NSError).code {
        case NSURLErrorNotConnectedToInternet:
            return .networkFailure
        case NSURLErrorTimedOut:
            return .timeout
        default:
            return nil
        }
    }
}
