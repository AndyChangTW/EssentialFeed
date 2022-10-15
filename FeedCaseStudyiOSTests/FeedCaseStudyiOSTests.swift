//
//  FeedCaseStudyiOSTests.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/15.
//

import XCTest
import UIKit

final class FeedViewController: UIViewController {
    
    convenience init(loader: FeedCaseStudyiOSTests.LoaderSpy) {
        self.init()
    }
}

final class FeedCaseStudyiOSTests: XCTestCase {


    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController()
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    
    // MARK: - Helpers
    
    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }
    
}
