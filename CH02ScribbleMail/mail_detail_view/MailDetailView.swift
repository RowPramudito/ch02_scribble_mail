//
//  SecondScreenView.swift
//  MailAppRemix
//
//  Created by Rowang Pramudito on 19/04/26.
//

import SwiftUI
import SwiftData

struct MailDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var showDeleteAlert: Bool = false
    @State private var isComposing: Bool = false
    
    var mail: Mail
    
    var body: some View {
        NavigationStack {
            VStack() {
                HStack(alignment: .top, spacing: 12) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.risoNavy)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(mail.sender.prefix(1))
                                .foregroundColor(.risoMustard)
                                .font(.subheadline)
                                .fontDesign(.monospaced)

                        )
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(mail.sender)
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                            Spacer()
                            Text(mail.date_send, style: .date)
                                .foregroundColor(.gray)
                                .fontDesign(.monospaced)
                                .font(.subheadline)
                        }
                        HStack {
                            Text("To: ")
                                .fontDesign(.monospaced)
                            Text(mail.recipient)
                                .foregroundColor(.gray)
                                .fontDesign(.monospaced)

                        }
                    
                    }

                }
                
                // Divider()
    
                VStack(alignment: .leading) {
                    Text(mail.mail_title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 12)
                        .fontDesign(.monospaced)

                    
                    Image(uiImage: UIImage(data: mail.image_data) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.25), lineWidth: 2)
                        )
                }
                .padding(.top, 16).padding(.bottom, 12)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(25)
            
            //reply button
        }
        .toolbar(.hidden, for: .tabBar) 
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderedProminent).tint(Color.risoCorаl)
                .alert("Delete Message", isPresented: $showDeleteAlert) {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(mail)
                            try? modelContext.save()
                            dismiss()
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Are you sure you want to delete this message?")
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isComposing = true
                } label: {
                    HStack {
                        Image(systemName: "paperplane")
                        Text("Reply")
                            .fontDesign(.monospaced)
                    }
                    .padding(.horizontal, 8)
                }
                .buttonStyle(.borderedProminent).tint(Color.risoNavy)
                .sheet(isPresented: $isComposing) {
                    if mail.mail_type == "inbox" {
                        ComposeMailView(isYourOwnMail: false, imageBackground: UIImage(data: mail.image_data), recipient: mail.sender)
                    }
                    else {
                        ComposeMailView(isYourOwnMail: true, recipient: mail.recipient)
                    }
                    
                }
            }
        }
    }
}


#Preview {
    return MailDetailView(
        mail: Mail(sender: "Rowang", recipient: "Barra", mail_title: "Hi, how are you?", image_data: UIImage(named:"dummy1")!.pngData()!, mail_type: "inbox", isRead: false)
    )
}
