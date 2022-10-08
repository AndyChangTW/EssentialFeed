//
//  LoadFeedFromCacheUseCaseTests.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/8.
//

import XCTest
import FeedCaseStudy

final class LoadFeedFromCacheUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages.count, 0)
    }
    
    
    //MARK: Helper
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private class FeedStoreSpy: FeedStore {
        enum MessageReceived: Equatable {
            case delete
            case insert(feed: [LocalFeedImage], timestamp: Date)
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
    }

}
