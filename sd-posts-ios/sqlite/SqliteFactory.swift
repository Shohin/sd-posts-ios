//
//  SqliteFactory.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

public struct SqliteFactory {
    private static let tableConfigurators: Array<SqliteTableConfigurator.Type> = [Post.self]
    
    
    private init() {
        
    }
    
    public static func createSqlite() -> SqliteDataBase {
        do {
            let databaseURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db.sqlite")
            let path = databaseURL.path
            let db = SqliteDataBase(path: path, tableConfigrators: self.tableConfigurators)
            return db
        } catch(let error) {
            fatalError("Error in creating sqlite database: \(error.localizedDescription)")
        }
    }
}
