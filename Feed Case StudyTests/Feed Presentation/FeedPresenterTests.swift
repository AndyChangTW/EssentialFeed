//
//  FeedPresenterTests.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/11/12.
//

import XCTest

private final class FeedPresenter {
    init() {
        
    }
}

final class FeedPresenterTests: XCTestCase {

    func test_init_deliversNoMessages() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty)
    }
    
    //MARK: Helpers
    private func makeSUT() -> (sut: FeedPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter()
        return (sut, view)
    }
    
    
    private class ViewSpy {
        
        var messages = [Any]()
    }
}
