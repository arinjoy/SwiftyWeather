//
//  WeatherDetailsPresenter.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

protocol WeatherDetailsPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()
}

final class WeatherDetailsPresenter: WeatherDetailsPresenting {
    
    /// The front-facing view that conforms to the `WeatherDetailsDisplay` protocol
    weak var display: WeatherDetailsDisplay?
    
    /// The weather model it represents to show details
    var sceneModel: CityWeather?
    
    /// The data tranforming helper
    private let tranformer = WeatherDetailsTransformer()

    // MARK: - WeatherListPresenting
    
    func viewDidBecomeReady() {
        
        guard let weather = sceneModel else { return }
        
        display?.setTitle(weather.cityName)
        
        display?.setViewDetails(withPresenetationItem: tranformer.transform(input: weather))
    }
}


