//
//  ContentView.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import SwiftUI
//import SwiftData
//import CoreMotion

struct Ball:Hashable{
    var v_x:Float=0
    var v_y:Float=0
}

struct MyGridItemData:Hashable{
    var index_i:Int
    var index_j:Int
    var ball: Ball?
    init(index_i: Int, index_j: Int, ball: Ball? = nil) {
        self.index_i = index_i
        self.index_j = index_j
        self.ball = ball
    }
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

let i_count=20
let j_count=20

let probability = 0.1

struct ContentView: View {
    @State var myGridItemDataList: [[MyGridItemData]] = (0..<i_count).map{
        i in
        (0..<j_count).map{
            j in
            if Double.random(in: 0...1) < probability {
                return MyGridItemData(index_i: i, index_j: j, ball: Ball())
            }else{
                return MyGridItemData(index_i: i, index_j: j)
            }
        }
    }
    @State var timer:Timer?
    var body: some View {
        Grid(horizontalSpacing: 5, verticalSpacing: 5) {
            ForEach(myGridItemDataList,id:\.self){ i in
                GridRow {
                    ForEach(i,id: \.self){ j in
                        MyGridItemView(myGridItemData:j)
                    }
                }
            }
        }.onAppear{
            timer=Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){
                _ in
                update()
            }
        }
    }
    func update(){
        for i in myGridItemDataList{
            for j in i{
                if j.ball != nil{
                    if j.index_j+1 >= j_count{
                        continue
                    }
                    if myGridItemDataList[j.index_i][j.index_j+1].ball == nil{
                        myGridItemDataList[j.index_i][j.index_j+1].ball = myGridItemDataList[j.index_i][j.index_j].ball
                        myGridItemDataList[j.index_i][j.index_j].ball = nil
                    }
                }
            }
        }
    }
}
