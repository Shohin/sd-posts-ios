//
//  PostListInitializer.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostListInitializer: Initializer {
    public static var newPostListController: PostListController {
        return PostListController()
    }
    
    public var controller: PostListController! = PostListInitializer.newPostListController
    
    public init(worker: PostListWorker) {
        self.initialize(worker: worker)
    }
    
    private func initialize(worker: PostListWorker) {
        let presenter = PostListPresenter(worker: worker, controller: self.controller)
        self.controller.presenter = presenter
    }
}
