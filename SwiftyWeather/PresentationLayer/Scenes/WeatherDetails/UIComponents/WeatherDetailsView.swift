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
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    /// The reference to the wrapper stack view to attach parent container accessibility
    private var currentTemperatureStackView: UIStackView = UIStackView()
    private var minTemperatureStackView: UIStackView = UIStackView()
    private var maxTemperatureStackView: UIStackView = UIStackView()
    private var humidityStackView: UIStackView = UIStackView()
    private var windSpeedStackView: UIStackView = UIStackView()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var humidityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var humidityPrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.humidityPrefix.localized()
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var windSpeedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var windSpeedPrefixLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = StringKeys.SwiftyWeatherApp.windSpeedPreix.localized()
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Constants
    
    enum Constant {
        static let weatherAnimationTranlationLength = UIScreen.main.bounds.width / 2
    }
    
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
        let topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.distribution = .fill
        topStackView.spacing = 10
        
        topStackView.addArrangedSubview(shortDescriptionLabel)
        topStackView.addArrangedSubview(weatherIcon)
        
        weatherIcon.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(110)
        }
        
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
        wrapperStackView.spacing = 0
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
    
    private func animateKeyElements() {
        shortDescriptionLabel.startBlink()
        temperatureLabel.startBlink()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.shortDescriptionLabel.stopBlink()
            self.temperatureLabel.stopBlink()
        }
        
        UIView.animate(
            withDuration: 5.0,
            delay: 0.0,
            options: [.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
            animations: {
                self.weatherIcon.layer.transform = CATransform3DMakeTranslation(Constant.weatherAnimationTranlationLength, 0, 0)
            },
            completion: nil)
        
    }
}

// MARK: - Configuration

extension WeatherDetailView {
    
    func configure(withPresentationItem item: WeatherDetailsPresentationItem) {
        
        shortDescriptionLabel.text = item.shortDescription
        
        if let iconURL = item.iconURL {
            weatherIcon.isHidden = false
            weatherIcon.downloadImage(fromURL: iconURL)
        } else {
            weatherIcon.isHidden = true
        }
        
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
        
        animateKeyElements()
    }
}
