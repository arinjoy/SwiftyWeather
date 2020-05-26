//
//  WeatherDetailsViewController.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SnapKit

final class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    /// The scene model data to being passed along from previous context
    private var sceneModel: CityWeather
    
    /// The presenter conforming to the `WeatherDetailsPresenting`
    private var presenter: WeatherDetailsPresenting!
    
    /// The UI holding view for details
    private lazy var detailsView: WeatherDetailView = {
        return WeatherDetailView()
    }()
    
    // MARK: - Lifecycle
    
    required init(sceneModel: CityWeather) {
        self.sceneModel = sceneModel
        super.init(nibName: nil, bundle: Bundle(for: WeatherDetailsViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter = WeatherDetailsPresenter()

        // Injecting display & scene model weakly to the presenting instance
        // Note: Can be done via 3rd party Dependency Injection framework like `Swinject` and syntaxex could be simplified
        (presenter as? WeatherDetailsPresenter)?.display = self
        (presenter as? WeatherDetailsPresenter)?.sceneModel = sceneModel
        
        buildUIAndApplyConstraints()
        view.backgroundColor = Theme.lightBackgroundColor
        
        presenter.viewDidBecomeReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private Helpers
    
    private func buildUIAndApplyConstraints() {
        view.addSubview(detailsView)
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
}

// MARK: - WeatherDetailsDisplay

extension WeatherDetailsViewController: WeatherDetailsDisplay {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setViewDetails(withPresenetationItem item: WeatherDetailsPresentationItem) {
        detailsView.configure(withPresentationItem: item)
    }
}
