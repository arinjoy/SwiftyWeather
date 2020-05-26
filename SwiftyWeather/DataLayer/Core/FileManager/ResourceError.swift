//
//  ResourceError.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

public enum ResourceError: Error {
    
    /// When the file / resource was not found
    case notFound
    
    /// When the resource file cannot be converted to desired type
    case dataConversionFailed
}
