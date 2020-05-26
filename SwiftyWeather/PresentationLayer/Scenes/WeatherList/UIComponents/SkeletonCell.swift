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
    
    private lazy var containerCardView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
        
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 10
        label.textAlignment = .left
        label.font = Theme.Font.bodyFont
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 10
        label.textAlignment = .right
        label.font = Theme.Font.bodyFont
        return label
    }()

    
    // MARK: - Constants
    
    private enum Constants {
        static let shimmerWidth: CGFloat = UIScreen.main.bounds.width / 2 - 48
        static let cellMargin: CGFloat = 16
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier ?? SkeletonCell.cellReuseIdentifier)
        
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        buildUIAndApplyConstraints()
        
        containerCardView.backgroundColor = Theme.Color.backgroundColor
        contentView.backgroundColor = Theme.Color.lightBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Helpers
    
    private func buildUIAndApplyConstraints() {
    
        label1.text = String(repeating: " ", count: 300)
        label2.text = String(repeating: " ", count: 300)
        
        containerCardView.addSubview(label1)
        containerCardView.addSubview(label2)
        
        contentView.addSubview(containerCardView)
        containerCardView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(Constants.cellMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.cellMargin)
            make.top.equalTo(contentView.snp.top).offset(Constants.cellMargin/2)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.cellMargin/2)
        }
        
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.cellMargin)
            make.bottom.equalToSuperview().offset(-Constants.cellMargin)
            make.width.equalTo(Constants.shimmerWidth)
            make.leading.equalToSuperview().offset(Constants.cellMargin)
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.cellMargin)
            make.bottom.equalToSuperview().offset(-Constants.cellMargin)
            make.width.equalTo(Constants.shimmerWidth)
            make.trailing.equalToSuperview().offset(-Constants.cellMargin)
        }
        
        Shadow(color: Theme.Color.primaryTextColor,
               opacity: 0.3, blur: 4,
               offset: CGSize(width: 0, height: 2))
            .apply(toView: containerCardView)
        containerCardView.layer.cornerRadius = 8.0
    }
}

