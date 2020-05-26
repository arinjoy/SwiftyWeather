//
//  SkeletonCell.swift
//  SwiftyWeather
//
//  Created by Arinjoy Biswas on 26/5/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

final class SkeletonCell: UITableViewCell {
    
    static let cellReuseIdentifier = "SkeletonCell"
    
    // MARK: - UI Element Properties
        
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 10
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 10
        return label
    }()

    
    // MARK: - Constants
    
    private enum Constants {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let cellMargin: CGFloat = 16
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier ?? SkeletonCell.cellReuseIdentifier)
        
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        buildUIAndApplyConstraints()
        
        contentView.backgroundColor = Theme.Color.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Helpers
    
    private func buildUIAndApplyConstraints() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.isSkeletonable = true
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        
        label1.text = String(repeating: " ", count: 300)
        label2.text = String(repeating: " ", count: 300)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(Constants.cellMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.cellMargin)//.priority(999)
            make.top.equalTo(contentView.snp.top).offset(Constants.cellMargin)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.cellMargin)//.priority(999)
        }
    }
}

