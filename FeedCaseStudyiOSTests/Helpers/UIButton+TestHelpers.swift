//
//  UIButton+TestHelpers.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
