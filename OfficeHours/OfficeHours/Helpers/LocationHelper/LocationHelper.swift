//
//  LocationHelper.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/11/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import CoreLocation

typealias LocationCallback = (address: String) -> Void

class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter  = 3000                         // Must move at least 3km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
    }
    /*
    * Gets the address of a coordinate location
    */
    func getUserLocationName(callback : LocationCallback) {
        let geoCoder = CLGeocoder()
        
        guard let locValue = locationManager.location?.coordinate else {return}
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            
            (placemarks, error) -> Void in
            
            if error != nil {
                print(error!.description)
            } else {
                let placeArray = placemarks
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                let streetNum = placeMark.subThoroughfare ?? ""
                let postCode = placeMark.postalCode ?? ""
                let state = placeMark.administrativeArea ?? ""
                //                 City
                if let city = placeMark.addressDictionary!["City"] as? String {
                    if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
                        let address = streetNum + " " + street + ", " + city + " " + state + " " + postCode
                        callback(address: address)
                    }
                }
            }
        }
    }
}
