//
//  ChatBotProtocol.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

enum ChatBotType {
    case Repeater
}

protocol ChatBotProtocol{
    func reply(text: String) -> String
}

