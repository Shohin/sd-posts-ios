//
//  PostListInputData.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostListInputData: InputData {
    public private(set) var items: Array<PostItemInputData> = []
    public var pagination: Pagination!
    
    public var hasNextPage: Bool {
        return self.pagination.hasNext
    }
    
    public var hasPrevPage: Bool {
        return self.pagination.hasPrev
    }
    
    public var isEmpty: Bool {
        return self.items.isEmpty
    }
    
    public var isFull: Bool {
        return !self.isEmpty
    }
    
    public func set(items: Array<PostItemInputData>) {
        self.items = items
    }
    
    public func add(items: Array<PostItemInputData>, isStart: Bool) {
        self.items = isStart ? items + self.items : self.items + items
    }
    
    public func nextPage() {
        self.pagination.next()
    }
    
    public func prevPage() {
        self.pagination.prev()
    }
    
    public func clear() {
        self.items = []
        self.pagination = nil
    }
}
