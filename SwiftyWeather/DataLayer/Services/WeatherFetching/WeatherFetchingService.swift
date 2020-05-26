//
//  WeatherFetchingService.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

protocol WeatherFetchingClientType {
    
    func fetchWeather(forCityIDs cityIDs: [String]) -> Future<CityWeatherList, APIError>
}

/// A service client to retrieve weather of cities
final class WeatherFetchingServiceClient: WeatherFetchingClientType {
    
    private let dataSource: FutureDataSource
    
    init(dataSource: FutureDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchWeather(forCityIDs cityIDs: [String]) -> Future<CityWeatherList, APIError> {
        let request = WeatherFetchingRequest(withCityIDs: cityIDs)
        return dataSource.fetchFutureObject(with: request)
    }
}
