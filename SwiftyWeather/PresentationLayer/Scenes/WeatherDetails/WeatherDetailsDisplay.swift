//
//  WeatherDetailsDisplay.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

protocol WeatherDetailsDisplay: class {
    
    /// Will set the view title in navigation bar
    ///
    /// - Parameter title: The title to set
    func setTitle(_ title: String)
    
    /// Will set view details with transformed presentation items
    ///
    /// - Parameter item: The presentation item to set
    func setViewDetails(withPresenetationItem item: WeatherDetailsPresentationItem)
}
