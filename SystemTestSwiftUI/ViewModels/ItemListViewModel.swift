//
//  ItemListViewModel.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//
import SwiftUI

@MainActor
final class ItemListViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false } // ensures it resets even if request fails
        
        do {
            items = try await apiService.fetchItems()
        } catch {
            print("❌ Failed to fetch items: \(error)")
        }
    }
}
