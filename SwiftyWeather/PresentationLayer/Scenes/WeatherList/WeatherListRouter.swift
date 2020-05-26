//
//  WeatherListRouter.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 25/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit

protocol WeatherListRouting: class {
    
    /// Will route to the weather details scene
    ///
    /// - Parameter sceneModel: The scene model that is being passed from list to details scene
    func routeToWeatherDetails(withSceneModel sceneModel: CityWeather)
}

final class WeatherListRouter: WeatherListRouting {
    
    // MARK: - Injectables
    
    weak var sourceViewController: UIViewController?
    
    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }
    
    func routeToWeatherDetails(withSceneModel sceneModel: CityWeather) {
        let detailsViewController = WeatherDetailsViewController(sceneModel: sceneModel)
        sourceViewController?.show(detailsViewController, sender: nil)
    }
}

