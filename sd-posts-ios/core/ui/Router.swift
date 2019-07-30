//
//  Router.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

/// Navigate Navigator by navigation

final public class Router {
    public typealias NavigationBlock = ((Navigation) -> Void)
    static let `default` = Router()
    private var didNavigateBlocks = [NavigationBlock] ()
    
    private init() {
        
    }
    
    public func navigate<N: Navigator>(with navigator: N, for navigation: N.N, from: UIViewController, object: Any? = nil) {
        navigator.navigate(for: navigation, from: from, object: object)
        for bl in self.didNavigateBlocks {
            bl(navigation)
        }
    }
    
    public func didNavigate(block: @escaping NavigationBlock) {
        didNavigateBlocks.append(block)
    }
}

public struct R {
    private init() {
        
    }
    
    public static func navigate<N: Navigator>(with navigator: N, for navigation: N.N, from: UIViewController, object: Any? = nil) {
        Router.default.navigate(with: navigator, for: navigation, from: from, object: object)
    }
    
    public static func didNavigate(block: @escaping Router.NavigationBlock) {
        Router.default.didNavigate(block: block)
    }
}
