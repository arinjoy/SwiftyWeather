//
//  CityWeather.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct CityWeather: Hashable {
    
    let cityId: String
    let cityName: String
    
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Double
    
    let windSpeed: Double?
    
    let title: String?
    let description: String?
    
    let iconURL: URL?
}

