//
//  WeatherSummaryPresentationItem.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct WeatherSummaryPresentationItem: Hashable {
    
    // Note: Ideally these view model properties can be just more than flat strings.
    // They can be NSAttributedString to capture text as well as font, style and color.
    // The relevant tranformers should have knowledge about the styles and create attributed
    // strings to simply pass around so that they can be attached to the UI labels to directly
    // get the desired style
    
    let cityName: String
    let currentTemperature: String
    let iconURL: URL?
    
    var accessibility: AccessibilityConfiguration?
    
    init(cityName: String,
         currentTemperature: String,
         iconURL: URL?,
         accessibility: AccessibilityConfiguration? = nil
    ) {
        self.cityName = cityName
        self.currentTemperature = currentTemperature
        self.iconURL = iconURL
        self.accessibility = accessibility
    }
    
    // MARK: - Hashable
    
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: WeatherSummaryPresentationItem, rhs: WeatherSummaryPresentationItem) -> Bool {
        return lhs.cityName == rhs.cityName && lhs.currentTemperature == rhs.currentTemperature
    }
}

