//
//  WeatherListPresenter.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 25/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Combine

protocol WeatherListPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()
    
    /// Will load current weather status for a list of given cities
    ///
    /// - Parameter isRereshingNeeded: Whther data regreshing from API is needed
    func loadCurrentWeatherOfCities(isRereshingNeeded: Bool)
    
    /// Called when user taps an item form the weather list
    func didTapCityWeather(at index: Int)
    
    /// Start polling the weather fetching every ten seconds
    func startPollingWeather()
    
    /// Start polling the weather fetching when not needed
    func stopPollingWeather()
}

final class WeatherListPresenter: WeatherListPresenting {

    /// The front-facing view that conforms to the `WeatherListDisplay` protocol
    weak var display: WeatherListDisplay?
    
    /// The routing instance for the presenter
    var router: WeatherListRouting?
    
    // MARK: - Private Properties
    
    /// The interactor to fetch weather data of cities
    private let interactor: WeatherInteracting
    
    /// A Timer Publisher as per `Combine` that would events every X seconds which helps in periodic data refreshing
    var tenSecondsTimer: Timer.TimerPublisher!
    
    /// List of weather data fetched
    private var weatherListData: [CityWeather]?
    
    /// The data tranforming helper
    private let tranformer = WeatherListTransformer()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    
    init(interactor: WeatherInteracting) {
        self.interactor = interactor
    }
    
    // MARK: - WeatherListPresenting
    
    func viewDidBecomeReady() {
        display?.setTitle(StringKeys.SwiftyWeatherApp.viewTitle.localized())
    }
    
    func loadCurrentWeatherOfCities(isRereshingNeeded: Bool) {
        
        // If refreshing is not needed, early exit with rendering based on preloaded data
        guard isRereshingNeeded else {
            if let weatherList = weatherListData {
                handleUpdatingDataSource(weatherList)
            }
            return
        }
        
        display?.showLoadingIndicator()
        
        interactor.getWeather(forCityIDs: Constant.cityIDs)
        .sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.display?.hideLoadingIndicator()
                self?.handleError(error)
            }
        }, receiveValue: { [weak self] cityWeatherList in
            self?.display?.hideLoadingIndicator()
            self?.handleUpdatingDataSource(cityWeatherList)
        })
        .store(in: &cancellableSet)
    }
    
    func didTapCityWeather(at index: Int) {
        guard let weatherList = weatherListData,
            index < weatherList.count
        else { return }
        
        let weather = weatherList[index]
        router?.routeToWeatherDetails(withSceneModel: weather)
    }
    
    func startPollingWeather() {
        tenSecondsTimer = Timer.publish(every: 10, on: .main, in: .common)
        _ = tenSecondsTimer.connect()
        tenSecondsTimer
        .sink { _ in
            self.loadCurrentWeatherOfCities(isRereshingNeeded: true)
        }.store(in: &cancellableSet)
    }
    
    func stopPollingWeather() {
        tenSecondsTimer.connect().cancel()
    }
    
    // MARK: - Private Helpers
    
    private func handleUpdatingDataSource(_ input: [CityWeather]) {
        // Keep reference to the latest fetched weather data
        weatherListData = input
        
        let presentationItems = tranformer.transform(input: input)
        var dataSource = WeatherListDataSource()
        dataSource.appendSections([.main])
        dataSource.appendItems(presentationItems, toSection: .main)
        
        display?.setWeatherListDataSource(dataSource)
    }
    
    private func handleError(_ error: APIError) {
        let errorTitle: String = StringKeys.SwiftyWeatherApp.genericErrorTitle.localized()
        let errorDismissTitle: String = StringKeys.SwiftyWeatherApp.errorDismissTitle.localized()
        var errorMessage: String
        switch error {
            // Show network connectivity error
        case .networkFailure, .timeout:
            errorMessage = StringKeys.SwiftyWeatherApp.networkConnectionErrorMessage.localized()
        default:
            // For all other errors, show this generic error
            // This can be elaborated case by case basis of custom error handling
            errorMessage = StringKeys.SwiftyWeatherApp.genericErrorMessage.localized()
        }
        
        display?.showError(title: errorTitle,
                           message: errorMessage,
                           dismissTitle: errorDismissTitle)
    }
}

