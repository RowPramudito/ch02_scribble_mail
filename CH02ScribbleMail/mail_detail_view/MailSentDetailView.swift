//
//  SecondScreenView.swift
//  MailAppRemix
//
//  Created by Rowang Pramudito on 19/04/26.
//

import SwiftUI
import SwiftData

struct MailSentDetailView: View {
    
    @State private var isComposing: Bool = false
    var mail: MailSent
    
    var body: some View {
        NavigationStack {
            VStack() {
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(mail.sender.prefix(1).uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(mail.sender)
                            .fontWeight(.semibold)
                        HStack {
                            Text("To: ")
                            Text(mail.recipient)
                                .foregroundColor(.gray)
                        }
                    
                    }
                    Spacer()
                    Text(mail.date_send, style: .date)
                        .foregroundColor(.gray)
                }
                
                // Divider()
    
                VStack(alignment: .leading) {
                    Text(mail.mail_title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 12)
                    
                    /*
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.white))
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.25), lineWidth: 2)
                        )
                    */
                    
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
        
                VStack() {
                    Button("Reply", systemImage: "paperplane") {
                        isComposing = true
                    }
                    .frame(maxWidth: 81, maxHeight: 10)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .sheet(isPresented: $isComposing) {
                        ComposeMailView()
                    }
                }
                /*
                mail.drawing
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                VStack(){
                    NavigationLink{
                        ComposeMailView()
                    } label: {
                        Text("Reply")
                            .frame(maxWidth: 100, maxHeight: 10)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                */
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(25)
            
            //reply button
            

        }
    }
}


#Preview {
    return MailDetailView(
        mail: Mail(sender: "Rowang", recipient: "Barra", mail_title: "Hi, how are you?", image_data: "dummy1", isRead: false)
    )
}
