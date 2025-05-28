//
//  EmailSenderView.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import SwiftUI
import AppKit // Für NSWorkspace

struct EmailSenderView: View {
    let recipient: Recipient?
    let subject: String
    let mailBody: String

    var body: some View {
        Button("E-Mail im Mailprogramm öffnen", action: {
            guard let recipient = recipient else { return }

            // URL-Encoding für Betreff und Body ist wichtig!
            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let bodyEncoded = mailBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

            if let url = URL(string: "mailto:\(recipient.emailAddress)?subject=\(subjectEncoded)&body=\(bodyEncoded)") {
                NSWorkspace.shared.open(url)
            }
        })
        .disabled(recipient == nil || subject.isEmpty || mailBody.isEmpty)
    }
}
