//
//  UIView+Extensions.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func startBlink() {
        UIView.animate(withDuration: 0.5,
              delay: 0.0,
              options: [.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
              animations: { self.alpha = 0.2 },
              completion: nil)
    }

    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}
