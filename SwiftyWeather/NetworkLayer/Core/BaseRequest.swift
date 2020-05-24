//
//  BaseRequest.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

protocol BaseRequest {
    var urlRequest: URLRequest { get }
}

enum HTTPRequestMethod: String {
    
    /// GET method type
    case get = "GET"
    
    /// POST method type
    case post = "POST"
    
    /// PUT method type
    case put = "PUT"
    
    /// DELETE method type
    case delete = "DELETE"
    
    /// PATCH method type
    case patch = "PATCH"
}
