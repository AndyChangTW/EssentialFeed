//
//  URLSessionHTTPClient.swift
//  Feed Case Study
//
//  Created by Andy Chang on 2022/10/6.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedRepresentationError: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            completion( Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedRepresentationError()
                }
            })
        }.resume()
    }
}
