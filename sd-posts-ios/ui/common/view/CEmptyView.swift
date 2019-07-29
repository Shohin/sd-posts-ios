//
//  CEmptyView.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/29/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

final public class CEmptyView: UIView {
    private let titleLabel: UILabel = UILabel()
    
    public var text: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.white
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(self.titleLabel)
        self.layout()
    }
    
    private func layout() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
