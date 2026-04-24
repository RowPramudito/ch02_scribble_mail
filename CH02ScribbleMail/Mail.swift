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
    // var image_data: String
    
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


let sampleData: [Mail] = [
    Mail(sender: "Barra", recipient: "Rowang", mail_title: "pochita", image_data: UIImage(named:"dummy4")!.pngData()!, isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "reze", image_data: UIImage(named:"dummy2")!.pngData()!, isRead: false),
        Mail(sender: "Barra", recipient: "Rowang", mail_title: "dennis", image_data: UIImage(named:"dummy3")!.pngData()!, isRead: false),
]

