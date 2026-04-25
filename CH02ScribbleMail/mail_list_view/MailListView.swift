//
//  FirstScreenView.swift
//  MailAppRemix
//
//  Created by Utari Dyani Laksmi on 05/04/26.
//

import SwiftUI
import SwiftData

struct MailListView: View {
    @Query(sort: \Mail.date_send, order: .reverse) var mails: [Mail]
    
    @State private var isComposing: Bool = false
    
    //filtering / segmented display
    @State var selectedFilter = "Inbox"
    let filters = ["Inbox", "Sent"]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Updated Just Now")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(Color.gray)
                
                
                // Mail category picker
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                
                // list of mails
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Section {
                            if selectedFilter.lowercased() == "inbox" {
                                ForEach(mails.filter { $0.mail_type.lowercased() == "inbox" }) { mailData in
                                    MailRow(mail: mailData)
                                        .padding(.bottom, 12)
                                }
                            }
                            else {
                                ForEach(mails.filter { $0.mail_type.lowercased() == "sent" }) { mailData in
                                    MailRowSent(mail: mailData)
                                        .padding(.bottom, 12)
                                }
                            }
                        }
                        .padding(.top, 24)
                    }
                }
            }
            .navigationTitle("SketchMail")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                }
                // to separate the buttons, use toolbar spacer
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Select") {
                        
                    }
                }
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
                
                
                // bottom toolbar
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button("Compose", systemImage: "pencil.and.outline") {
                        isComposing = true
                    }
                    .sheet(isPresented: $isComposing) {
                        ComposeMailView(isYourOwnMail: false, recipient: "")
                    }
                }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    for mail in sampleData {
        container.mainContext.insert(mail)
    }
    
    return MailListView()
        .modelContainer(container)
}
