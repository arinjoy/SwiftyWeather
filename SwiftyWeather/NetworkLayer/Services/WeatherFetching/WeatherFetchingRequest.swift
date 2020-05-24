//
//  Request.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

final class WeatherFetchingRequest: BaseRequest {
    
    var urlRequest: URLRequest
    
    init(withCityIDs cityIDs: [String]) {

        var urlComp = URLComponents(string: Constant.ApiConfig.serverPath)!
        var items = [URLQueryItem]()
        for (key, value) in WeatherFetchingRequest.buildQueryParams(withCityIds: cityIDs) {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
          urlComp.queryItems = items
        }

        urlRequest = URLRequest(url: urlComp.url!)
        
        urlRequest.httpMethod = HTTPRequestMethod.get.rawValue
        
        // Set 10 seconds timeout for the request,
        // otherwise defaults to 60 seconds which is too long.
        // This also helps in custom error handling to test
        urlRequest.timeoutInterval = 10.0
        
        
        // Configure anyhting else for this request in future if needed
    }
    
    
    // MARK: - Private Helpers
    
    private static func buildQueryParams(withCityIds cityIds: [String]) -> [String: String] {
        return [
            "id": cityIds.joined(separator: ","),
            "units": Constant.ApiConfig.weatherUnit,
            "APPID": Constant.ApiConfig.apiKey
        ]
    }
}

// Note: More requests can be built with other methods.
// E.g. detailed information, hourly forecast, historical data etc. as per Open Weather Map API offerings
