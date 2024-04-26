//
//  ContentView.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import SwiftUI
import CoreMotion

struct Ball:Hashable{
    var v_x:Double=0
    var v_y:Double=0
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

let mass = 1.0
let threshold = 0.1
let friction = 0.03
let bounce = 0.6
let interval = 0.1

struct ContentView: View {
    @State var myGridItemDataList: [[MyGridItemData]] = (0..<i_count).map{
        i in
        (0..<j_count).map{
            j in
            if Double.random(in: 0...1) < probability {
                return MyGridItemData(index_i: i, index_j: j, ball: Ball())
            } else {
                return MyGridItemData(index_i: i, index_j: j)
            }
        }
    }
    @State var motionManager = CMMotionManager()
    @State var a_x = 0.0
    @State var a_y = 0.0
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
            if motionManager.isDeviceMotionAvailable {
                motionManager.accelerometerUpdateInterval = interval
                motionManager.startAccelerometerUpdates(to: .main){
                    (data,error) in
                    guard let data else{return}
                    self.a_x = data.acceleration.x //xが増える方向にjが増える
                    self.a_y = -data.acceleration.y //yが減る方向にiが増える
                    update()
                }
            }
        }
    }
    func update(){
        for i in myGridItemDataList{
            for j in i{
                guard var ball = j.ball else{continue}
                ball.v_x += a_x * interval
                ball.v_y += a_y * interval
                if ball.v_x*mass > threshold {
                    if j.index_j+1 >= j_count{
                        ball.v_x = ball.v_x * (-0.8)
                        myGridItemDataList[j.index_i][j.index_j].ball = ball
                        continue
                    }
                    if myGridItemDataList[j.index_i][j.index_j+1].ball == nil{
                        ball.v_x -= friction/mass
                        myGridItemDataList[j.index_i][j.index_j+1].ball = ball
                        myGridItemDataList[j.index_i][j.index_j].ball = nil
                    }
                } else if ball.v_x*mass < (-threshold){
                    if j.index_j-1 < 0{
                        ball.v_x = ball.v_x * (-0.8)
                        myGridItemDataList[j.index_i][j.index_j].ball = ball
                        continue
                    }
                    if myGridItemDataList[j.index_i][j.index_j-1].ball == nil{
                        ball.v_x += friction/mass
                        myGridItemDataList[j.index_i][j.index_j-1].ball = ball
                        myGridItemDataList[j.index_i][j.index_j].ball = nil
                    }
                } else if ball.v_y*mass > threshold{
                    if j.index_i+1 >= i_count{
                        ball.v_y = ball.v_y * (-0.8)
                        myGridItemDataList[j.index_i][j.index_j].ball = ball
                        continue
                    }
                    if myGridItemDataList[j.index_i+1][j.index_j].ball == nil{
                        ball.v_y -= friction/mass
                        myGridItemDataList[j.index_i+1][j.index_j].ball = ball
                        myGridItemDataList[j.index_i][j.index_j].ball = nil
                    }
                } else if ball.v_y*mass < (-threshold){
                    if j.index_i-1 < 0{
                        ball.v_y = ball.v_y * (-0.8)
                        myGridItemDataList[j.index_i][j.index_j].ball = ball
                        continue
                    }
                    if myGridItemDataList[j.index_i-1][j.index_j].ball == nil{
                        ball.v_y += friction/mass
                        myGridItemDataList[j.index_i-1][j.index_j].ball = ball
                        myGridItemDataList[j.index_i][j.index_j].ball = nil
                    }
                } else {
                    if j.index_i-1 < 0 || j.index_i+1 >= i_count{
                        ball.v_y=0.0
                    }
                    if j.index_j-1 < 0 || j.index_j+1 >= j_count{
                        ball.v_x=0.0
                    }
                    myGridItemDataList[j.index_i][j.index_j].ball = ball
                }
            }
        }
    }
}
