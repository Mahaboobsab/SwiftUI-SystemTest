//
//  APIService.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

import Foundation

final class APIService {
    
    private let webService: WebServiceProtocol
    
    // Dependency injection via initializer
    init(webService: WebServiceProtocol = WebServiceManager.shared) {
        self.webService = webService
    }
    
    func fetchItems() async throws -> [Item] {
        try await webService.getRequest(endpoint: .posts, headers: nil)
    }
    
}
