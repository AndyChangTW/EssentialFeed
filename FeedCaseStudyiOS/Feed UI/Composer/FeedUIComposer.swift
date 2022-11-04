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
        
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        let refreshController = feedController.refreshController!
        refreshController.delegate = feedPresenterAdapter
        
        let feedPresenter = FeedPresenter(loadingView: WeakRefVirtualProxy(refreshController),
                                          feedView: FeedViewAdapter(controller: feedController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
        feedPresenterAdapter.presenter = feedPresenter
        return feedController
    }
}
