//
//  WeatherSummaryPresentationItem.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct WeatherSummaryPresentationItem {
    
    // Note: Ideally these view model properties can be just more than flat string.
    // They can be NSAttributedString to capture text as well as font, style and color.
    // The relevant tranformers should have knowledge about the styles and create attributed strings
    // to simply passed around so that they can be attached to the UI labels to directly get the desired style
    
    let cityName: String
    let currentTemperature: String
    
    var accessibility: AccessibilityConfiguration?
    
    init(cityName: String,
         currentTemperature: String,
         accessibility: AccessibilityConfiguration? = nil
    ) {
        self.cityName = cityName
        self.currentTemperature = currentTemperature
        self.accessibility = accessibility
    }
}

