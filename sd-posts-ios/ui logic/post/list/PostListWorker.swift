//
//  PostListWorker.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

public protocol PostListWorker: Worker {
    typealias EmptyCompletion = (() -> ())
    typealias InsertionCompletion = ((Int) -> ())
    var input: PostListInputData {get}
    func load(completion: @escaping EmptyCompletion)
    func insertEverySecond(completion: @escaping InsertionCompletion)
    func clear(completion: @escaping EmptyCompletion)
}

extension PostListWorker {
    public func loadNew(completion: @escaping EmptyCompletion) {
        self.input.clear()
        self.load(completion: completion)
    }
}
