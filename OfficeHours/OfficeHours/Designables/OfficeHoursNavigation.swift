//
//  OfficeHoursNavigation.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let NavBarColor = UIColor(red: 3/255, green: 129/255, blue: 201/255, alpha: 1.0)

class OfficeHoursNavigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.primaryBlueColor()
        navigationBar.barStyle = .Black
        navigationBar.translucent = false
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()]
        
    }
}
