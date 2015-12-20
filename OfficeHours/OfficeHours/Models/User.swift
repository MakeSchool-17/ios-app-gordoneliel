//
//  User.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/1/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import Foundation
import Bond
import Parse

class User: PFUser {
    @NSManaged var about: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var profileImage: PFFile?
    @NSManaged var jobTitle: String?
    @NSManaged var workName: String?
    @NSManaged var name: String?
    @NSManaged var location: PFGeoPoint?
    
    var image: Observable<UIImage?> = Observable(nil)
    var userName: Observable<String?> = Observable(nil)
    var userJobTitle: Observable<String?> = Observable(nil)
    var userWorkName: Observable<String?> = Observable(nil)
    var userAbout: Observable<String?> = Observable(nil)
    var connectionRequests: Observable<User?> = Observable(nil)
    var connections: Observable<[User]?> = Observable(nil)
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    override init() {
        super.init()
    }
    
    /**
     Fetches all connections of a user
     */
    func fetchConnections() {
        // 1
        if (connections.value != nil) {
            return
        }
        // 2
        ParseHelper.connectionsForUser(self) {
            (var connections: [PFObject]?, error: NSError?)  -> Void in
            
            // 3
            connections = connections?.filter { connection in
                
                connection[ParseHelper.ParseToUser] != nil
            }
            
            // 4
            self.connections.value = connections?.map { connection in
                let toUser = connection[ParseHelper.ParseToUser] as! User
                
                return toUser
            }
        }
    }
    
    func isUserConnectedWithMentor(user: User) -> Bool {
        if let connections = connections.value {
            return connections.contains(user)
        } else {
            return false
        }
    }
    
    // MARK: Fetch Profile image from parse
    func fetchProfileImage() {
        
        if userWorkName.value == nil && userName.value == nil && userJobTitle.value == nil && userAbout.value == nil {
            userWorkName.value = workName
            userName.value = name
            userJobTitle.value = jobTitle
            userAbout.value = about
        }
        
        if image.value == nil {
            profileImage?.getDataInBackgroundWithBlock {
                (data, error) in
                
                guard let data = data else {return}
                let image = UIImage(data: data)!
                self.image.value = image
            }
        }
    }
    
    // MARK: Upload profile image to parse
    func uploadProfileImage() {
        if let image = image.value {
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
                () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let imageFile = PFFile(data: imageData!)
            imageFile?.saveInBackground() // Error Handling Later
            
            self.profileImage = imageFile
            
            saveInBackgroundWithBlock {
                (success, error) -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        }
    }
}

extension User {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
}