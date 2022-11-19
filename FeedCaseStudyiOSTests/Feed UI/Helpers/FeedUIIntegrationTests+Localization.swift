//
//  FeedViewControllerTests+Localization.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/11/4.
//

import XCTest
import FeedCaseStudy

extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
