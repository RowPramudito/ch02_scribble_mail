//
//  MailRow.swift
//  MailAppRemix
//
//  Created by Utari Dyani Laksmi on 05/04/26.
//

import SwiftUI
import SwiftData

struct MailRow: View {
    var mail: Mail
    
    var body: some View {
        NavigationLink {
            MailDetailView(mail: mail)
        } label: {
            HStack (alignment: .top, spacing: 12) {
                
                // Unread indicator & icon stack
                HStack(alignment: .center) {
                    if !mail.isRead {
                        Circle()
                            .foregroundStyle(Color.blue)
                            .frame(width: 8)
                    }
            
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(mail.sender.prefix(1))
                                .foregroundColor(.white)
                                .font(.subheadline)
                        )
                }
                
                // Mail overview: sender, mail title, drawing, date sent
                VStack (alignment: .leading) {
                    
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
                    
                    /*
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                        .frame(maxWidth: .infinity).frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    */
                    
                    Image(mail.image_data)
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
            .padding(.horizontal)
        }
        .simultaneousGesture(TapGesture().onEnded {
            mail.isRead = true
        })
    }
    
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    let mail = Mail(sender: "Rowang", recipient: "Barra", mail_title: "eeeeeeeeeeeee", image_data: "dummy1", isRead: false)
    container.mainContext.insert(mail)
    
    return MailRow(mail: mail)
        .modelContainer(container)
}

