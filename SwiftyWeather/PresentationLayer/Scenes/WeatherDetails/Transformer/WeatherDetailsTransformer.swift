//
//  WeatherDetailsTransformer.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDetailsTransformer: DataTransforming {
    
    /// Number formatter helper
    private let formatter: NumberFormatter?
    
    init() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        self.formatter = formatter
    }
    
    func transform(input: CityWeather) -> WeatherDetailsPresentationItem {
        
        var shortDescription: String?
        if let description = input.description, !description.isEmpty {
            shortDescription = description.lowercased()
        }
        
        var item = WeatherDetailsPresentationItem(
            cityName: input.cityName,
            shortDescription: shortDescription,
            iconURL: input.iconURL,
            temperature: temperatureString(input.temperature),
            temperatureIcon: Theme.Icon.thermoTemp.icon,
            minTemperature: temperatureString(input.minTemperature),
            minTemperatureIcon: Theme.Icon.minTemp.icon,
            maxTemperature: temperatureString(input.maxTemperature),
            maxTemperatureIcon: Theme.Icon.maxTemp.icon,
            humidity: humidityString(input.humidity),
            humidityIcon: Theme.Icon.cloudHumid.icon,
            windSpeed: windSpeedString(input.windSpeed),
            windSpeedIcon: Theme.Icon.wind.icon,
            accessibility: nil
        )
        item.accessibility = itemAccessbility(input)
        
        return item
    }
    
    private func temperatureString(_ temperature: Double) -> String {
        var temrperatureString = formatter?.string(from: NSNumber(value: temperature)) ?? ""
        temrperatureString += " " + StringKeys.SwiftyWeatherApp.temperatureUnit.localized()
        return temrperatureString
    }
    
    private func windSpeedString(_ windSpeed: Double?) -> String? {
        guard let windSpeed = windSpeed else { return nil }
        var windSpeedString = formatter?.string(from: NSNumber(value: windSpeed)) ?? ""
        windSpeedString += " " + StringKeys.SwiftyWeatherApp.windSpeedUnit.localized()
        return windSpeedString
    }
    
    private func humidityString(_ humidity: Double) -> String {
        var humidityString = formatter?.string(from: NSNumber(value: humidity)) ?? ""
        humidityString += "% " + StringKeys.SwiftyWeatherApp.humidityUnit.localized()
        return humidityString
    }
    
    private func itemAccessbility(_ input: CityWeather) -> WeatherDetailsPresentationItem.Accessibility {
        return WeatherDetailsPresentationItem.Accessibility(
            weatherIconAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.weatherIcon",
                label: "weather image",
                hint: "visual clue of the weather"
            ),
            currentTemperatureAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.currentTemp",
                label: UIAccessibility.createCombinedAccessibilityLabel(
                    from: ["Current temperature", temperatureString(input.temperature)]
                )
            ),
            minTemperatureAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.minTemp",
                label: UIAccessibility.createCombinedAccessibilityLabel(
                    from: ["Minimum temperature", temperatureString(input.minTemperature)]
                )
            ),
            maxTemperatureAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.maxTemp",
                label: UIAccessibility.createCombinedAccessibilityLabel(
                    from: ["Maximum temperature", temperatureString(input.maxTemperature)]
                )
            ),
            humidityAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.humidity",
                label: UIAccessibility.createCombinedAccessibilityLabel(
                    from: [StringKeys.SwiftyWeatherApp.humidityPrefix.localized(), humidityString(input.humidity)]
                )
            ),
            windSpeedAccessibility: AccessibilityConfiguration(
                identifier: "accessibilityId.weatherDetails.windSpeed",
                label: UIAccessibility.createCombinedAccessibilityLabel(
                    from: [StringKeys.SwiftyWeatherApp.windSpeedPreix.localized(), windSpeedString(input.windSpeed)]
                )
            )
        )
    }
}


