//
//  App.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import UIKit
import GRDB

final public class App {
    public private(set) var dbQueue: DatabaseQueue!
    public let db: SqliteDataBase
    public let application: UIApplication
    public let window: UIWindow
    public init(application: UIApplication,
                window: UIWindow) {
        self.application = application
        self.window = window
        
        self.db = SqliteFactory.createSqlite()
    }
    
    public func launch() {
        self.createDB()
        
        self.window.rootViewController = UIViewController()
    }
    
    private func createDB() {
        do {
            self.dbQueue = try self.db.openDatabase()
            try self.dbQueue.write { (db) in
                var post = Post(id: nil, title: "title", author: "author", publishedAt: Date())
                try post.insert(db)
                
                let posts = try Post.fetchAll(db)
                for p in posts {
                    print(p.id ?? -1)
                    print(p.title)
                    print(p.author)
                    print(p.publishedAt)
                }
            }
            
            print("Database url: \(self.db.path)")
        } catch(let e) {
            fatalError("Error loading database \(e.localizedDescription)")
        }
    }
}
