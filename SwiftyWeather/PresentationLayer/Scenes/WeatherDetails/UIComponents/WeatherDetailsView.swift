//
//  WeatherDetailsView.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SnapKit

final class WeatherDetailView: UIView {
    
    // MARK: - UI properties
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var temperatureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var minTemperatureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var minTemperaturePrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.minTempPrefix.localized()
        return label
    }()
    
    private lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var maxTemperatureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var maxTemperaturePrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.maxTempPrefix.localized()
        return label
    }()
    
    /// The reference to the wrapper stakc view to attach parent container accessbility
    private var currentTemperatureStackView: UIStackView = UIStackView()
    private var minTemperatureStackView: UIStackView = UIStackView()
    private var maxTemperatureStackView: UIStackView = UIStackView()
    private var humidityStackView: UIStackView = UIStackView()
    private var windSpeedStackView: UIStackView = UIStackView()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let humidityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let humidityPrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.humidityPrefix.localized()
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let windSpeedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let windSpeedPrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.windSpeedPreix.localized()
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildUIAndApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Helpers
    
    private func buildUIAndApplyConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [shortDescriptionLabel])
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.distribution = .fill
        topStackView.spacing = 10
        
        for view in [temperatureIcon, temperatureLabel] {
            currentTemperatureStackView.addArrangedSubview(view)
        }
        currentTemperatureStackView.axis = .horizontal
        currentTemperatureStackView.spacing = 20
        
        for view in [minTemperatureIcon, minTemperaturePrefixLabel, minTemperatureLabel] {
            minTemperatureStackView.addArrangedSubview(view)
        }
        minTemperatureStackView.axis = .horizontal
        minTemperatureStackView.spacing = 20
        
        for view in [maxTemperatureIcon, maxTemperaturePrefixLabel, maxTemperatureLabel] {
            maxTemperatureStackView.addArrangedSubview(view)
        }
        maxTemperatureStackView.axis = .horizontal
        maxTemperatureStackView.spacing = 20
        
        for view in [humidityIcon, humidityPrefixLabel, humidityLabel] {
            humidityStackView.addArrangedSubview(view)
        }
        humidityStackView.axis = .horizontal
        humidityStackView.spacing = 20
        
        for view in [windSpeedIcon, windSpeedPrefixLabel, windSpeedLabel] {
            windSpeedStackView.addArrangedSubview(view)
        }
        windSpeedStackView.axis = .horizontal
        windSpeedStackView.spacing = 20
        
        let padderView = UIView()
        
        let bottomStackView = UIStackView(arrangedSubviews: [currentTemperatureStackView,
                                                             minTemperatureStackView,
                                                             maxTemperatureStackView,
                                                             UIView(),
                                                             humidityStackView,
                                                             windSpeedStackView])
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .trailing
        bottomStackView.distribution = .fill
        bottomStackView.spacing = 20
        
        let wrapperStackView = UIStackView(arrangedSubviews: [topStackView,
                                                              bottomStackView])
        wrapperStackView.axis = .vertical
        wrapperStackView.distribution = .fill
        wrapperStackView.alignment = .fill
        wrapperStackView.spacing = 20
        addSubview(wrapperStackView)
        
        padderView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.width.equalTo(1)
        }
        
        temperatureIcon.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        for imageView in [minTemperatureIcon,
                          maxTemperatureIcon,
                          humidityIcon,
                          windSpeedIcon] {
            imageView.snp.makeConstraints { make in
                make.width.equalTo(35)
                make.height.equalTo(35)
            }
        }
        
        wrapperStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        applyThemeColors()
    }
    
    // MARK: - Private Helpers
    
    private func applyThemeColors() {
        backgroundColor = Theme.Color.lightBackgroundColor

        shortDescriptionLabel.textColor = Theme.Color.secondaryTextColor

        temperatureLabel.textColor = Theme.Color.primaryTextColor

        minTemperaturePrefixLabel.textColor = Theme.Color.primaryTextColor
        minTemperatureLabel.textColor = Theme.Color.secondaryTextColor

        maxTemperaturePrefixLabel.textColor = Theme.Color.primaryTextColor
        maxTemperatureLabel.textColor = Theme.Color.secondaryTextColor

        humidityPrefixLabel.textColor = Theme.Color.primaryTextColor
        humidityLabel.textColor = Theme.Color.secondaryTextColor

        windSpeedPrefixLabel.textColor = Theme.Color.primaryTextColor
        windSpeedLabel.textColor = Theme.Color.secondaryTextColor
    }
    
    private func applyAccessbility(_ accessibility: WeatherDetailsPresentationItem.Accessibility?) {
        currentTemperatureStackView.isAccessibilityElement = true
        accessibility?.currentTemperatureAccessibility.apply(to: currentTemperatureStackView)
        
        minTemperatureStackView.isAccessibilityElement = true
        accessibility?.minTemperatureAccessibility.apply(to: minTemperatureStackView)
        
        maxTemperatureStackView.isAccessibilityElement = true
        accessibility?.maxTemperatureAccessibility.apply(to: maxTemperatureStackView)
        
        humidityStackView.isAccessibilityElement = true
        accessibility?.humidityAccessibility.apply(to: humidityStackView)
        
        windSpeedStackView.isAccessibilityElement = true
        accessibility?.windSpeedAccessibility.apply(to: windSpeedStackView)
    }
}

// MARK: - Configuration

extension WeatherDetailView {
    
    func configure(withPresentationItem item: WeatherDetailsPresentationItem) {
        
        shortDescriptionLabel.text = item.shortDescription
        
        temperatureLabel.text = item.temperature
        temperatureIcon.image = item.temperatureIcon
        
        minTemperatureLabel.text = item.minTemperature
        minTemperatureIcon.image = item.minTemperatureIcon
        
        maxTemperatureLabel.text = item.maxTemperature
        maxTemperatureIcon.image = item.maxTemperatureIcon
        
        humidityLabel.text = item.humidity
        humidityIcon.image = item.humidityIcon
        
        windSpeedLabel.text = item.windSpeed
        windSpeedIcon.image = item.windSpeedIcon
        
        if item.windSpeed == nil {
            windSpeedStackView.isHidden = true
        }
        
        applyAccessbility(item.accessibility)
        
        shortDescriptionLabel.startBlink()
        temperatureLabel.startBlink()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.shortDescriptionLabel.stopBlink()
            self.temperatureLabel.stopBlink()
        }
    }
}
