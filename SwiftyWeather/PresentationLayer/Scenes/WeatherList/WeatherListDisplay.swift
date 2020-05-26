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
    
    /// Will display the given data source as the primary display set
    ///
    /// - Parameter dataSource: The set of data to display (transformed view models as NSDiffableDataSource wrapper)
    func setWeatherListDataSource(_ dataSource: WeatherListDataSource)
    
    /// Will show loading indicator while weather is fetched
    func showLoadingIndicator()
    
    /// Will hide the loading indicator
    func hideLoadingIndicator()
    
    /// Will show an error alert
    func showError(title: String, message: String, dismissTitle: String)
}

