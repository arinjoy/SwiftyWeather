//
//  Theme+Icon.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

extension Theme {
    
    enum Icon: String {
        
        case weather = "weather-icon"
        case weatherFilled = "weather-icon-filled"
        
        case thermoTemp = "temperature-icon"
        case minTemp = "min-temp-icon"
        case maxTemp = "max-temp-icon"
        
        case cloudHumid = "cloud-humid-icon"
        case wind = "wind-icon"
        
        var icon: UIImage {
            guard let image = UIImage(named: self.rawValue)
            else {
              fatalError("Image resource \(self.rawValue) cannot be loaded")
            }
            return image.withRenderingMode(.alwaysTemplate)
        }
    }
}
