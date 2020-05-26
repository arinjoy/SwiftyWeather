//
//  FileResourceManager.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

struct Resource<T> {
    let fileName: String
}

protocol FileResourceManaging {
    func load<T: Decodable>(fromResource resource: Resource<T>) -> Future<T, ResourceError>
}

final class FileResourceManager: FileResourceManaging {
    
    func load<T: Decodable>(fromResource resource: Resource<T>) -> Future<T, ResourceError> {
        return Future<T, ResourceError> { promise in
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                if let url = Bundle.main.url(forResource: resource.fileName,
                                             withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: url)
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(T.self, from: data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(.dataConversionFailed))
                    }
                } else {
                    promise(.failure(.notFound))
                }
            }
        }
    }
}
