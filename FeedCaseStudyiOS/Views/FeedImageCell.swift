//
//  FeedImageCell.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/17.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    public let descriptionLabel = UILabel()
    public let locationLabel = UILabel()
    public let locationContainer = UIView()
    public let feedImageContainer = UIView()
    public let feedImageView = UIImageView()
    private(set) public lazy var feedImageRetryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var onRetry: (() -> Void)?
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
}
