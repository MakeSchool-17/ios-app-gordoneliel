//
//  PFObject+Extensions.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/27/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import Parse

extension PFObject {
    public override func isEqual(object: AnyObject?) -> Bool {
        if (object as? PFObject)?.objectId == self.objectId {
            return true
        } else {
            return super.isEqual(object)
        }
    }
}
