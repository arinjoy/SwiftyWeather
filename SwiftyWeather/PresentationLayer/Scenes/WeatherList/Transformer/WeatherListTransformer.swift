//
//  WeatherListTransformer.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 25/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

struct WeatherListTransformer: DataTransforming {
    
    /// Number formatter helper
    private let formatter: NumberFormatter?
    
    init() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        self.formatter = formatter
    }
    
    func transform(input: [CityWeather]) -> [WeatherSummaryPresentationItem] {
        let presentationItems: [WeatherSummaryPresentationItem] = input.map { item  in
            
            var temrperatureString = formatter?.string(from: NSNumber(value: item.temperature)) ?? ""
            temrperatureString += " " + StringKeys.SwiftyWeatherApp.temperatureUnit.localized()
            
            var item = WeatherSummaryPresentationItem(
                cityName: item.cityName,
                currentTemperature: temrperatureString)
            
            item.accessibility = AccessibilityConfiguration(
                identifier: "swiftyWeatherApp.accessibilityId.weatherCell",
                label: UIAccessibility.createCombinedAccessibilityLabel(from: [item.cityName, item.currentTemperature]),
                hint: StringKeys.SwiftyWeatherApp.weatherListItemAccessibilityHint.localized(),
                traits: .button)
            
            return item
        }
        
        return presentationItems
    }
}

