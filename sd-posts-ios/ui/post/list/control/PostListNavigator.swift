//
//  PostListNavigator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

public enum PostListNavigation: Navigation {
    case alone
}

public struct PostListNavigator: Navigator {
    public typealias N = PostListNavigation
    
    public func viewController(for navigation: N, object: Any?) -> UIViewController! {
        switch navigation {
        case .alone:
            return nil
        }
    }
    
    public func navigate(for navigation: N, from: UIViewController, to: UIViewController?, object: Any?) {
        switch navigation {
        case .alone:
            break
        }
    }
}
