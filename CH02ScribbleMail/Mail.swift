//
//  Mail.swift
//  MailAppRemix
//
//  Created by Rowang Pramudito on 17/04/26.
//

import Foundation
import SwiftData

@Model
class Mail: Identifiable {
    
    var sender: String
    var recipient: String
    
    var mail_title: String
    var date_send: Date
    var image_data: String // as string for now, just to call the image asset
    
    // use this later when we use real image
    // var imageData: Data?
    
    var isRead: Bool = false
    
    init(sender: String, recipient: String, mail_title: String, image_data: String, isRead: Bool) {
        self.sender = sender
        self.recipient = recipient
        self.mail_title = mail_title
        self.date_send = Date()
        self.isRead = isRead
        self.image_data = image_data
    }
}


let sampleData: [Mail] = [
        Mail(sender: "Rowang", recipient: "Barra", mail_title: "pochita", image_data: "dummy4", isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "reze", image_data: "dummy2", isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "dennis", image_data: "dummy3", isRead: false),
        Mail(sender: "Rowang", recipient: "Barra", mail_title: "pochita", image_data: "dummy4", isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "reze", image_data: "dummy2", isRead: false),
        Mail(sender: "Rowang", recipient: "Barra", mail_title: "pochita", image_data: "dummy4", isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "reze", image_data: "dummy2", isRead: false),
]

