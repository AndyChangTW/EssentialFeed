//
//  FeedViewController.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/16.
//

import UIKit
import FeedCaseStudy

public final class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadFeed), for: .valueChanged)
        loadFeed()
    }
    
    @objc func loadFeed() {
        refreshControl?.beginRefreshing()
        loader?.load { [weak self] result in
            self?.refreshControl?.endRefreshing()
        }
    }
}
