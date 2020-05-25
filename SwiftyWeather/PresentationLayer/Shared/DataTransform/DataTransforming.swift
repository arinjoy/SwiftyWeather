//
//  DataTransforming.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 25/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// `DataTransforming` conforming instances are responsible for taking an input domain model object
/// and returning a presentation/view model output type.
protocol DataTransforming {
    associatedtype Input
    associatedtype Output
    
    /// Will transform the given input into the associated output.
    ///
    /// - Parameter input: The domain model object to transform
    /// - Returns: The presentation item / view model object
    func transform(input: Input) -> Output
}

