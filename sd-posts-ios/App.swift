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
    private let navigator = AppNavigator()
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
        self.openDB()
        
        R.didNavigate { (n) in
            print("Navigated to: \(n)")
        }
        
        self.showPostList()
    }
    
    private func openDB() {
        do {
            self.registerFillDefDataMigr()
            self.dbQueue = try self.db.openDatabase()
            
            print("Database url: \(self.db.path)")
        } catch(let e) {
            fatalError("Error loading database \(e.localizedDescription)")
        }
    }
    
    private func registerFillDefDataMigr() {
        self.db.migrator.registerMigration("defaultDatas") { (db) in
            for i in 1...100 {
                let title = "Post \(i)"
                let author = "Author \(i)"
                let date = Date(timeInterval: TimeInterval(60 * (i - 1)), since: Date())
                var post = Post(id: nil, title: title, author: author, publishedAt: date)
                try post.insert(db)
                
            }
        }
    }
    
    public func showPostList() {
        let mockCon = UIViewController()
        R.navigate(with: self.navigator, for: .postList, from: mockCon)
    }
    
    public func changeWindow(rootController: UIViewController) {
        self.window.rootViewController = rootController
        self.window.makeKeyAndVisible()
    }
}
