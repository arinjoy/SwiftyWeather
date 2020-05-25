//
//  AppDelegate.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 23/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        applyThemeStyles()
        
        window?.rootViewController = UINavigationController(rootViewController: WeatherListViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    private func applyThemeStyles() {
        window?.backgroundColor = Theme.backgroundColor
        window?.tintColor = Theme.tintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: Theme.titleFont,
                                                            NSAttributedString.Key.foregroundColor: Theme.primaryTextColor, ]
    }
}
