//
//  FeedPresenterTests.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/11/12.
//

import XCTest

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

private final class FeedPresenter {
    
    private let errorView: FeedErrorView
    
    init(errorView: FeedErrorView) {
        self.errorView = errorView
    }
    
    func didStartLoading() {
        errorView.display(.noError)
    }
}

final class FeedPresenterTests: XCTestCase {

    func test_init_deliversNoMessages() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty)
    }
    
    func test_didStartLoading_deliversNoErrorMessage() {
        let (sut, view) = makeSUT()
        
        sut.didStartLoading()
        
        XCTAssertEqual(view.messages, [.display(errorMessage: .none)])
    }
    
    //MARK: Helpers
    private func makeSUT() -> (sut: FeedPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(errorView: view)
        return (sut, view)
    }
    
    
    private class ViewSpy: FeedErrorView {
        var messages = [Message]()
        
        enum Message: Equatable {
            case display(errorMessage: String?)
        }
        
        func display(_ viewModel: FeedErrorViewModel) {
            messages.append(.display(errorMessage: viewModel.message))
        }
        
    }
}
