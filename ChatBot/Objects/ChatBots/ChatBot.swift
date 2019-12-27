//
//  ChatBot.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation


class ChatBot: Member
{
    let id: Int?
    let name: String?
    var chat: ChatModel?
    var type: ChatBotType?
    var queue: Queue<Message>?
    let checkInterval = 1.0
    
    enum ChatBotType
    {
        case Repeater
    }
    
    init(id: Int, name: String)
    {
        self.id = id
        self.name = name
        
        super.init()
        self.showMessagesOnRight = false
        queue = Queue<Message>()
    }
    
    
    
    
    
}

