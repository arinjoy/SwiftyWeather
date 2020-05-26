//
//  SwiftyWeatherApp+LocalizationKeys.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 23/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

extension StringKeys {
    
    enum SwiftyWeatherApp: String, LocalizationKeys {
        
        // MARK: - General
        
        case viewTitle = "view.navigation.title"
        
        case temperatureUnit = "weather.detail.temp.unit"
        case minTempPrefix = "weather.detail.minTemp.prefix"
        case maxTempPrefix = "weather.detail.maxTemp.prefix"
        
        case humidityUnit = "weather.detail.humidity.unit"
        case humidityPrefix = "weather.detail.humidity.prefix"
        
        case windSpeedUnit = "weather.detail.windSpeed.unit"
        case windSpeedPreix = "weather.detail.windSpeed.prefix"
        
        case settingsAppearenceHeading = "settings.heading.appearence"
        case settingsAppInfoHeading = "settings.heading.appInfo"
        case settingsDarkMode = "settings.list.item.darkMode"
        case settingsVersion = "settings.list.item.version"
        
        case genericErrorTitle = "error.generic.alert.title"
        case genericErrorMessage = "error.generic.alert.message"
        case errorDismissTitle = "error.dismiss.action.title"
        case networkConnectionErrorMessage = "error.networkConnection.alert.message"
        
        case weatherListItemAccessibilityHint = "weather.list.item.accessibility.hint"
        

        // MARK: - LocalizationKeys
        
        var table: String? { return "SwiftyWeatherApp" }
    }
}
