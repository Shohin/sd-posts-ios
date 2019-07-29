//
//  PostRepository.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/28/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

public protocol PostRepository: Repository {
    func allCount(afterDate: Date?) -> Int
    func fetch(pagination: Pagination?) -> Array<Post>
    func insertEverySecond(completion: @escaping () -> ())
    func clear(completion: @escaping () -> ())
}
