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

    // MARK: - Private properties

    private let defaultSession: URLSession
    private var cancellable: AnyCancellable?

    init(withSession session: URLSession = URLSession(configuration: .default)) {
        self.defaultSession = session
    }

    // MARK: - FutureDataSource

    @discardableResult
    func fetchFutureObject<T>(with request: BaseRequest) -> Future<T, Error> where T: Decodable {
        
        return Future<T, Error> { promise in
            
            self.cancellable = self.defaultSession.dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    promise(.failure(error))
                }
            }, receiveValue: { result in
                promise(.success(result))
            })
            
            self.cancellable?.cancel()
        }
    }
}

struct Model: Decodable {
    let a: String
}


enum HTTPError: LocalizedError {
    case statusCode
}
