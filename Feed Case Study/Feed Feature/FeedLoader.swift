//
//  FeedLoader.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/9/28.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping((LoadFeedResult) -> Void))
}
