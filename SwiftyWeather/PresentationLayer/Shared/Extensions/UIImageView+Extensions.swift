//
//  UIImageView+Extensions.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Downloads an image from an URL and sets up with desired content aspect fitting mode
    func downloadedImage(fromURL url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        let urlRequest = URLRequest(url: url)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            // Check if the data already exists in the URL cache for this image URL request
            if let data = HTTPClient.shared.cache.cachedResponse(for: urlRequest)?.data {
                
                self?.attachImage(data)
            
            } else {
                
                HTTPClient.shared.defaultSession.dataTask(with: url) {
                    [weak self] data, response, error in
                    
                    if let httpURLResponse = response as? HTTPURLResponse,
                        httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType,
                        mimeType.hasPrefix("image"),
                        error == nil,
                        let responseData = data {
                        
                        // Set the fresh data into the URL cache
                        let cachedData = CachedURLResponse(response: httpURLResponse, data: responseData)
                        HTTPClient.shared.cache.storeCachedResponse(cachedData, for: urlRequest)
                        
                        self?.attachImage(responseData)
                    
                    } else {
                        self?.attachImage(nil)
                    }
                }.resume()
            }
        }
    }
    
    private func attachImage(_ data: Data?) {
        DispatchQueue.main.async {
            guard let imageData = data else {
                self.image = nil
                return
            }
            self.image = UIImage(data: imageData)
        }
    }
}
