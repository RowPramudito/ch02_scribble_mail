//
//  Mail.swift
//  MailAppRemix
//
//  Created by Rowang Pramudito on 17/04/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Mail: Identifiable {
    
    var sender: String
    var recipient: String
    
    var mail_title: String
    var date_send: Date
    var image_data: Data
    
    var mail_type: String // 'inbox' or 'sent'
    var isRead: Bool = false
    
    init(sender: String, recipient: String, mail_title: String, image_data: Data, mail_type: String, isRead: Bool) {
        self.sender = sender
        self.recipient = recipient
        self.mail_title = mail_title
        self.date_send = Date()
        self.mail_type = mail_type
        self.isRead = isRead
        self.image_data = image_data
    }
}


let sampleData: [Mail] = [
    Mail(sender: "Barra", recipient: "Rowang", mail_title: "look at my masterpiece", image_data: UIImage(named:"dummy4")!.pngData()!, mail_type: "inbox", isRead: false),
    Mail(sender: "Barra", recipient: "Rowang", mail_title: "wife", image_data: UIImage(named:"dummy2")!.pngData()!, mail_type: "inbox", isRead: false),
    Mail(sender: "Barra", recipient: "Rowang", mail_title: "this you?", image_data: UIImage(named:"dummy3")!.pngData()!, mail_type: "inbox", isRead: false),
]

