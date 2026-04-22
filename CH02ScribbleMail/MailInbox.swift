//
//  MailInbox.swift
//  ch02_scribble_mail
//
//  Created by Rowang Pramudito on 22/04/26.
//

import Foundation
import SwiftData


struct MailInbox: Identifiable {
    var id: UUID = UUID()
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

/*
 var sampleData [MailInbox] = [
 Mail(sender: <#T##String#>, recipient: <#T##String#>, mail_title: <#T##String#>, image_data: <#T##String#>, isRead: <#T##Bool#>),
 ]
 */
