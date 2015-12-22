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
    static let ParseFromUser = "fromUser"
    static let ParseToUser = "toUser"
    static let ParseAccepted = "accepted"
    
    // User properties
    static let ParseIsMentor = "isMentor"
    static let ParseLocation = "location"
    static let username = "username"
    
    //
    
    /**
    Fetches nearby users according to the distance filter and range
    
    - parameter range:           The number of results to display
    - parameter distanceFilter:  The radius of reach for the search
    - parameter completionBlock: Returns Mentors that are around a user
    */
    static func mentorsNearbyCurrentUser(range: Range<Int>, distanceFilter: Double, completionBlock: PFQueryArrayResultBlock) {
        let nearbyUsersQuery = User.query()
        nearbyUsersQuery?.cachePolicy = .NetworkOnly
        
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
    
    static func connectionsForUser(user: User, completionBlock: PFQueryArrayResultBlock) {
        let userConnectionQuery = PFQuery(className: ParseConnectionClass)
        userConnectionQuery.cachePolicy = .NetworkOnly
        userConnectionQuery.includeKey(ParseToUser)
        
        userConnectionQuery.whereKey(ParseFromUser, equalTo: User.currentUser()!)
        
        userConnectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    /**
     Sends a 'friend / connection request' to a User
     
     - parameter user:   The user sending the connection request
     - parameter toUser: The reciepient of the connection request
     */
    static func requestConnectionFromUser(user: User, toUser: User) {
        let connectionRequestObject = ConnectionRequest()
        connectionRequestObject.fromUser = user
        connectionRequestObject.toUser = toUser
        connectionRequestObject.accepted = false
        
        connectionRequestObject.saveInBackgroundWithBlock(ErrorHandler.errorHandlingCallback)
    }
    
    /**
     Fetches all pending requests sent to a User
     
     - parameter user:             The recipient of a connection request
     - parameter complectionBlock: Completion block with results
     */
    static func pendingRequestsForUser(user: User, complectionBlock: PFQueryArrayResultBlock) {
        let requestQuery = ConnectionRequest.query()
        requestQuery?.whereKey(ParseToUser, equalTo: user)
            .whereKey(ParseAccepted, equalTo: false)
        requestQuery?.includeKey(ParseFromUser)
        
        requestQuery?.findObjectsInBackgroundWithBlock(complectionBlock)
    }
    
    /**
     Calls a cloud fuction which adds the current user to the fromUser's connections
     We pass in the object id of the connectionRequest as a parameter
     
     - parameter request: The connection request
     */
    static func acceptConnectionRequest(request: ConnectionRequest) {
        let fromUser = request.fromUser
        PFCloud.callFunctionInBackground("addToConnections", withParameters: ["connectionRequest":request.objectId!]) {
            (object, error) -> Void in
            
            if error != nil {
                
            }else {
                let connection = PFObject(className: ParseConnectionClass)
                connection[ParseFromUser] = fromUser
//                connection[ParseToUser] =
            }
        }
    }
}
