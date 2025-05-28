//
//  Recipient.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import Foundation
import SwiftData

@Model
final class Recipient {
    @Attribute(.unique) var id: UUID
    var name: String
    var emailAddress: String
    var salutation: String
    
    init(id: UUID, name: String, emailAdress: String, salutation: String) {
        self.id = id
        self.name = name
        self.emailAddress = emailAdress
        self.salutation = salutation
    }
}
