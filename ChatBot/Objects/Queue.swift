//
//  Queue.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

struct Queue <T> {
    
    var items:[T] = []
    
    mutating func enqueue(element: T)
    {
        items.append(element)
    }
    
    mutating func dequeue() -> T?
    {
        
        if items.isEmpty {
            return nil
        }
        else{
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
}
