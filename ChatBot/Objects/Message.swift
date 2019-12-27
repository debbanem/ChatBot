//
//  Message.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

class Message
{
    var text: String?
    var date: String?
    var owner: Member?
    var receiver: Member?
    
    init(text: String, owner: Member, receiver: Member) {
        self.text = text
        self.date = DateFormatter.getCurrentDateString(with: DateFormatter.cbDateFormat)
        
        
        self.owner = owner
        self.receiver = receiver
    }
}
