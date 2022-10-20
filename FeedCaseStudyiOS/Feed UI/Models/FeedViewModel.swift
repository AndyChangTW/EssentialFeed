//
//  FeedViewModel.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/20.
//

import Foundation
import FeedCaseStudy

public final class FeedViewModel {
    private let feedLoader: FeedLoader
    
    public init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    public var isLoading: Bool = false {
        didSet {
            onChange?(self)
        }
    }
    
    public var onChange: ((FeedViewModel) -> Void)?
    public var onFeedLoaded: (([FeedImage]) -> Void)?
    
    public func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoaded?(feed)
            }
            self?.isLoading = false
        }
    }
}
