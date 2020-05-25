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

final class WeatherListViewController: UITableViewController {

    // MARK: - IB Outlets
    
   // @IBOutlet private weak var tableView: UITableView!
    
    private lazy var refresherControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Theme.tintColor
        return refreshControl
    }()
    
    
    // MARK: - Private Properties
    
    private var diffableDataSource: CityWeatherTableViewDiffableDataSource!
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    /// The presenter conforming to the `FactsListPresenting`
    private lazy var presenter: WeatherListPresenting = {
        
        /**
         Tech note:
         A chain of depdendency injection layer by layer, and each layer is individually unit tested
         Ideally this depdendency injection can be done via 3rd party library like `Swinject`
         */
        
        let presenter = WeatherListPresenter(interactor:
            WeatherInteractor(
                weatherFetchingService: WeatherFetchingServiceClient(
                    dataSource: HTTPClient.shared
                )
            )
        )
        presenter.display = self
        return presenter
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        refreshControl?.beginRefreshing()
        refreshWeatherData()
    }
    
    // MARK: - Private Helpers
    
    private func setupTableView() {
        view.backgroundColor = Theme.lightBackgroundColor
        tableView.backgroundColor = Theme.lightBackgroundColor
        tableView.register(WeatherSummaryCell.self, forCellReuseIdentifier: "WeatherSummaryCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Theme.tintColor
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        
        diffableDataSource = CityWeatherTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, weatherSummaryPresentationItem) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryCell",
                                                           for: indexPath) as? WeatherSummaryCell
            else { return UITableViewCell() }
            cell.configure(withPresentationItem: weatherSummaryPresentationItem)
            return cell
        }
    }
    
    @objc
    private func refreshWeatherData() {
        presenter.loadCurrentWeatherOfCities(isRereshingNeeded: true)
    }
}

extension WeatherListViewController: WeatherListDisplay {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setWeatherListDataSource(_ dataSource: WeatherListDataSource) {
        diffableDataSource.apply(dataSource, animatingDifferences: false)
    }
    
    func showLoadingIndicator() {
        // TODO: Show shimmers
    }
    
    func hideLoadingIndicator() {
        refreshControl?.endRefreshing()
        // TODO: Hide shimmers
    }
    
    func showError(title: String, message: String, dismissTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(title: dismissTitle, style: .cancel))
        
        present(alertController, animated: true, completion: nil)
    }
}

class CityWeatherTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, WeatherSummaryPresentationItem> {
}


