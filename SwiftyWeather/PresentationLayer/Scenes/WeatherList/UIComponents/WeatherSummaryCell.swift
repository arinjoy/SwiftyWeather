//
//  WeatherSummaryCell.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 24/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SnapKit

/// Represents a custom `TableViewCell` for showing weather summary in the list
/// Note: This class is totally written progrmamatically for UI elements for auto layouts wiithout any Xib or IB file.
final class WeatherSummaryCell: UITableViewCell {
    
    // MARK: - UI Element Properties
    
    private lazy var containerCardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.titleFont
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Font.titleFont
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var weatherIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        buildUIAndApplyConstraints()
        
        containerCardView.backgroundColor = Theme.Color.backgroundColor
        contentView.backgroundColor = Theme.Color.lightBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        weatherIconView.image = nil
    }
    
    // MARK: - Private Helpers
    
    private func buildUIAndApplyConstraints() {
        
        containerCardView.addSubview(cityNameLabel)
        containerCardView.addSubview(weatherIconView)
        containerCardView.addSubview(temperatureLabel)
        
        contentView.addSubview(containerCardView)
        containerCardView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerCardView.snp.leading).offset(20)
            make.top.equalTo(containerCardView.snp.top).offset(16)
            make.bottom.equalTo(containerCardView.snp.bottom).offset(-16)
            make.width.lessThanOrEqualTo(containerCardView.snp.width).multipliedBy(0.7)
        }

        weatherIconView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerX.equalTo(containerCardView.snp.centerX).multipliedBy(1.15)
            make.centerY.equalTo(containerCardView.snp.centerY)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerCardView.snp.trailing).offset(-20)
            make.top.equalTo(containerCardView.snp.top).offset(16)
            make.bottom.equalTo(containerCardView.snp.bottom).offset(-16)
        }
    }
    
    private func applyContainerStyle() {
        Shadow(color: Theme.Color.primaryTextColor,
               opacity: 0.3, blur: 4,
               offset: CGSize(width: 0, height: 2))
            .apply(toView: containerCardView)
        containerCardView.layer.cornerRadius = 8.0
    }
}

// MARK: - Configuration

extension WeatherSummaryCell {
    
    func configure(withPresentationItem item: WeatherSummaryPresentationItem) {
        
        cityNameLabel.text = item.cityName
        temperatureLabel.text = item.currentTemperature
    
        // Note: Ideally colors can be passed via presentation items or view models
        // or even text string, font & colour can be combined as NSAttributed string
        cityNameLabel.textColor = Theme.Color.primaryTextColor
        temperatureLabel.textColor = Theme.Color.primaryTextColor
        
        weatherIconView.image = nil
        if let iconURL = item.iconURL {
            weatherIconView.downloadedImage(fromURL: iconURL)
        }
        
        applyContainerStyle()
        
        contentView.isAccessibilityElement = true
        item.accessibility?.apply(to: contentView)
    }
}

