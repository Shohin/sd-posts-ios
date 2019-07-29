//
//  CLoadMoreDataTableViewCell.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/29/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

final public class CLoadMoreDataTableViewCell: UITableViewCell {
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    private let titleLabel: UILabel = UILabel()
    
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.contentView.addSubview(self.activityIndicator)
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.text = "Loading..."
        self.contentView.addSubview(self.titleLabel)
        
        self.layout()
    }
    
    private func layout() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalTo: self.activityIndicator.heightAnchor, multiplier: 1).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.activityIndicator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        self.activityIndicator.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -10).isActive = true

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    public func startAnimating() {
        self.activityIndicator.startAnimating()
    }
}
