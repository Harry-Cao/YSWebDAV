//
//  Item.swift
//  YSWebDAV
//
//  Created by HarryCao on 2024/5/26.
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
