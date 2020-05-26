//
//  City.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

struct City: Decodable {
    
    let identifier: Int?
    let name: String?
    let coordinate: Coordinate?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case coordinate = "coord"
        case country = "country"
    }
}

struct Coordinate: Decodable {
    
    let longitude: Double?
    let latitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

