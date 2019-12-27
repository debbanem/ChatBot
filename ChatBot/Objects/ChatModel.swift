//
//  ChatModel.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

class ChatModel
{
    
    let id: Int?
    let bot: ChatBot?
    var dateCreated: Date?
    var messages:Array<Message>?
    var isSelected: Bool
    
    init(id: Int, bot: ChatBot)
    {
        self.id = id
        self.bot = bot
        self.messages = Array<Message>()
        self.isSelected = false
        self.dateCreated = DateFormatter.getCurrentDate(with: DateFormatter.cbDateFormat)
    }
    
    func addMessage(message: Message){
            self.messages?.insert(message, at: 0)
        NotificationCenter.default.post(name: Notification.Name("updateMessages"), object: nil)
            
    }
    
    
}

