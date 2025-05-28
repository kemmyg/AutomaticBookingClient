//
//  booking_clientApp.swift
//  booking-client
//
//  Created by Lucas Kemmler Privat on 28.05.25.
//

import SwiftUI
import SwiftData

@main
struct booking_clientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Recipient.self, EmailTemplate.self])
    }
}
