//
//  FeedViewController.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/16.
//

import UIKit
import FeedCaseStudy

protocol FeedViewControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView, FeedErrorView {
    var delegate: FeedViewControllerDelegate?
    
    @IBOutlet private(set) public var errorView: ErrorView?
    
    var tableModel = [FeedImageCellController]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var cellControllers = [IndexPath: FeedImageCellController]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    public func display(_ viewModel: FeedLoadingViewModel) {
        refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
    
    public func display(_ viewModel: FeedErrorViewModel) {
        errorView?.message = viewModel.message
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControlLoad(forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cancelCellControlLoad(forRowAt: indexPath)
        }
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }
    
    private func cancelCellControlLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).cancelLoad()
    }
}
