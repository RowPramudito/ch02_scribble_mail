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
            MailSent.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        let sampleData: [Mail] = [
                Mail(sender: "Rowang", recipient: "Barra", mail_title: "pochita", image_data: "dummy4", isRead: false),
                Mail(sender: "Barra", recipient: "Rowang", mail_title: "reze", image_data: "dummy2", isRead: false),
                Mail(sender: "Barra", recipient: "Rowang", mail_title: "dennis", image_data: "dummy3", isRead: false),
        ]
        
        for mail in sampleData {
            sharedModelContainer.mainContext.insert(mail)
        }
    }

    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
        .modelContainer(sharedModelContainer)
    }
}
