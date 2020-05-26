//
//  TableView+DiffableDataSource.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

/// A section within the table view
enum Section {
    /// Just one main section
    case main
}

/// A `UITableViewDiffableDataSource` wrapper of `Section` and `WeatherSummaryPresentationItem`
/// to bind to the table UI
class CityWeatherTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, WeatherSummaryPresentationItem> {}

/// A type to represent snapshot within `CityWeatherTableViewDiffableDataSource`
typealias WeatherListDataSource = NSDiffableDataSourceSnapshot<Section, WeatherSummaryPresentationItem>


