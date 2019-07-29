//
//  SqliteDataBase.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation
import GRDB

final public class SqliteDataBase {
    public let path: String
    private let tableConfigrators: Array<SqliteTableConfigurator.Type>
    public var migrator: DatabaseMigrator
    public init(path: String,
                 tableConfigrators: Array<SqliteTableConfigurator.Type>) {
        self.path = path
        self.tableConfigrators = tableConfigrators
        
        self.migrator = DatabaseMigrator()
        self.migrator.registerMigration("createTables") { db in
            try self.createTables(db: db)
        }
    }
    
    public func openDatabase() throws -> DatabaseQueue {
        let dbQueue = try DatabaseQueue(path: self.path)

        try self.migrator.migrate(dbQueue)
        
        return dbQueue
    }
    
    private func createTables(db: Database) throws {
        for tc in self.tableConfigrators {
            let tableName = String(describing: tc)
            try db.create(table: tableName, body: { (t) in
                tc.config(tableDefinition: t)
            })
        }
    }
}
