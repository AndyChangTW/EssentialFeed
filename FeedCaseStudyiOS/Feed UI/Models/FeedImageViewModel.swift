//
//  FeedImageViewModel.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/10/21.
//

import Foundation
import FeedCaseStudy

final class FeedImageViewModel<Image> {
    typealias Observer<T> = (T) -> Void
    let model: FeedImage
    var task: FeedImageDataLoaderTask?
    let imageLoader: FeedImageDataLoader
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader, imageTransformer: @escaping (Data) -> Image?) {
        self.model = model
        self.imageLoader = imageLoader
        self.imageTransformer = imageTransformer
    }
    
    var description: String? {
        return model.description
    }
    
    var location: String? {
        return model.location
    }
    
    var hasLocation: Bool {
        return model.location != nil
    }
    
    var onImageLoaded: Observer<Image>?
    var onShouldRetryImageLoadStateChange: Observer<Bool>?
    var onLoadingStateChange: Observer<Bool>?
    var imageTransformer: (Data) -> Image?
    
    func loadImage() {
        onLoadingStateChange?(true)
        onShouldRetryImageLoadStateChange?(false)
        task = imageLoader.loadImageData(from: model.url) { [weak self] result in
            self?.handle(result)
        }
    }
    
    func handle(_ result: FeedImageDataLoader.Result) {
        if let image = (try? result.get()).flatMap(imageTransformer) {
            onImageLoaded?(image)
        } else {
            onShouldRetryImageLoadStateChange?(true)
        }
        onLoadingStateChange?(false)
    }
    
    func cancelLoad() {
        task?.cancel()
        task = nil
    }
}
