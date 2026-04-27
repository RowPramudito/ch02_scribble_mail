import SwiftUI
import SwiftData

struct MailListView: View {
    @Query(sort: \Mail.date_send, order: .reverse) var mails: [Mail]
    
    @State private var isComposing: Bool = false
    
    @State var selectedFilter = "Inbox"
    let filters = ["Inbox", "Sent"]
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)],
            for: .normal
        )
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.risoBackground)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Updated just now")
                    .font(.subheadline)
                    .fontDesign(.monospaced)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(.risoSage)
                
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
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
                        } header: {
                            Text("Older Messages")
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                                .foregroundColor(.risoSage)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.top, 8).padding(.bottom, 12)
                        }
                        .padding(.top, 24)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Sketchmail")
                        .font(.title2.monospaced().bold())
                        .foregroundColor(.risoNavy)
                }
                // to separate the buttons, use toolbar spacer
                
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button("Compose", systemImage: "pencil.and.outline") {
                        isComposing = true
                    }
                    .tint(.risoCorаl)
                    .sheet(isPresented: $isComposing) {
                        ComposeMailView(isYourOwnMail: false, recipient: "")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
