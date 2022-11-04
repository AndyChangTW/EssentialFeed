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
        
        let feedController = makeFeedViewController(delegate: feedPresenterAdapter, title: FeedPresenter.title)
        
        let feedPresenter = FeedPresenter(loadingView: WeakRefVirtualProxy(feedController),
                                          feedView: FeedViewAdapter(controller: feedController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
        feedPresenterAdapter.presenter = feedPresenter
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}
