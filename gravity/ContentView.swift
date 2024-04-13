//
//  ContentView.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import SwiftUI
import SwiftData
import CoreMotion

struct Ball:Hashable{
    var v_x:Float=0
    var v_y:Float=0
}

struct MyGridItemData:Hashable{
    var index_i:Int
    var index_j:Int
    var ball: Ball?
}

struct MyGridItemView:View {
    var myGridItemData:MyGridItemData
    var body: some View {
        if myGridItemData.ball != nil{
            RoundedRectangle(cornerSize: .init(width: 3, height: 3))
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
        }else{
            RoundedRectangle(cornerSize: .init(width: 3, height: 3))
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView: View {
    var myGridItemDataList: [[MyGridItemData]] = (1..<10).map{
        i in
        (1..<10).map{
            j in
            if Float.random(in: 0...1)<0.2{
                return MyGridItemData(index_i: i, index_j: j,ball: Ball())
            }else{
                return MyGridItemData(index_i: i, index_j: j)
            }
        }
    }
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
}
