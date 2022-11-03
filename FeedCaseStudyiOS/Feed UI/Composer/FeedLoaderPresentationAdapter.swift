//
//  FeedLoaderPresentationAdapter.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/3.
//

import Foundation
import FeedCaseStudy

final class FeedLoaderPresentationAdapter: FeedRefreshViewControllerDelegate {
    let loader: FeedLoader
    var presenter: FeedPresenter?
    
    init(loader: FeedLoader) {
        self.loader = loader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoading()
        loader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingFeed(with: feed)
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
}
