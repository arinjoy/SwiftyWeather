//
//  FutureDataSource.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

/// Data tasks which handles a api/server request and  returns a `Future` instance that produces one outcome and
/// then finishes or fails as per publisher/subcriber model & reactive programming paradigm in `Combine`
protocol FutureDataSource {
    
    ///  Calls the server, fetches and returns a `Future<T, Error>`
    ///
    /// - Parameter request: A BaseRequest instance that defines the API call
    /// - Returns: a `Future<T, Error>` instance containing the data and or error returned from the API call
    @discardableResult
    func fetchFutureObject<T>(with request: BaseRequest) -> Future<T, Error> where T: Decodable
    
}

