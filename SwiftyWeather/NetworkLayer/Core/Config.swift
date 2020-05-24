//
//  Config.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct Constant {
    
    /// API documentation: https://openweathermap.org/current#cityid
    
    /// The list Ids of capital cities in Australia as per provided by Open Weather Map API
    static let cityIDs: [String] = [
        "2147714", // Sydney
        "7839805", // Melbourne
        "2174003", // Brisbane
//        "7839581", // Gold Coast
//        "2078025", // Adelaide
//        "2063523", // Perth
//        "2172517", // Canberra
//        "2163355", // Hobart
//        "7839402", // Darwin
     ]
    
    /// API Documentation available at:
    /// http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
    
    enum ApiConfig {
        static let serverPath: String = "https://api.openweathermap.org/data/2.5/group"
        static let apiKey: String = "a90804ee877a7f99ffe80dbbfd23695c"
        static let weatherUnit: String = "metric"
    }
}
