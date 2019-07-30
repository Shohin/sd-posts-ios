//
//  AppNavigator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/30/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit

public enum AppNavigation: Navigation {
    case postList
}

public struct AppNavigator: Navigator {
    public typealias N = AppNavigation
    
    public func viewController(for navigation: AppNavigation, object: Any?) -> UIViewController! {
        switch navigation {
        case .postList:
            let initializer = PostListInitializer(worker: PostListApiWorker(repository: PostSqliteRepo()))
            let navCon = UINavigationController(rootViewController: initializer.controller)
            return navCon
        }
    }
    
    public func navigate(for navigation: AppNavigation, from: UIViewController, to: UIViewController?, object: Any?) {
        switch navigation {
        case .postList:
            app.changeWindow(rootController: to!)
        }
    }
}
