//
//  FeedCaseStudyiOSTests.swift
//  FeedCaseStudyiOSTests
//
//  Created by Andy Chang on 2022/10/15.
//

import XCTest
import UIKit
import FeedCaseStudy

final class FeedViewController: UIViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader?.load { result in
            
        }
    }
}

final class FeedCaseStudyiOSTests: XCTestCase {


    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    func test_viewDidLoad_loadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCallCount, 1)
    }
    
    
    // MARK: - Helpers
    
    class LoaderSpy: FeedLoader {
        private(set) var loadCallCount: Int = 0
        
        func load(completion: @escaping ((FeedLoader.Result) -> Void)) {
            loadCallCount += 1
        }
    }
    
}
