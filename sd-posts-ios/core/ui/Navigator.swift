//
//  Navigator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

public protocol Navigation {
    
}

public protocol Navigator {
    associatedtype N: Navigation
}
