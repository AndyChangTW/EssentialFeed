//
//  FeedImageCellController.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/19.
//

import UIKit

final class FeedImageCellController {
    let viewModel: FeedImageViewModel<UIImage>
    
    init(viewModel: FeedImageViewModel<UIImage>) {
        self.viewModel = viewModel
    }
    
    func view() -> UITableViewCell {
        let cell = binded(FeedImageCell())
        viewModel.loadImage()
        return cell
    }
    
    private func binded(_ cell: FeedImageCell) -> FeedImageCell {
        cell.locationContainer.isHidden = !viewModel.hasLocation
        cell.descriptionLabel.text = viewModel.description
        cell.locationLabel.text = viewModel.location
        cell.feedImageView.image = nil
        cell.feedImageRetryButton.isHidden = true
        cell.feedImageContainer.startShimmering()
        viewModel.onLoadingStateChange = { [weak cell] isLoading in
            if isLoading {
                cell?.feedImageContainer.startShimmering()
            } else {
                cell?.feedImageContainer.stopShimmering()
            }
        }
        viewModel.onImageLoaded = { [weak cell] image in
            cell?.feedImageView.image = image
        }
        viewModel.onShouldRetryImageLoadStateChange = { [weak cell] shouldRetry in
            cell?.feedImageRetryButton.isHidden = !shouldRetry
        }
        
        cell.onRetry = viewModel.loadImage
        return cell
    }
    
    func preload() {
        viewModel.loadImage()
    }
    
    func cancelLoad() {
        viewModel.cancelLoad()
    }
}
