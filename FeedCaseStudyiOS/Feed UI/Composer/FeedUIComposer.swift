//
//  FeedUIComposer.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit
import FeedCaseStudy

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let feedPresenter = FeedPresenter()
        let feedPresenterAdapter = FeedPresenterAdapter(loader: feedLoader, presenter: feedPresenter)
        let refreshController = FeedRefreshViewController(delegate: feedPresenterAdapter)
        let feedViewController = FeedViewController(refreshController: refreshController)
        feedPresenter.loadingView = WeakRefVirtualProxy(refreshController)
        feedPresenter.feedView = FeedAdapter(controller: feedViewController, loader: imageLoader)
        return feedViewController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
            }
        }
    }
}

private final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedRefreshViewController {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(viewModel)
    }
}

final class FeedPresenterAdapter: FeedRefreshViewControllerDelegate {
    let loader: FeedLoader
    let presenter: FeedPresenter
    
    init(loader: FeedLoader, presenter: FeedPresenter) {
        self.loader = loader
        self.presenter = presenter
    }
    
    func didRequestFeedRefresh() {
        presenter.didStartLoading()
        loader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter.didFinishLoadingFeed(with: feed)
            case let .failure(error):
                self?.presenter.didFinishLoadingFeed(with: error)
            }
        }
    }
}

final class FeedAdapter: FeedView {
    weak var controller: FeedViewController?
    let loader: FeedImageDataLoader
    
    init(controller: FeedViewController, loader: FeedImageDataLoader) {
        self.controller = controller
        self.loader = loader
    }
    
    func display(_ feedViewModel: FeedViewModel) {
        controller?.tableModel = feedViewModel.feed.map({ model in
            FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
        })
    }
}
