//
//  FeedErrorViewModel.swift
//  FeedCaseStudyiOS
//
//  Created by Andy Chang on 2022/11/10.
//

import Foundation

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
