//
//  ContentView.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import SwiftUI
import SwiftData

import SwiftUI
#Preview {
    ContentView()
        .modelContainer(for: [Recipient.self, EmailTemplate.self])
}

struct ContentView: View {
    // Beispiel-Daten (später aus einer persistenten Quelle laden)
    @State private var recipients: [Recipient] = [
        Recipient(id: UUID(), name: "Cooler Club", emailAdress: "cooler.club@club.de", salutation: "Moin")
    ]

    @State private var templates: [EmailTemplate] = [
        EmailTemplate(id: UUID(), name: "Standard Anfrage", subject: "Booking Anfrage", body: """
        {{salutation}},
        vielen Dank für Ihr Interesse. Gerne würde ich mehr über die Veranstaltung erfahren.
        Mein Name ist {{name}}.

        Viele Grüße        
""")

    ]
    
    // Zustand für die Auswahl
    @State private var selectedRecipient: Recipient?
    @State private var selectedTemplate: EmailTemplate?
    @State private var personalizedEmailBody: String = ""
    @State private var personalizedEmailSubject: String = ""


    var body: some View {
            NavigationSplitView {
                // LEFT PANE (Sidebar)
                List(selection: $selectedTemplate) {
//                    Section("Empfänger") {
//                        ForEach(recipients, id: \.id) { recipient in
//                            Text(recipient.name)
//                                .tag(recipient as Recipient?)
//                        }
//                    }

                    Section("Vorlagen") {
                        ForEach(templates, id: \.id) { template in
                            Text(template.name)
                                .tag(template as EmailTemplate?)
                        }
                    }
                }
                .listStyle(.sidebar)
            } detail: {
                // RIGHT PANE (Detail)
                VStack(alignment: .leading, spacing: 20) {
                    if let template = selectedTemplate {
                        EmailTemplateEditor(template: template)

                        Button("E-Mail erstellen & Vorschau") {
                            if let recipient = selectedRecipient {
                                let result = template.fillTemplate(recipient: recipient)
                                personalizedEmailSubject = result.subject
                                personalizedEmailBody = result.body
                            }
                        }
                        .disabled(selectedRecipient == nil)

                        Text("Vorschau:")
                            .font(.headline)

                        Text("Betreff: \(personalizedEmailSubject)").bold()

                        ScrollView {
                            Text(personalizedEmailBody)
                                .padding()
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(8)
                        }

                        EmailSenderView(
                            recipient: selectedRecipient,
                            subject: personalizedEmailSubject,
                            mailBody: personalizedEmailBody
                        )
                    } else {
                        Text("Bitte eine Vorlage auswählen.")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
        }
}

// Erweitere Recipient und EmailTemplate um Hashable für die Verwendung in List(selection:)
// Stelle sicher, dass die UUIDs korrekt für die Eindeutigkeit sorgen.
extension Recipient: Hashable {}
extension EmailTemplate: Hashable {}
