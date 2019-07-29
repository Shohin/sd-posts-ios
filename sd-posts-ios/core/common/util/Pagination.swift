//
//  Pagination.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class Pagination {
    public let totalCount: Int
    public let pageSize: Int
    public private(set) var currentPage: Int
    public let maxPage: Int
    public init(totalCount: Int,
                pageSize: Int,
                currentPage: Int = 1) {
        self.totalCount = totalCount
        self.pageSize = pageSize
        self.currentPage = currentPage
        self.maxPage = Int(ceil(Double(totalCount) / Double(pageSize)))
    }
    
    public var offset: Int {
        guard self.currentPage > 0 else {
            return 0
        }
        
        return (self.currentPage - 1) * self.pageSize
    }
    
    public var hasNext: Bool {
        return self.currentPage < self.maxPage
    }
    
    public var hasPrev: Bool {
        return self.currentPage > 1
    }
    
    public func next() {
        if self.hasNext  {
            self.currentPage = self.currentPage + 1
        }
    }
    
    public func prev() {
        if self.hasPrev {
            self.currentPage = self.currentPage - 1
        }
    }
}
