//
//  WeatherListDisplay.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 25/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

protocol WeatherListDisplay: class {
    
    /// Will set the view title in navigation bar
    ///
    /// - Parameter title: The title to set
    func setTitle(_ title: String)
    
    /// Will be called to update the list UI
    func updateList()
    
    /// Will show loading indicator while weather is fetched
    func showLoadingIndicator()
    
    /// Will hide the loading indicator
    func hideLoadingIndicator()
    
    /// Will be called to show an error alert
    /// - Parameters:
    ///   - title: The title string of the error
    ///   - message: The body string of the error
    ///   - dismissTitle: The dismiss action title string of the error
    func showError(title: String, message: String, dismissTitle: String)
}

