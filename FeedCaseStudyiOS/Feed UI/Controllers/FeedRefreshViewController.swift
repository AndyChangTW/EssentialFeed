//
//  FeedRefreshViewController.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit

public final class FeedRefreshViewController: NSObject {
    private (set) lazy var view: UIRefreshControl = bind(UIRefreshControl())
    
    private let viewModel: FeedViewModel
    
    public init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func refresh() {
        viewModel.loadFeed()
    }
    
    private func bind(_ refreshControl: UIRefreshControl) -> UIRefreshControl {
        viewModel.onChange = { [weak refreshControl] viewModel in
            if viewModel.isLoading {
                refreshControl?.beginRefreshing()
            } else {
                refreshControl?.endRefreshing()
            }
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }
}
