//
//  PostSqliteDataSource.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation
import GRDB

final public class PostSqliteDataSource: PostDataSource {
    public typealias I = Post
    
    private let backgroundTimer = BackgroundTimer(timeInterval: 1, isRepeating: true)
    
    private var dbQueue: DatabaseQueue {
        return app.dbQueue
    }
    
    public func allCount(afterDate: Date?) -> Int {
        do {
            let cnt = try self.dbQueue.read { (db) -> Int in
                let c: Int
                if let ad = afterDate {
                    c = try Post.filter(Column(Post.Columns.publishedAt.rawValue) > ad).fetchCount(db)
                } else {
                    c = try Post.fetchCount(db)
                }
                return c
            }
            return cnt
        } catch(let error) {
            fatalError("Error on fetch counting posts: \(error)")
        }
    }
    
    public func fetch(pagination: Pagination?) -> Array<Post> {
        do {
            let posts = try self.dbQueue.read { (db) -> Array<Post> in
                let publishedAtColumnName = Post.Columns.publishedAt.rawValue
                
                var queryRequest = Post.order(Column(publishedAtColumnName).desc)
                if let p = pagination {
                    queryRequest = queryRequest.limit(p.pageSize, offset: p.offset)
                }
                let posts = try queryRequest.fetchAll(db)
                return posts
            }
            return posts
        } catch(let error) {
            fatalError("Error on fetching posts: \(error)")
        }
    }
    
    /// Completed in background thread
    public func insertEverySecond(completion: @escaping () -> ()) {
        self.backgroundTimer.eventHandler = {
            do {
                let postCount = try self.dbQueue.read { db in
                    try Post.fetchCount(db)
                }
                try self.dbQueue.write({ (db) in
                    for i in 1...5 {
                        let n = i + postCount
                        let title = "Post \(n)"
                        let author = "Author \(n)"
                        let date = Date(timeInterval: TimeInterval(60 * (n - 1)), since: Date())
                        var post = Post(id: nil, title: title, author: author, publishedAt: date)
                        try post.insert(db)
                    }
                })
                completion()
                print("Inserted successfully")
            } catch(let error) {
                print("Error in inserting every 5 second: \(error)")
            }
        }
        self.backgroundTimer.resume()
    }
    
    public func clear(completion: @escaping () -> ()) {
        do {
            self.backgroundTimer.suspend()
            try self.dbQueue.write { (db) in
                let _ = try Post.deleteAll(db)
            }
            completion()
        } catch(let error) {
            print("Error in clearing posts:\(error)")
        }
    
    }
}
