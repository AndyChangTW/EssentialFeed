//
//  FeedItem.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/9/28.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
}
