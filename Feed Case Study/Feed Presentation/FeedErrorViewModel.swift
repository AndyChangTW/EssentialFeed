//
//  FeedErrorViewModel.swift
//  FeedCaseStudy
//
//  Created by Andy Chang on 2022/11/13.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?
    
    public static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
    
}
