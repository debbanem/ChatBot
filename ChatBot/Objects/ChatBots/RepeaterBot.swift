//
//  RepeaterBot.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

class RepeaterBot: ChatBot
{
    var timer = Timer()
    
    override init(id: Int, name: String)
    {
        super.init(id: id, name: name)
        self.type = .Repeater
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(checkQueue), userInfo: nil, repeats: true)
        
    }
    
    
    func reply() -> Message
    {
        let message = queue?.dequeue()
        
        return Message(text: "\(message!.text!)\n\(message!.text!)", owner: self, receiver: AppDelegate.user)
    }
    
    @objc func checkQueue(){
        if(queue?.items.count != 0)
        {
            let chatBotReply = self.reply()
            
            self.chat?.addMessage(message: chatBotReply)
        }
        NotificationCenter.default.post(name: Notification.Name("updateDialogs"), object: nil)
        print("QueueChecked")
    }
    
}
