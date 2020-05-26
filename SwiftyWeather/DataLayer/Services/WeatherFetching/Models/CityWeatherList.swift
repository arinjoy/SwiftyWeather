//
//  CityWeatherList.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct CityWeatherList: Decodable {
    
    var count: Int
    var weatherList: [CityWeatherDetails]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case weatherList = "list"
    }
}

struct CityWeatherDetails: Decodable {
    
    let cityId: Int
    let name: String
    
    let mainInfo: MainInfo
    let summaries: [SummaryInfo]?
    let systemInfo: SystemInfo?
    let visibility: Double?
    let windInfo: WindInfo?
    
    enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name = "name"
        case mainInfo = "main"
        case summaries = "weather"
        case systemInfo = "sys"
        case visibility = "visibility"
        case windInfo = "wind"
    }
}

struct MainInfo: Decodable {
    let temperture: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressureLevel: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temperture = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressureLevel = "pressure"
        case humidity = "humidity"
    }
}

struct SummaryInfo: Decodable {
    let title: String
    let description: String
    
    /// "http://openweathermap.org/img/w/" + iconcode + ".png";
    let iconCode: String
    
    enum CodingKeys: String, CodingKey {
        case title = "main"
        case description = "description"
        case iconCode = "icon"
    }
}

struct SystemInfo: Decodable {
    let timezone: Int64
    let countryCode: String
    let sunriseTime: Double
    let sunsetTime: Double
    
    enum CodingKeys: String, CodingKey {
        case timezone = "timezone"
        case countryCode = "country"
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
    }
}

struct WindInfo: Decodable {
    let speed: Double
    let degree: Double
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case degree = "deg"
    }
}


