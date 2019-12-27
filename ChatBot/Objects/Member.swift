//
//  Member.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

class Member {
    
    var role: Role?
    var showMessagesOnRight: Bool?
    
    enum Role {
        case Owner
        case Receiver
    }
    
    init() {}

}

