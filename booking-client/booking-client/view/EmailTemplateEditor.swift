//
//  EmailTemplateEditor.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import SwiftUI
import SwiftData

struct EmailTemplateEditor: View {
    @Bindable var template: EmailTemplate

    var body: some View {
        GroupBox(label: Text("Vorlage bearbeiten").bold()) {
            VStack(alignment: .leading, spacing: 10) {
                TextField("Betreff", text: $template.subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Body:")
                TextEditor(text: $template.body)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))

                Text("Verfügbare Platzhalter: {{name}}, {{salutation}}, {{email}}")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
