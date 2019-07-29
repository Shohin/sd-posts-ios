//
//  PostSqliteRecord.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/28/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import GRDB

extension Post: TableRecord {
    enum Columns: String, ColumnExpression {
        case id, title, author, publishedAt
    }
}

extension Post: FetchableRecord {
    
    public convenience init(row: Row) {
        let id: Int64? = row[Columns.id]
        let title: String = row[Columns.title]
        let author: String = row[Columns.author]
        let publishedAt: Date = row[Columns.publishedAt]
        self.init(id: id,
                  title: title,
                  author: author,
                  publishedAt: publishedAt)
    }
}

extension Post: MutablePersistableRecord {
    public func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = self.id
        container[Columns.title] = self.title
        container[Columns.author] = self.author
        container[Columns.publishedAt] = self.publishedAt
    }
    
    public func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}
