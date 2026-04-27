//
//  MailRow.swift
//  MailAppRemix
//
//  Created by Rowang Pramudito
//

import SwiftUI
import SwiftData

struct MailRow: View {
    var mail: Mail
    
    var body: some View {
        NavigationLink {
            MailDetailView(mail: mail)
        } label: {
            HStack(alignment: .top, spacing: 12) {
                
                HStack(alignment: .center) {
                    if !mail.isRead {
                        Circle()
                            .foregroundStyle(Color.risoCorаl)
                            .frame(width: 8)
                            .padding(.top, 22)
                    }
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.risoNavy)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(mail.sender.prefix(1))
                                .foregroundColor(.risoMustard)
                                .font(.subheadline)
                                .fontDesign(.monospaced)
                        )
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(mail.sender)
                            .foregroundColor(.risoNavy)
                            .fontWeight(.semibold)
                            .fontDesign(.monospaced)
                        
                        Spacer()
                        
                        Text(mail.date_send, style: .date)
                            .foregroundColor(.risoSage)
                            .font(.caption)
                            .fontDesign(.monospaced)
                    }
                    
                    Text(mail.mail_title)
                        .lineLimit(2)
                        .font(.subheadline)
                        .foregroundColor(.risoSage)
                        .fontDesign(.monospaced)
                    
                    Image(uiImage: UIImage(data: mail.image_data) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity).frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.risoSage.opacity(0.4), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 27)
        }
        .simultaneousGesture(TapGesture().onEnded {
            mail.isRead = true
        })
        .padding()
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.risoNavy.opacity(0.08), radius: 6, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    let mail = Mail(sender: "Rowang", recipient: "Barra", mail_title: "Look at my masterpiece", image_data: UIImage(named:"dummy4")!.pngData()!, mail_type: "inbox", isRead: false)

    container.mainContext.insert(mail)
    
    return MailRow(mail: mail)
        .modelContainer(container)
}
