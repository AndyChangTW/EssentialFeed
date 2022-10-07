//
//  CacheFeedUseCaseTests.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/7.
//

import XCTest

class LocalFeedLoader {
    let store: FeedStore
    init(store: FeedStore) {
        self.store = store
    }
}

class FeedStore {
    var deletionCallCount: Int = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deletionCallCount, 0)
    }

}
