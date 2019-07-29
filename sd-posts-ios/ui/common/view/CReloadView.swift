//
//  CReloadView.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/29/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

final public class CReloadView: UIView {
    private let titleLabel: UILabel = UILabel()
    private let reloadButton: UIButton = UIButton()
    
    public var reload: (() -> ())?
    
    public var title: String? {
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
        self.layout()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.white
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 2
        self.addSubview(self.titleLabel)
        
        self.reloadButton.setTitle("Reload", for: .normal)
        self.reloadButton.setTitleColor(UIColor.black, for: .normal)
        self.reloadButton.layer.cornerRadius = 5
        self.reloadButton.clipsToBounds = true
        self.reloadButton.layer.borderWidth = 1
        self.reloadButton.layer.borderColor = UIColor.gray.cgColor
        self.reloadButton.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
        self.addSubview(self.reloadButton)
    }
    
    private func layout() {
        let size = self.frame.size
        var x: CGFloat = 5
        var y: CGFloat = 0.4 * size.height
        var w: CGFloat = size.width - 2 * x
        var h: CGFloat = 50
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 200
        h = 50
        x = (size.width - w) / 2
        y = self.titleLabel.frame.maxY + 15
        self.reloadButton.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    //MARK: actions
    @objc
    private func reloadAction() {
        self.reload?()
    }
}
