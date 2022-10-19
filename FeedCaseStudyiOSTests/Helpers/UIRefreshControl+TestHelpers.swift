//
//  UIRefreshControl+TestHelpers.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
