//
//  Notification.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/3/21.
//
import UIKit

class Notification {
    var id: Int
    var title: String
    var content: String
    var time: String
    
    init(id: Int, title: String, content: String, time: String) {
        self.id = id
        self.title = title
        self.content = content
        self.time = time
    }
    
    func toDict() -> NSDictionary {
        return [
            "id": id,
            "title": title,
            "content": content,
            "time": time
        ]
    }
}
