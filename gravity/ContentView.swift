//
//  ContentView.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import SwiftUI
import SwiftData

struct MyGridItem:View {
    var body: some View {
        RoundedRectangle(cornerSize: .init(width: 3, height: 3))
            .frame(width: 30, height: 30)
            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        Grid(horizontalSpacing: 5, verticalSpacing: 5) {
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
            GridRow {
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
                MyGridItem()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
