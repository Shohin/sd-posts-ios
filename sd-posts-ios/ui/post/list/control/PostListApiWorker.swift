//
//  PostListApiWorker.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class PostListApiWorker: PostListWorker {
    public let input: PostListInputData = PostListInputData()
    
    public let repository: PostRepository
    public init(repository: PostRepository) {
        self.repository = repository
    }
    
    public func load(completion: @escaping EmptyCompletion) {
        DispatchQueue.global().async {
            let allCnt = self.repository.allCount(afterDate: nil)
            let pnt: Pagination
            if let p = self.input.pagination {
                pnt = Pagination(totalCount: allCnt, pageSize: p.pageSize, currentPage: p.currentPage)
            } else {
                pnt = Pagination(totalCount: allCnt, pageSize: 10)
            }
            
            self.input.pagination = pnt
            let items = self.fecth(pnt: pnt)
            if pnt.currentPage > 1 {
                self.input.add(items: items, isStart: false)
            } else {
                self.input.set(items: items)
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    public func insertEverySecond(completion: @escaping InsertionCompletion) {
        self.repository.insertEverySecond {
            let topDate = self.input.items.first?.publishedAt
            let newCnt = self.repository.allCount(afterDate: topDate)
            print("New count: \(newCnt)")
            if newCnt > 0 {
                DispatchQueue.main.async {
                    completion(newCnt)
                }
            }
        }
    }
    
    public func clear(completion: @escaping EmptyCompletion) {
        DispatchQueue.global().async {
            self.repository.clear(completion: completion)
            self.input.clear()
        }
    }
    
    private func fecth(pnt: Pagination) -> Array<PostItemInputData> {
        let items = self.repository.fetch(pagination: pnt).map { (p) -> PostItemInputData in
            return PostItemInputData(id: p.id, title: p.title, author: p.author, publishedAt: p.publishedAt)
        }
        return items
    }
}
