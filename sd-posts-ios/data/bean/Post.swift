//
//  Post.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class Post {
    public private(set) var id: Int64?
    public let title: String
    public let author: String
    public let publishedAt: Date
    public init(id: Int64?,
                title: String,
                author: String,
                publishedAt: Date) {
        self.id = id
        self.title = title
        self.author = author
        self.publishedAt = publishedAt
    }
}


import GRDB

extension Post: Codable, FetchableRecord, MutablePersistableRecord {
    private enum Columns {
        static let id = Column(CodingKeys.id)
        static let title = Column(CodingKeys.title)
        static let author = Column(CodingKeys.author)
        static let publishedAt = Column(CodingKeys.publishedAt)
    }
    
    public func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
