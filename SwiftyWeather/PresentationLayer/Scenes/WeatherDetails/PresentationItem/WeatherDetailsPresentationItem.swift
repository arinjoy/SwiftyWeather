//
//  WeatherDetailsPresentationItem.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDetailsPresentationItem {
    
    let cityName: String
    let shortDescription: String?
    let iconURL: URL?
    
    let temperature: String
    let temperatureIcon: UIImage?
    
    let minTemperature: String
    let minTemperatureIcon: UIImage?
    
    let maxTemperature: String
    let maxTemperatureIcon: UIImage?
    
    let humidity: String
    let humidityIcon: UIImage?
    
    let windSpeed: String?
    let windSpeedIcon: UIImage?
    
    struct Accessibility {
        let weatherIconAccessibility: AccessibilityConfiguration
        let currentTemperatureAccessibility: AccessibilityConfiguration
        let minTemperatureAccessibility: AccessibilityConfiguration
        let maxTemperatureAccessibility: AccessibilityConfiguration
        let humidityAccessibility: AccessibilityConfiguration
        let windSpeedAccessibility: AccessibilityConfiguration
    }
    
    var accessibility: Accessibility?
}
