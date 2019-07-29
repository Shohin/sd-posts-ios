//
//  PostTableViewCell.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

final public class PostTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let authorLabel: UILabel = UILabel()
    private let publishedAtLabel: UILabel = UILabel()
    
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.contentView.addSubview(self.titleLabel)
        
        self.authorLabel.numberOfLines = 1
        self.authorLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.authorLabel)
        
        self.publishedAtLabel.numberOfLines = 1
        self.publishedAtLabel.font = UIFont.systemFont(ofSize: 13)
        self.publishedAtLabel.textAlignment = .right
        self.contentView.addSubview(self.publishedAtLabel)
        
        self.layout()
    }
    
    private func layout() {
        let d: CGFloat = 10
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: d).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: d).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor, constant: -d).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.publishedAtLabel.leadingAnchor).isActive = true
        
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.authorLabel.trailingAnchor.constraint(equalTo: self.publishedAtLabel.leadingAnchor).isActive = true
        self.authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -d).isActive = true
        
        self.publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        self.publishedAtLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.publishedAtLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        self.publishedAtLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -d).isActive = true
    }
    
    public func populate(with item: PostItemInputData, indexPath: IndexPath) {
        self.titleLabel.text = item.title
        self.authorLabel.text = item.author
        self.publishedAtLabel.text = item.publishAtText
    }
}

