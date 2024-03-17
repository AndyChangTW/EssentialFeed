//
//  HTTPURLResponse+StatusCode.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2024/3/17.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
