//
//  Extensions.swift
//  ChatBot
//
//  Created by Mark on 5/4/19.
//  Copyright © 2019 ChatBot. All rights reserved.
//

import Foundation

extension DateFormatter
{
    static var cbDateFormat: String
    {
        return "dd/MM/yyyy hh:mm:ss a"
    }
    static var cbDisplayDateFormat: String
    {
        return "hh:mm a"
    }

    static func localToUTC(date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone.current

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func UTCToLocal(date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func getCurrentDate(with format: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: dateFormatter.string(from: Date()))!
    }
    
    static func getCurrentDateString(with format: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: Date())
    }
    
    
    static func getDate(from string:String, with format: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: string)!
    }
    
    static func getString(from date:Date, with format: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: date)
    }
}
