//
//  PostSqliteRepo.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostSqliteRepo: PostRepository {
    public typealias S = PostSqliteDataSource
    
    public let repository: PostSqliteDataSource = PostSqliteDataSource()
    
    public func allCount(afterDate: Date?) -> Int {
        return self.repository.allCount(afterDate: afterDate)
    }
    
    public func fetch(pagination: Pagination?) -> Array<Post> {
        return self.repository.fetch(pagination: pagination)
    }
    
    public func insertEverySecond(completion: @escaping () -> ()) {
        self.repository.insertEverySecond(completion: completion)
    }
    
    public func clear(completion: @escaping () -> ()) {
        self.repository.clear(completion: completion)
    }
}
