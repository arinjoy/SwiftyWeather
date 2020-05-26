//
//  DataSource.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// An instance conforming to the `DataSourceProtocol` will represent a source of items
/// to be displayed in either a `UICollectionView` or `UITableView`

public protocol DataSourceProtocol {
    
    // MARK: Associated type
    
    /// The type of items in the data source
    associatedtype Item
    
    // MARK: - Getters
    
    /// The total number of sections
    ///
    /// - Returns: Int
    func numberOfSections() -> Int
    
    /// Will return the total number of items in the section at the given index
    ///
    /// - Parameter section: The index of the section
    /// - Returns: Int
    func numberOfItems(inSection section: Int) -> Int
    
    /// Will return the items in the section at the given index
    ///
    /// - Parameter section: The section index
    /// - Returns: Array or `nil`.
    func items(inSection section: Int) -> [Item]?
    
    /// Will return the item at the given `row` inside the section at the given index
    ///
    /// - Parameters:
    ///   - row: The index of the item
    ///   - section: The index of the section
    /// - Returns: Item or `nil`.
    func item(atRow row: Int, inSection section: Int) -> Item?
    
    /// Will return the currently stored `headerTitle` for the section at the given index
    ///
    /// - Parameter section: The section index
    /// - Returns: String or `nil`
    func headerTitle(forSection section: Int) -> String?
    
    /// Will return the currently stored `footerTitle` for the section at the given index
    ///
    /// - Parameter section: The section index
    /// - Returns: String or `nil`
    func footerTitle(forSection section: Int) -> String?
}

// MARK: - Default behaviours

extension DataSourceProtocol {
    
    /// Will return the item at the given `indexPath` within the data source
    ///
    /// - Parameter indexPath: The index path of the item to retrieve
    /// - Returns: Item or `nil`
    public func item(atIndexPath indexPath: IndexPath) -> Item? {
        return item(atRow: indexPath.row, inSection: indexPath.section)
    }
}

/// A concrete `DataSource` instance that can handle the majority of table/collection data structures.
public struct DataSource<Section: DataSectionProtocol>: DataSourceProtocol {
    
    // MARK: - Public properties
    
    /// An array of sections managed by the data source.
    public var sections: [Section]
    
    // MARK: - Lifecycle
    
    /// Will initialize a new DataSource with the given sections.
    ///
    /// - Parameter sections: The sections to manage. Default is empty.
    public init(sections: [Section] = []) {
        self.sections = sections
    }
    
    // MARK: - DataSourceProtocol
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfItems(inSection section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].items.count
    }
    
    public func items(inSection section: Int) -> [Section.Item]? {
        guard section < sections.count else { return nil }
        return sections[section].items
    }
    
    public func item(atRow row: Int, inSection section: Int) -> Section.Item? {
        guard let items = items(inSection: section) else { return nil }
        guard row < items.count else { return nil }
        return items[row]
    }
    
    public func headerTitle(forSection section: Int) -> String? {
        guard section < sections.count else { return nil }
        return sections[section].headerTitle
    }
    
    public func footerTitle(forSection section: Int) -> String? {
        guard section < sections.count else { return nil }
        return sections[section].footerTitle
    }
    
    // MARK: Subscript
    
    /// Will return the section at the given index
    ///
    /// - Parameter index: The index of a section.
    /// - Returns: The section at the `index`
    public subscript(index: Int) -> Section {
        get {
            return sections[index]
        }
        set {
            sections[index] = newValue
        }
    }
    
    /// Will return the item at the given `IndexPath`
    ///
    /// - Parameter indexPath: The `IndexPath` of the item
    /// - Returns: The item at the `indexPath`
    public subscript(indexPath: IndexPath) -> Section.Item {
        get {
            return sections[indexPath.section].items[indexPath.row]
        }
        set {
            sections[indexPath.section].items[indexPath.row] = newValue
        }
    }
}


