//
//  FeedViewAdapter.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/3.
//

import UIKit
import FeedCaseStudy

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
            
            adapter.presenter = FeedImagePresenter(view: WeakRefVirtualProxy(view), imageTransformer: { data in
                return UIImage(data: data)
            })
            
            return view
        }
    }
}
