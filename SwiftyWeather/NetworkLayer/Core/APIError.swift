//
//  APIError.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// An enumeration of potential API related error. This can be elaborated/tweaked in future.
public enum APIError: Error {
    
    // MARK: - Network / Connectivity
    
    /// When netowrk cannot be established
    case networkFailure
    
    /// When network call has timed out
    case timeout
    
    // MARK: - Server / Authentication
    
    /// When returns 5xx family of server errors
    case server
    
    /// When service is unaavailable. i.e. 503
    case seviceUnavailable
    
    /// When unauthoized due to bad credentials. i.e. 401
    case unAuthorized
    
    /// When access is forbidden i.e. 403
    case forbidden
    
    /// When api service is not found. i.e. 404
    case notFound
    
    // MARK: - Misc
    
    /// When api does not return data
    case noDataFound
    
    /// Data mapping/conversion error
    case dataConversionFailed
    
    /// Any unknown error happens
    case unknown
}

