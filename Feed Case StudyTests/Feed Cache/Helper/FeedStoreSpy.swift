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
        case deleteCachedFeed
        case insert(feed: [LocalFeedImage], timestamp: Date)
        case retrieve
    }
    
    private var deleteCompletions = [DeletionCompletion]()
    private var insertCompletions = [InsertionCompletion]()
    private var retrieveCompletions = [RetrieveCompletion]()
    
    private(set) var receivedMessages = [MessageReceived]()
    
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deleteCompletions.append(completion)
        receivedMessages.append(.deleteCachedFeed)
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertCompletions.append(completion)
        receivedMessages.append(.insert(feed: feed, timestamp: timestamp))
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deleteCompletions[index](.failure(error))
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deleteCompletions[index](.success(()))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertCompletions[index](.failure(error))
    }
    
    func retrieve(completion: @escaping RetrieveCompletion) {
        retrieveCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetrieval(with error: Error, at index: Int = 0) {
        retrieveCompletions[index](.failure(error))
    }
    
    func completeRetrievalWithEmptyCache(at index: Int = 0) {
        retrieveCompletions[index](.success(.none))
    }
    
    func completeRetrieval(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0) {
        retrieveCompletions[index](.success(CachedFeed(feed: feed, timestamp: timestamp)))
    }
}
