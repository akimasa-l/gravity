//
//  Item.swift
//  gravity
//
//  Created by 劉明正 on 2024/04/12.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
