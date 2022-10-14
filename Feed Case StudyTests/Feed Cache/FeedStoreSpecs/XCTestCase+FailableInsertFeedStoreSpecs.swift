//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/12.
//

import XCTest
import FeedCaseStudy

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed().locals, Date()), to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueImageFeed().locals, Date()), to: sut)
        
        expect(sut, toRetrieve: .success(.empty))
    }
}
