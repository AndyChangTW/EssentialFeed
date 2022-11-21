//
//  FeedImagePresenterTests.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/11/21.
//

import XCTest
import FeedCaseStudy

struct FeedImageViewModel {
    let description: String?
    let location: String?
    let image: Any?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}

protocol FeedImageView {
    func display(_ model: FeedImageViewModel)
}

final class FeedImagePresenter {
    private let view: FeedImageView
    private let imageTransformer: (Data) -> Any?
    init(view: FeedImageView, imageTransformer: @escaping(Data) -> Any?) {
        self.view = view
        self.imageTransformer = imageTransformer
    }
    
    func didStartLoadingImageData(for model: FeedImage) {
        view.display(FeedImageViewModel(description: model.description,
                                        location: model.location,
                                        image: nil,
                                        isLoading: true,
                                        shouldRetry: false))
    }
    
    private struct InvalidImageDataError: Error {}
    
    func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
        guard let image = imageTransformer(data) else {
            return didFinishLoadingImageData(with: InvalidImageDataError(), for: model)
        }
    }
    
    func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        view.display(FeedImageViewModel(description: model.description,
                                        location: model.location,
                                        image: nil,
                                        isLoading: false,
                                        shouldRetry: true))
    }
}

final class FeedImagePresenterTests: XCTestCase {

    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty)
    }
    
    func test_didStartLoadingImageData_displaysLoadingImage() {
        let (sut, view) = makeSUT()
        let feed = uniqueImage()
        sut.didStartLoadingImageData(for: feed)
        
        let message = view.messages.first
        XCTAssertEqual(view.messages.count, 1)
        XCTAssertEqual(message?.description, feed.description)
        XCTAssertEqual(message?.location, feed.location)
        XCTAssertNil(message?.image)
        XCTAssertEqual(message?.isLoading, true)
        XCTAssertEqual(message?.shouldRetry, false)
    }
    
    func test_didFinishLoadingImageData_displayRetryOnImageTransformingFailed() {
        let (sut, view) = makeSUT(imageTransformer: fail)
        let feed = uniqueImage()
        let data = Data()
        sut.didFinishLoadingImageData(with: data, for: feed)
        
        let message = view.messages.first
        XCTAssertEqual(view.messages.count, 1)
        XCTAssertEqual(message?.description, feed.description)
        XCTAssertEqual(message?.location, feed.location)
        XCTAssertNil(message?.image)
        XCTAssertEqual(message?.isLoading, false)
        XCTAssertEqual(message?.shouldRetry, true)
    }
    
    private func makeSUT(imageTransformer: @escaping (Data) -> Any? = { _ in nil }, file: StaticString = #file, line: UInt = #line) -> (sut: FeedImagePresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view, imageTransformer: imageTransformer)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }
    
    private var fail: (Data) -> Any? {
        return { _ in nil }
    }
    
    private class ViewSpy: FeedImageView {
        private(set) var messages = [FeedImageViewModel]()
        
        func display(_ model: FeedImageViewModel) {
            messages.append(model)
        }
    }

}
