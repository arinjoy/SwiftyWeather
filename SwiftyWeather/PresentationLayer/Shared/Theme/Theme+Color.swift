//
//  Theme.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 23/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

struct Theme {}

extension Theme {
    
    // MARK: - Colors
    
    struct Color {
        
        static let skyBlueColor = UIColor.colorFrom(red: 64, green: 218, blue: 255)
        static let darkBlueColor = UIColor.colorFrom(red: 13, green: 10, blue: 36)
        
        static let backgroundColor =  UIColor(light: Theme.Color.skyBlueColor,
                                              dark: Theme.Color.darkBlueColor)
        static let lightBackgroundColor = UIColor(
            light: UIColor.colorFrom(red: 213, green: 249, blue: 255),
            dark: UIColor.colorFrom(red: 20, green: 34, blue: 95))
        
        static let tintColor = UIColor(light: .systemPurple,
                                       dark: .systemYellow)
        
        static let primaryTextColor = UIColor(
            light: Theme.Color.darkBlueColor,
            dark: UIColor.colorFrom(red: 246, green: 242, blue: 241))
        
        static let secondaryTextColor = Theme.Color.primaryTextColor.withAlphaComponent(0.75)
        
        static let shimmerBaseColor = Theme.Color.darkBlueColor
        
        static let shimmerGradientColor = UIColor(
            light: Theme.Color.shimmerBaseColor.withAlphaComponent(0.5),
            dark: Theme.Color.shimmerBaseColor.withAlphaComponent(0.8))
    }
}

private extension UIColor {
    static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

private extension UIColor {

    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}

