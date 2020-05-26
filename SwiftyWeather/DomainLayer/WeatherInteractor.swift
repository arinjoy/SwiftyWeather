//
//  WeatherInteractor.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

protocol WeatherInteracting: class {
    
    /// Gets a list of weather forcasts for a given cities in terms of a Publisher
    func getWeather(forCityIDs cityIDs: [String]) -> AnyPublisher<[CityWeather], APIError>
}

final class WeatherInteractor: WeatherInteracting {
    
    
    // MARK: - Private Propertires
    
    private let weatherFetchingService: WeatherFetchingClientType
    
    init(weatherFetchingService: WeatherFetchingClientType) {
        self.weatherFetchingService = weatherFetchingService
    }
    
    
    func getWeather(forCityIDs cityIDs: [String]) ->  AnyPublisher<[CityWeather], APIError> {
        return weatherFetchingService.fetchWeather(forCityIDs: cityIDs)
            .map { self.mapCityWeatherList(from: $0.weatherList) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Pruvate Helpers
    
    /// Maps data from `NetworkLayer.CityWeatherDetails` to `DomainLayer.CityWeather`
    /// Note:  There is some subtle differences between data structures at two layers. Basically at domain layer the data is flattened
    /// inside one structure and some custom logic and/or formatting rules can be applied here.
    /// Similarly `NetworkLayer.APIError` can also be converted into `DomainLayer.DomainError` for more granular and
    /// customised error handling and unit testing.

    private func mapCityWeatherList(from list: [CityWeatherDetails]) -> [CityWeather] {
        return list.map { item -> CityWeather in
            return CityWeather(cityId: String(item.cityId),
                               cityName: item.name,
                               temperature: item.mainInfo.temperture,
                               minTemperature: item.mainInfo.minTemperature,
                               maxTemperature: item.mainInfo.maxTemperature,
                               humidity: item.mainInfo.humidity,
                               windSpeed: item.windInfo?.speed,
                               title: item.summaries?.first?.title,
                               description: item.summaries?.first?.description,
                               iconURL: URL(string: Config.ApiConfig.iconWebUrlBasePath + (item.summaries?.first?.iconCode ?? "") + ".png"))
        }
    }
}

