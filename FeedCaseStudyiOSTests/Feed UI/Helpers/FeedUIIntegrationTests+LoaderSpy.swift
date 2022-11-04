//
//  FeedCaseStudyiOSTests+LoaderSpy.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/19.
//

import Foundation
import FeedCaseStudy
import FeedCaseStudyiOS

class LoaderSpy: FeedLoader, FeedImageDataLoader {
    var loadFeedCallCount: Int {
        return feedRequests.count
    }
    
    private(set) var feedRequests = [(FeedLoader.Result) -> Void]()
    func load(completion: @escaping ((FeedLoader.Result) -> Void)) {
        feedRequests.append(completion)
    }
    
    func completeFeedLoading(with feed: [FeedImage] = [], at index: Int = 0) {
        feedRequests[index](.success(feed))
    }
    
    func completeFeedLoadingWithError(at index: Int) {
        let error = anyNSError()
        feedRequests[index](.failure(error))
    }
    
    func completeImageLoading(with data: Data = Data(), at index: Int) {
        imageRequests[index].completion(.success(data))
    }
    
    func completeImageLoadingWithError(at index: Int) {
        imageRequests[index].completion(.failure(anyNSError()))
    }
    
    // MARK: - FeedImageDataLoader
    
    private struct TaskSpy: FeedImageDataLoaderTask {
        let cancelCallback: () -> Void
        func cancel() {
            cancelCallback()
        }
    }
    
    private var imageRequests = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    var loadedImageURLs: [URL] {
        return imageRequests.map { $0.url }
    }
    private(set) var cancelledImageURLs = [URL]()
    
    func loadImageData(from url: URL, completion: @escaping((FeedImageDataLoader.Result) -> Void)) -> FeedImageDataLoaderTask {
        imageRequests.append((url, completion))
        return TaskSpy{ [weak self] in self?.cancelledImageURLs.append(url) }
    }
}
