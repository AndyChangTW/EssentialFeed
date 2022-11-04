//
//  UITableView+Dequeueing.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/4.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
