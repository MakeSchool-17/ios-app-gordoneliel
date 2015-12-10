//
//  ParseHelper.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import Parse

class ParseHelper: NSObject {
    
    // Connection Relation
    static let ParseConnectionClass = "Connection"
    static let ParseFromUser =  "fromUser"
    static let ParseToUser = "toUser"
    
    // User properties
    static let ParseIsMentor = "isMentor"
    static let ParseLocation = "location"
    static let username = "username"
    
    
    /**
     Fetches nearby users according to the distance filter and range
     
     - parameter range:           The number of results to display
     - parameter distanceFilter:  The radius of reach for the search
     - parameter completionBlock: Returns Mentors that are around a user
     */
    static func mentorsNearbyCurrentUser(range: Range<Int>, distanceFilter: Double, completionBlock: PFQueryArrayResultBlock) {
        let nearbyUsersQuery = User.query()
        nearbyUsersQuery?.cachePolicy = .CacheThenNetwork
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint, error) -> Void in
            guard let geoPoint = geoPoint else {return}

            nearbyUsersQuery?.whereKey(ParseLocation, nearGeoPoint: geoPoint, withinMiles: distanceFilter)
            .whereKey(ParseIsMentor, equalTo: true)
            .whereKey(username, notEqualTo: User.currentUser()!.username!)
            
            nearbyUsersQuery?.skip = range.startIndex
            nearbyUsersQuery?.limit = range.endIndex - range.startIndex
            
            nearbyUsersQuery?.findObjectsInBackgroundWithBlock(completionBlock)
        }
    }
    
    static func fetchUserConnection(range: Range<Int>, completionBlock: PFQueryArrayResultBlock) {
        let userConnectionQuery = PFQuery(className: ParseConnectionClass)
        
        userConnectionQuery.whereKey(ParseFromUser, equalTo: User.currentUser()!)
        
        userConnectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
}
