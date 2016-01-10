//
//  ConnectionRequest.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/16/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Parse

class ConnectionRequest: PFObject {
    
    @NSManaged var fromUser: User
    @NSManaged var toUser: User
    @NSManaged var accepted: Bool
    
    override init() {
        super.init()
    }
}

extension ConnectionRequest: PFSubclassing {
    static func parseClassName() -> String {
        return "ConnectionRequest"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
}