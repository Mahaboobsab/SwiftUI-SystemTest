//
//  ItemRowView.swift
//  SystemTestSwiftUI
//
//  Created by Meheboob on 17/09/25.
//
import SwiftUI

struct ItemRowView: View {
    let item: Item
    var body: some View {
        Text("\(item.id)")
            .font(.largeTitle)
        Text(item.title)
            .font(.subheadline)
        
    }
}

#Preview {
    ItemRowView(item: Item(id: 100, title: "MMEC"))
}
