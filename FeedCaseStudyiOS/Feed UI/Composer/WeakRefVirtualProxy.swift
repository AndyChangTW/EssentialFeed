//
//  WeakRefVirtualProxy.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/3.
//

import UIKit

final class WeakRefVirtualProxy<T: AnyObject> {
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

extension WeakRefVirtualProxy: FeedImageView where T: FeedImageView, T.Image == UIImage {
    func display(_ model: FeedImageViewModel<UIImage>) {
        object?.display(model)
    }
}
