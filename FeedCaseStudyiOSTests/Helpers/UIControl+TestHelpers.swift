//
//  UIControl+TestHelpers.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
