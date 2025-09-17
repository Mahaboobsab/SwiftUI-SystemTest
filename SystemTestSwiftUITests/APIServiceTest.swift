//
//  APIServiceTest.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

import Testing
@testable import SystemTestSwiftUI

struct APIServiceTest {
    
    @Test
    func fetchItems() async throws {
        let mock = MockWebService()
        mock.mockItems = [Item(id: 1, title: "Test Item")]
        
        let apiService = APIService(webService: mock)
        let items = try await apiService.fetchItems()
        
        #expect(items.count == 1)
        #expect(items.first?.title == "Test Item")
    }
}
