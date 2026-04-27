//
//  MainScreen.swift
//  ch02_scribble_mail
//
//  Created by Rowang Pramudito on 21/04/26.
//

import SwiftUI
import SwiftData

struct MainScreenView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MailListView()
            }
            .tabItem { Label("Mail", systemImage: "envelope.fill") }
            
            NavigationStack {
                GalleryView()
            }
            .tabItem { Label("Gallery", systemImage: "photo.stack.fill") }
        }
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.risoSage)
            UITabBarItem.appearance().setTitleTextAttributes(
                [.font: UIFont.monospacedSystemFont(ofSize: 10, weight: .regular)],
                for: .normal
            )
            UITabBarItem.appearance().setTitleTextAttributes(
                [.font: UIFont.monospacedSystemFont(ofSize: 10, weight: .medium)],
                for: .selected
            )
        }
        .tint(Color.risoCorаl)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    for mail in sampleData {
        container.mainContext.insert(mail)
    }
    
    return MainScreenView()
        .modelContainer(container)
}
