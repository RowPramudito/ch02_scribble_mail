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
                            ForEach(mails) { mailData in
                                MailRow(mail:mailData)
                                    .padding(.bottom, 20)
                            }
                            
                        } header: {
                            Text("Older Messages")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.top, 8).padding(.bottom, 12)
                        }
                    }
                }
                

                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("SketchMail")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                
                // to separate the buttons, use toolbar spacer
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Select") {}
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
                        ComposeMailView()
                    }
                }
                
                
            }
            // .searchable(text: .constant(""), prompt: "Search" )
            
            
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
