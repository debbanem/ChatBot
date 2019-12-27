//
//  DateExtension.swift
//  ChatBot
//
//  Created by Mark on 5/5/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

extension Date
{
    
    func isEqualTo(_ date: Date) -> Bool
    {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool
    {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool
    {
        return self < date
    }
    
}
