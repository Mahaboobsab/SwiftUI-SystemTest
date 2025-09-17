//
//  ContentView.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//

import SwiftUI
import CoreSwift

struct ContentView: View {
    @StateObject private var viewModel = ItemListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.items) { item in
                    ItemRowView(item: item)
                }
                .navigationTitle(kPosts.localized)
                
                if viewModel.isLoading {
                    ProgressView(kLoading.localized)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
            .task {
                await viewModel.loadItems()
            }
        }
    }
}

#Preview {
    ContentView()
}
