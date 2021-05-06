//
//  DateUtil.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//

import Foundation

class DateUtil {
    init() {}
    static func dateToString(date: Date, withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    static func dateOnlyToString(date: Date, withFormat format: String?) -> String? {
        let formatter = DateFormatter()
        if format == "" {
            formatter.dateFormat = "yyyy-MM-dd"
        } else {
            formatter.dateFormat = format
        }
        
        return formatter.string(from: date)
    }
    
    static func timeOnlyToString(date: Date, withFormat format: String?) -> String? {
        let formatter = DateFormatter()
        if format == "" {
            formatter.dateFormat = "hh:mm"
        } else {
            formatter.dateFormat = format
        }
        
        return formatter.string(from: date)
    }
    
    static func dateFrom(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dateString)
    }
}
