//
//  Item.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
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
