//
//  Message.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/24/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class Message: NSObject {
    var senderId_: String? = ""
    var senderDisplayName_ : String? = ""
    var date_ : NSDate
    var isMediaMessage_ : Bool
    var hash_ : Int = 0
    var text_: String? = ""
    
    convenience init(senderId: String?, senderDisplayName: String?, text: String?) {
        self.init(senderId: senderId, senderDisplayName: senderDisplayName, isMediaMessage: false, hash: 0, text: text)
    }
    
    init(senderId: String?, senderDisplayName: String?, isMediaMessage: Bool, hash: Int, text: String?) {
        self.senderId_ = senderId
        self.senderDisplayName_ = senderDisplayName
        self.date_ = NSDate()
        self.isMediaMessage_ = isMediaMessage
        self.hash_ = hash
        self.text_ = text
    }
}

extension Message: JSQMessageData {
    func senderId() -> String! {
        return senderId_
    }
    
    func senderDisplayName() -> String! {
        return senderDisplayName_
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func isMediaMessage() -> Bool {
        return isMediaMessage_;
    }
    
    func messageHash() -> UInt {
        let signed = rand()
        let unsigned = signed >= 0 ?
            UInt(signed):
            UInt(signed - Int.min) + UInt(Int.max) + 1
        return unsigned
    }
    
    func text() -> String! {
        return text_;
    }
}
