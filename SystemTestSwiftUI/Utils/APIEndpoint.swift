//
//  APIEndpoint.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

import Foundation

enum APIEndpoint {
    case posts
    
    public var path: String {
        switch self {
        case .posts:
            return "posts"
        }
    }
    
    var url: URL {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/")!
        return baseURL.appendingPathComponent(path)
    }
}
