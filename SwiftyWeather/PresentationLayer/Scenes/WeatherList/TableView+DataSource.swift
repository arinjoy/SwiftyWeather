//
//  TableView+DiffableDataSource.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit

typealias WeatherListDataSource = DataSource<DataSection<WeatherSummaryPresentationItem>>

// Note: Not using `UITableViewDiffableDataSource` as it does not support
// `SkeletonView` library to show shimmers. So rolling back Diffable data source
// code and putting in own abstractor code called `DataSource<DatSection<Item>>`


/// A section within the table view
enum Section {
    /// Just one main section
    case main
}

/// A `UITableViewDiffableDataSource` wrapper of `Section` and `WeatherSummaryPresentationItem`
/// to bind to the table UI
class CityWeatherTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, WeatherSummaryPresentationItem> {}

/// A type to represent snapshot within `CityWeatherTableViewDiffableDataSource`
typealias WeatherListsssDataSourcee = NSDiffableDataSourceSnapshot<Section, WeatherSummaryPresentationItem>


