//
//  ParseHelper.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import Parse

typealias IndustryConfigCallback = ([String]) -> Void
class ParseHelper: NSObject {
    
    // Connection Relation
    static let ParseConnectionClass = "Connection"
    static let ParseFromUser = "fromUser"
    static let ParseToUser = "toUser"
    static let ParseAccepted = "accepted"
    static let ParseConnectionRelation = "connections"
    
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
        let connectionRelation = user.relationForKey(ParseConnectionRelation)
        let connectionQuery = connectionRelation.query()
        connectionQuery.cachePolicy = .CacheThenNetwork
        
        connectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
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
    static func pendingRequestsForUser(completionBlock: PFQueryArrayResultBlock) {
        let requestQuery = ConnectionRequest.query()
        requestQuery?.whereKey(ParseToUser, equalTo: User.currentUser()!)
            .whereKey(ParseAccepted, equalTo: false)
        requestQuery?.includeKey(ParseFromUser)
        
        requestQuery?.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    /**
     Calls a cloud fuction which adds the current user to the fromUser's connections
     We pass in the object id of the connectionRequest as a parameter
     
     - parameter request: The connection request
     */
    static func acceptConnectionRequest(request: ConnectionRequest, completionCallback: PFBooleanResultBlock) {
        let fromUser = request.fromUser
        PFCloud.callFunctionInBackground("AddToConnections", withParameters: ["connectionRequest":request.objectId!]) {
            (object, error) -> Void in
            
            if error != nil {
                
            }else {
                let relation = User.currentUser()!.relationForKey(ParseConnectionRelation)
                relation.addObject(fromUser)
                User.currentUser()!.saveInBackgroundWithBlock(completionCallback)
            }
        }
    }
    
    /**
     Fetches the industries from parse config
     
     - returns: An array of industries
     */
    static func fetchIndustryConfig(callback: IndustryConfigCallback) {
        PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig?, error: NSError?) -> Void in

            if error == nil {
                 let industries = config?["Industries"] as! [String]
                callback(industries)
            } else {
                print("Failed to fetch. Using Cached Config.")
                config = PFConfig.currentConfig()
            }
        }
    }
}
