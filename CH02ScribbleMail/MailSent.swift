//
//  MailSent.swift
//  ch02_scribble_mail
//
//  Created by Rowang Pramudito on 22/04/26.
//

import Foundation
import SwiftData

@Model
class MailSent: Identifiable {
    
    var sender: String
    var recipient: String
    
    var mail_title: String
    var date_send: Date
    // var image_data: String // as string for now, just to call the image asset
    
    // use this later when we use real image
    var image_data: Data
    
    var isRead: Bool = false
    
    init(sender: String, recipient: String, mail_title: String, image_data: Data, isRead: Bool) {
        self.sender = sender
        self.recipient = recipient
        self.mail_title = mail_title
        self.date_send = Date()
        self.isRead = isRead
        self.image_data = image_data
    }
}
