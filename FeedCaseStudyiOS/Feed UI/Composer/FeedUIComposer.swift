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
        
        let feedPresenterAdapter = FeedLoaderPresentationAdapter(loader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let refreshController = FeedRefreshViewController(delegate: feedPresenterAdapter)
        let feedViewController = FeedViewController(refreshController: refreshController)
        let feedPresenter = FeedPresenter(loadingView: WeakRefVirtualProxy(refreshController),
                                          feedView: FeedViewAdapter(controller: feedViewController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
        feedPresenterAdapter.presenter = feedPresenter
        return feedViewController
    }
}

final class FeedViewAdapter: FeedView {
    weak var controller: FeedViewController?
    let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.tableModel = viewModel.feed.map { model in
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
            let view = FeedImageCellController(delegate: adapter)
            
            adapter.presenter = FeedImagePresenter(
                view: WeakRefVirtualProxy(view),
                imageTransformer: UIImage.init)
            
            return view
        }
    }
}
