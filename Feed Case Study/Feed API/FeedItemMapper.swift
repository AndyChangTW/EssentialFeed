//
//  FeedItemMapper.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/10/3.
//

import Foundation

internal class FeedItemMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data)  else {
            throw RemoteFeedLoader.Error.invalidData
        }
        return root.items
    }
}
