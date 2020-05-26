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
    
    private lazy var refresherControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Theme.Color.tintColor
        return refreshControl
    }()
    
    
    // MARK: - Private Properties
    
    /// The data source attached to the table view
    private var diffableDataSource: CityWeatherTableViewDiffableDataSource!
    
    /// Subcribers cancellable set as dispose bags
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
        presenter.router = WeatherListRouter(sourceViewController: self)
        return presenter
    }()
    
    private lazy var skeletonGradient: SkeletonGradient = {
        return SkeletonGradient(baseColor: Theme.Color.shimmerBaseColor,
                                secondaryColor: Theme.Color.shimmerGradientColor)
    }()
    
    private lazy var skeletonAnimation: SkeletonLayerAnimation = {
        return SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        presenter.viewDidBecomeReady()
        presenter.loadCurrentWeatherOfCities(isRereshingNeeded: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.startPollingWeather()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.stopPollingWeather()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.layoutSkeletonIfNeeded()
    }

    // MARK: - Private Helpers
    
    private func setupTableView() {
        view.backgroundColor = Theme.Color.lightBackgroundColor
        tableView.backgroundColor = Theme.Color.lightBackgroundColor
        tableView.register(WeatherSummaryCell.self, forCellReuseIdentifier: "WeatherSummaryCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Theme.Color.tintColor
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        
        diffableDataSource = CityWeatherTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, weatherSummaryPresentationItem) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryCell",
                                                           for: indexPath) as? WeatherSummaryCell
            else { return UITableViewCell() }
            cell.configure(withPresentationItem: weatherSummaryPresentationItem)
            return cell
        }
        
        tableView.register(SkeletonCell.self,
                           forCellReuseIdentifier: SkeletonCell.cellReuseIdentifier)
        tableView.isSkeletonable = true
    }
    
    @objc
    private func refreshWeatherData() {
        presenter.loadCurrentWeatherOfCities(isRereshingNeeded: true)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCityWeather(at: indexPath.row)
    }
}

extension WeatherListViewController: SkeletonTableViewDataSource {

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.cityIDs.count
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SkeletonCell.cellReuseIdentifier
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
        refreshControl?.beginRefreshing()
        tableView.showAnimatedGradientSkeleton(usingGradient: skeletonGradient,
                                               animation: skeletonAnimation,
                                               transition: .crossDissolve(0.25))
    }
    
    func hideLoadingIndicator() {
        refreshControl?.endRefreshing()
        tableView.hideSkeleton()
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
