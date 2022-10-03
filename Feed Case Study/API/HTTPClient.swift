//
//  HTTPClient.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/10/3.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
