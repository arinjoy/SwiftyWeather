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
        
        case viewLoadingTitle = "view.loading.title"
        
        case genericErrorTitle = "error.generic.title"
        case genericErrorMessage = "error.generic.message"
        case errorDismissActionTitle = "error.dismiss.action.title"
        
        case networkConnectionErrorMessage = "error.networkConnection.message"

        // MARK: - LocalizationKeys
        
        var table: String? { return "SwiftyWeatherApp" }
    }
}
