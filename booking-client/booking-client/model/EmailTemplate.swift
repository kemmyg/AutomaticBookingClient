//
//  EmailTemplate.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import Foundation
import SwiftData

@Model
final class EmailTemplate {
    @Attribute(.unique) var id: UUID
    var name: String
    var subject: String
    var body: String
    
    init(id: UUID, name: String, subject: String, body: String) {
        self.id = id
        self.name = name
        self.subject = subject
        self.body = body
    }
    
    func fillTemplate(recipient: Recipient) -> (subject: String, body: String) {
        var personalizedBody = body
        personalizedBody = personalizedBody.replacingOccurrences(of: "{{name}}", with: name)
        personalizedBody = personalizedBody.replacingOccurrences(of: "{{salutation}}", with: recipient.salutation)
        personalizedBody = personalizedBody.replacingOccurrences(of: "{{email}}", with: recipient.emailAddress)


        var personalizedSubject = subject
        personalizedSubject = personalizedSubject.replacingOccurrences(of: "{{name}}", with: recipient.name)
        // ... und so weiter für den Betreff

        return (personalizedSubject, personalizedBody)
    }
}
