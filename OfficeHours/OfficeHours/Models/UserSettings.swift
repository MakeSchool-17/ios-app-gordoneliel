//
//  UserSettings.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/9/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import Bond
import Parse

public enum SearchDistance: Double {
    case Five = 5
    case Ten = 10
    case Twenty = 20
    case Fifty = 50
}

class UserSettings: NSObject {
    
    static let instance = UserSettings()
    // Observables
    var userSearchFilter: Observable<SearchDistance?> = Observable(nil)
    var userIndustyFilter: Observable<String?> = Observable(nil)
    var userLocation: Observable<PFGeoPoint?> = Observable(nil)
    var userNotifications: Observable<Bool?> = Observable(nil)
    
    convenience init(industryFilter: String, location: PFGeoPoint) {
        self.init()
        userSearchFilter.value = SearchDistance.Twenty
        userIndustyFilter.value = industryFilter
        userLocation.value = location
        userNotifications.value = true
    }
    
    func persist() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(userSearchFilter.value?.rawValue, forKey: "SearchFilter")
        defaults.setObject(userIndustyFilter.value, forKey: "Industry")
        defaults.setObject(userLocation.value, forKey: "Location")
        defaults.setBool(userNotifications.value!, forKey: "Notifications")
    }
    
    func fetch() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let distanceValue = defaults.objectForKey("SearchFilter") as! Double
        userSearchFilter.value = SearchDistance(rawValue: distanceValue)
        userIndustyFilter.value = defaults.objectForKey("Industry") as? String
        userLocation.value = defaults.objectForKey("Location") as? PFGeoPoint
        userNotifications.value = defaults.objectForKey("Notifications") as? Bool
    }
}
