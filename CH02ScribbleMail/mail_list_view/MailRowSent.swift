//
//  MailRow.swift
//  MailAppRemix
//
//  Created by Utari Dyani Laksmi on 05/04/26.
//

import SwiftUI
import SwiftData

struct MailRowSent: View {
    var mail: MailSent
    
    var body: some View {
        NavigationLink {
            MailSentDetailView(mail: mail)
        } label: {
            VStack(alignment: .trailing) {
                HStack(alignment: .top) {
                    VStack(alignment: .center) {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Text(mail.sender.prefix(1))
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                )
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(mail.sender)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text(mail.date_send, style: .date)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                
                                Text(mail.mail_title)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Image(uiImage: UIImage(data: mail.image_data) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity).frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                            )
                    }
                    
                }
            }
            .padding(.horizontal, 27)
        }
        .simultaneousGesture(TapGesture().onEnded {
            mail.isRead = true
        })
    }
    
}

/*
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    let mail = MailSent(sender: "Rowang", recipient: "Barra", mail_title: "Look at my masterpiece", image_data: "dummy4", isRead: false)
    container.mainContext.insert(mail)
    
    return MailRowSent(mailSent: mail)
        .modelContainer(container)
}
*/
