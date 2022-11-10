//
//  UIRefreshControl+Helpers.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/10.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
