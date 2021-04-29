//
//  DateUtil.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//

import Foundation

class DateUtil {
    static func dateToString(date: Date, withFormat format: String) -> String? {
        let formatter = DateFormatter()
        if format == "" {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            formatter.dateFormat = format
        }
        
        return formatter.string(from: date)
    }
    
    static func stringToDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dateString)
    }
}
