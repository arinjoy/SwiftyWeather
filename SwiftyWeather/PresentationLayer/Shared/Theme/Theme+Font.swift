//
//  Theme+Font.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

extension Theme {
    
    // MARK: - Fonts
    
    struct Font {
        
        static let titleFont = UIFont(name: "Avenir-Heavy", size: 26) ?? UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        static let bodyFont = UIFont(name: "Avenir", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .regular)
    }
}
