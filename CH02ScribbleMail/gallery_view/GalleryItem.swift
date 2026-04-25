//
//  GalleryItem.swift
//  ch02_scribble_mail
//
//  Created by Rowang Pramudito on 24/04/26.
//

import SwiftUI
import SwiftData

struct GalleryItem: View {
    var mail: Mail
    
    var body: some View {
        NavigationLink {
            MailDetailView(mail: mail)
        } label: {
            Image(uiImage: UIImage(data: mail.image_data) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
                .frame(width: 180, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                )
        }
    }
}
