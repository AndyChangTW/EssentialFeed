//
//  FeedLoader.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/9/28.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping((LoadFeedResult<Error>) -> Void))
}
