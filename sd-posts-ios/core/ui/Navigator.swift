//
//  Navigator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

public protocol Navigation {
    
}

public protocol Navigator {
    associatedtype N: Navigation
    func viewController(for navigation: N, object: Any?) -> UIViewController!
    func navigate(for navigation: N, from: UIViewController, to: UIViewController?, object: Any?)
}

extension Navigator {
    public func navigate(for navigation: N, from: UIViewController, object: Any? = nil) {
        self.navigate(for: navigation, from: from, to: self.viewController(for: navigation, object: object), object: object)
    }
}
