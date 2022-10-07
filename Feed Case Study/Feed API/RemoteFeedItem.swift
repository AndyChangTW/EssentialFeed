//
//  RemoteFeedItem.swift
//  FeedCaseStudy
//
//  Created by Andy Chang on 2022/10/7.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
