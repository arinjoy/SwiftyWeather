//
//  DataSection.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 27/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// Instances conforming to the `DataSectionProtocol` will represent
/// a section of items with an optional header or footer title.
public protocol DataSectionProtocol {
    
    // MARK: - Associated type
    
    associatedtype Item
    
    // MARK: - Properties
    
    /// Optional identifier for use with `Equatable` and `Hashable`
    var identifier: String? { get set }
    
    /// The items managed by the section
    var items: [Item] { get set }
    
    /// The header title for the section
    var headerTitle: String? { get }
    
    /// The footer title for the section
    var footerTitle: String? { get }
}

/// A concrete `DataSectionProtocol` instance
public struct DataSection<Item>: DataSectionProtocol {
    
    // MARK: - Properties
    
    /// Optional identifier for the section
    public var identifier: String?
    
    /// The items in the section.
    public var items: [Item]
    
    /// The header title for the section
    public let headerTitle: String?
    
    /// The footer title for the section
    public let footerTitle: String?
    
    /// The total number of items currently in the section
    public var count: Int {
        return items.count
    }
    
    // MARK: - Lifecycle
    
    /// Will return a new `Section` struct.
    ///
    /// - Parameters:
    ///   - items: The items to manage
    ///   - headerTitle: The header title string
    ///   - footerTitle: The footer title string
    ///   - identifier: Optional section identifier
    public init(
        items: [Item],
        headerTitle: String? = nil,
        footerTitle: String? = nil,
        identifier: String? = nil
    ) {
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.identifier = identifier
    }
    
    // MARK: - Subscript
    
    /// Subscript logic
    ///
    /// - Parameter index: The index of the item to return
    /// - Returns: The item at the given `index`
    public subscript(index: Int) -> Item {
        get {
            return items[index]
        }
        set {
            items[index] = newValue
        }
    }
}


