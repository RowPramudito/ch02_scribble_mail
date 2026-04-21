//
//  ch02_scribble_mailApp.swift
//  ch02_scribble_mail
//
//  Created by Rowang Pramudito on 21/04/26.
//

import SwiftUI
import SwiftData

@main
struct CH02ScribbleMailApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Mail.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MailListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
