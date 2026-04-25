//
//  GalleryView.swift
//  MailAppRemix
//
//  Created by Al Barra' Nasser Attamimy on 21/04/26.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    // let mails: [Mail]
    
    @Query(sort: \Mail.date_send, order: .reverse) var mails: [Mail]
    // var mails: [Mail]
    
    @State var selectedFilter = "Inbox"
    let filters = ["Inbox", "Sent"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            Picker("Filter", selection: $selectedFilter) {
                ForEach(filters, id: \.self) { filter in
                    Text(filter)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    if selectedFilter.lowercased() == "inbox" {
                        ForEach(mails.filter { $0.mail_type.lowercased() == "inbox" }) {
                            mail in GalleryItem(mail: mail)
                        }
                    }
                    else {
                        ForEach(mails.filter { $0.mail_type.lowercased() == "sent" }) {
                            mail in GalleryItem(mail: mail)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Drawing Gallery")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    for mail in sampleData {
        container.mainContext.insert(mail)
    }
    
    return GalleryView()
        .modelContainer(container)
}

