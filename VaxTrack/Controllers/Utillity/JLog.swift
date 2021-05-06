//
//  JLog.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/6/21.
//

import UIKit

func JLog(_ message:String? = nil, file:String = #file, function:String = #function, line:Int = #line) {
//    #if DEBUG
        var msgString = "[\((file as NSString).lastPathComponent).\(function)() :\(line)]"
        if let msg = message {
            msgString = msgString + " " + msg
        }
        print(msgString)
//    #endif
}

func JLog(_ message:String? = nil, CGSize size:CGSize, file:String = #file, function:String = #function, line:Int = #line) {
//    #if DEBUG
    var msgString = "[\((file as NSString).lastPathComponent).\(function)() :\(line)]"
    msgString = msgString + (message ?? "") + "CGSize (\((message ?? "")))\nwidth: \(size.width)\nheight: \(size.height)"
    print(msgString)
//    #endif
}

func JLog(_ message:String? = nil, CGRect rect:CGRect, file:String = #file, function:String = #function, line:Int = #line) {
//    #if DEBUG
    var msgString = "[\((file as NSString).lastPathComponent).\(function)() :\(line)]"
    msgString = msgString + "CGRect (\((message ?? "")))\norig.x: \(rect.origin.x)\norig.y: \(rect.origin.y)\nsize.w: \(rect.size.width)\nsize.h: \(rect.size.height)"
    print(msgString)
//    #endif
}

//func JLogUser(_ user:User, file:String = #file, function:String = #function, line:Int = #line) {
//    #if DEBUG
//        var msgString = "[\((file as NSString).lastPathComponent).\(function)() :\(line)]"
//        msgString = msgString + "UserInfo: \(user.uid) / \(user.email) / \(user.username)"
//        print(msgString)
//    #endif
//}
//
//func JLogUser(_ message:String, user:User, file:String = #file, function:String = #function, line:Int = #line) {
//    #if DEBUG
//        var msgString = "[\((file as NSString).lastPathComponent).\(function)() :\(line)]"
//        msgString = msgString + " \(message)\nUserInfo: \(user.uid) / \(user.email) / \(user.username) "
//        print(msgString)
//    #endif
//}


