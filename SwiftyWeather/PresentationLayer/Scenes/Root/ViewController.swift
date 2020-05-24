//
//  ViewController.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 23/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SnapKit
import SkeletonView
import Combine

final class ViewController: UIViewController {
    
    var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = StringKeys.SwiftyWeatherApp.viewLoadingTitle.localized()
        
        let service = WeatherFetchingServiceClient(dataSource: HTTPClient.shared)
        service.fetchWeather(forCityIDs: Constant.cityIDs)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { data in
                print(data)
            })
            .store(in: &cancellableSet)
        
    }
}

