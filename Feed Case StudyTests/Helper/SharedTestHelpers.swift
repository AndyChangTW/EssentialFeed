//
//  SharedTestHelpers.swift
//  FeedCaseStudyTests
//
//  Created by Andy Chang on 2022/10/9.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    return URL(string: "http://a-given-url.com")!
}
