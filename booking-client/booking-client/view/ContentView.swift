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
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Empfänger")
                            .font(.headline)
                        List(recipients, selection: $selectedRecipient) { recipient in
                            Text(recipient.name).tag(recipient) // tag für selection
                        }
                        
                        .frame(height: 100)
                        
                        Text("Vorlagen")
                            .font(.headline)
                        List(templates, selection: $selectedTemplate) { template in
                            Text(template.name).tag(template)
                        }
                        
                        .frame(height: 100)
                        
                        if let template = selectedTemplate {
                            
                        }
                        
                        Button("E-Mail erstellen & Vorschau") {
                            if let recipient = selectedRecipient, let template = selectedTemplate {
                                let emailContent = template.fillTemplate(recipient: recipient)
                                personalizedEmailSubject = emailContent.subject
                                personalizedEmailBody = emailContent.body
                            }
                        }
                        .disabled(selectedRecipient == nil || selectedTemplate == nil)
                        
                        Divider()
                        
                        Text("Vorschau:")
                            .font(.headline)
                        Text("Betreff: \(personalizedEmailSubject)")
                        ScrollView {
                            Text(personalizedEmailBody)
                        }
                        
                        Spacer() // Schiebt alles nach oben
                        
                        // Hier kommt der Senden-Button
                        EmailSenderView(recipient: selectedRecipient, subject: personalizedEmailSubject, mailBody: personalizedEmailBody)
                        
                    }
                    .padding()
                    .frame(minWidth: 300) // Mindestbreite für die Seitenleiste/Hauptansicht
                    
                    // Detailansicht oder Platzhalter, falls benötigt
                    Text("Wähle einen Empfänger und eine Vorlage, um eine E-Mail zu erstellen.")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

// Erweitere Recipient und EmailTemplate um Hashable für die Verwendung in List(selection:)
// Stelle sicher, dass die UUIDs korrekt für die Eindeutigkeit sorgen.
extension Recipient: Hashable {}
extension EmailTemplate: Hashable {}
