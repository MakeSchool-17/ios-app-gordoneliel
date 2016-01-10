//
//  StepThree.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/6/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import CoreLocation

class StepThree: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enabledLocationPressed(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
    }
}
