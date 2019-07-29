//
//  PostDataSource.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

public protocol PostDataSource: DataSource {
    func allCount(afterDate: Date?) -> Int
    func fetch(pagination: Pagination?) -> Array<I>
    func insertEverySecond(completion: @escaping () -> ())
    func clear(completion: @escaping () -> ())
}
