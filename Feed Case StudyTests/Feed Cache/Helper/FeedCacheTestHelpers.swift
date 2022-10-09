//
//  FeedCacheTestHelpers.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/9.
//

import Foundation
import FeedCaseStudy

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], locals: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let locals = models.map{ LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    return (models, locals)
}

extension Date {
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -7)
    }
    
    func adding(days: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: .second, value: seconds, to: self)!
    }
}
