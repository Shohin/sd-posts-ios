//
//  PostItemInputData.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostItemInputData: InputData {
    public let id: Int64?
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
    
    public var publishAtText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy HH:mm"
        let txt = formatter.string(from: self.publishedAt)
        
        return txt
    }
}
