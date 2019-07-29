//
//  PostListPresenter.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostListPresenter: Presenter {
    public let navigator = PostListNavigator()
    public let worker: PostListWorker
    public unowned let controller: PostListController
    public init(worker: PostListWorker,
                controller: PostListController) {
        self.worker = worker
        self.controller = controller
    }
    
    public var input: PostListInputData {
        return self.worker.input
    }
    
    public var items: Array<PostItemInputData> {
        return self.input.items
    }
    
    public var itemsCount: Int {
        return self.items.count
    }
    
    public var isFull: Bool {
        return self.input.isFull
    }
    
    public var isEmpty: Bool {
        return self.input.isEmpty
    }
    
    public func item(at index: Int) -> PostItemInputData {
        return self.items[index]
    }
    
    public func isOnEndList(index: Int) -> Bool {
        return index + 1 >= self.itemsCount
    }
    
    public func canShowLoadMoreCell(index: Int) -> Bool {
        return self.input.hasNextPage && self.isOnEndList(index: index)
    }
    
    public func load(completion: @escaping () -> ()) {
        self.worker.load(completion: completion)
    }
    
    public func loadNext(completion: @escaping () -> ()) {
        self.input.nextPage()
        self.load(completion: completion)
    }
    
    public func loadNew(completion: @escaping () -> ()) {
        self.worker.loadNew(completion: completion)
    }
    
    public func inserEverySecond(completion: @escaping (Int) -> ()) {
        self.worker.insertEverySecond(completion: completion)
    }
    
    public func clear(completion: @escaping () -> ()) {
        self.worker.clear {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
