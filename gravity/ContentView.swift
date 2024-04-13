//
//  ContentView.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import SwiftUI
import SwiftData

struct Ball:Hashable{}

struct MyGridItemData:Hashable{
    var index_i:Int
    var index_j:Int
}

struct MyGridItemView:View {
    var myGridItemData:MyGridItemData?
    var body: some View {
        if myGridItemData != nil{
            RoundedRectangle(cornerSize: .init(width: 3, height: 3))
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
        }else{
            RoundedRectangle(cornerSize: .init(width: 3, height: 3))
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
        }
    }
    init(myGridItemData: MyGridItemData? = nil) {
        self.myGridItemData = myGridItemData
    }
}

struct ContentView: View {
    var myGridItemDataList: [[MyGridItemData?]] = [[MyGridItemData(index_i: 0, index_j: 0),nil,nil,nil]]
    var body: some View {
        Grid(horizontalSpacing: 5, verticalSpacing: 5) {
            ForEach(myGridItemDataList,id:\.self){i in
                GridRow {
                    ForEach(i,id: \.self){j in
                        MyGridItemView(myGridItemData:j)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
