//
//  Post.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class Post {
    public var id: Int64?
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
