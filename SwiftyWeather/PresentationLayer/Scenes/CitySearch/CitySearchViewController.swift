//
//  CitySearchViewController.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class CitySearchViewController: UIViewController {
    
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var cityList: [City] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resource: Resource<[City]> = Resource(fileName: "cityList")
        FileResourceManager()
            .load(fromResource: resource)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] cityList in
                print(cityList)
                self?.cityList = cityList
                self?.tableView.reloadData()
            })
            .store(in: &cancellableSet)
    }
}

