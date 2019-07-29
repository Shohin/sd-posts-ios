//
//  PostSqliteTableConfigurator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation
import GRDB

extension Post: SqliteTableConfigurator {
    public static func config(tableDefinition: TableDefinition) {
        tableDefinition.autoIncrementedPrimaryKey("id")
        tableDefinition.column("title", .text).notNull()
        tableDefinition.column("author", .text).notNull()
        tableDefinition.column("publishedAt", .date).notNull()
    }
}
