//
//  CityWeatherListViewController.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 23/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SkeletonView
import Combine

enum Section {
    case main
}

final class CityWeatherListViewController: UITableViewController {
    
    
    // MARK: - IB Outlets
    
   // @IBOutlet private weak var tableView: UITableView!
    
    private lazy var refresherControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Theme.tintColor
        return refreshControl
    }()
    
    
    // MARK: - Private Properties
    
    var diffableDataSource: CityWeatherTableViewDiffableDataSource!
    
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        title = StringKeys.SwiftyWeatherApp.viewLoadingTitle.localized()
        
        refreshControl?.beginRefreshing()
        refreshWeatherData()
        
    }
    
    // MARK: - Private Helpers
    
    private func setupTableView() {
        tableView.backgroundColor = Theme.darkerBackgroundColor
        tableView.register(WeatherSummaryCell.self, forCellReuseIdentifier: "WeatherSummaryCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Theme.tintColor
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        
        diffableDataSource = CityWeatherTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, cityWeather) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryCell", for: indexPath) as! WeatherSummaryCell
            //cell.configure(withPresentationItem: WeatherSumm)
            cell.setup(cityWeather)
            return cell
        }
    }
    
    private func generateSnapshot(with cityWeatherList: [CityWeather]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CityWeather>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cityWeatherList, toSection: .main)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    private func refreshWeatherData() {
        let service = WeatherFetchingServiceClient(dataSource: HTTPClient.shared)
        let interactor = WeatherInteractor(weatherFetchingService: service)
        interactor.getWeather(forCityIDs: Constant.cityIDs)
        .sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                print(error)
            }
        }, receiveValue: { [weak self] cityWeatherList in
            print(cityWeatherList)
            self?.generateSnapshot(with: cityWeatherList)
            self?.refreshControl?.endRefreshing()
        })
        .store(in: &cancellableSet)
    }
}

class CityWeatherTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, CityWeather> {
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return snapshot().sectionIdentifiers[section].rawValue.uppercased()
//    }
}


