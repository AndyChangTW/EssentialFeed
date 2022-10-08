//
//  FeedStoreSpy.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/8.
//

import Foundation
import FeedCaseStudy

class FeedStoreSpy: FeedStore {
    enum MessageReceived: Equatable {
        case delete
        case insert(feed: [LocalFeedImage], timestamp: Date)
        case retrieve
    }
    
    private var deleteCompletions = [DeletionCompletion]()
    private var insertCompletions = [InsertionCompletion]()
    
    private(set) var receivedMessages = [MessageReceived]()
    
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deleteCompletions.append(completion)
        receivedMessages.append(.delete)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertCompletions.append(completion)
        receivedMessages.append(.insert(feed: feed, timestamp: timestamp))
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deleteCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deleteCompletions[index](nil)
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertCompletions[index](error)
    }
    
    func retrieve() {
        receivedMessages.append(.retrieve)
    }
}
