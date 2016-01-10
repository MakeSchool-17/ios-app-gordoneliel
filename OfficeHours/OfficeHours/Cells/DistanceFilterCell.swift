//
//  DistanceFilterCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/4/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//
import UIKit
import Parse

let FilterCellIdentifier = "DistanceFilterCell"

class DistanceFilterCell: UITableViewCell {
    
//    enum SearchDistance: Double {
//        case Five = 5, Ten = 10, Twenty = 20, Fifty = 50
//    }
    
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let settings = UserSettings(industryFilter: "Accounting", location: PFGeoPoint(latitude: 37, longitude: -122))
//        settings.userSearchFilter.observe {
//             event in
//            var selectedIndex = 0
//            
//            switch event! {
//            case .Five:
//                selectedIndex = 0
//            case .Ten:
//                selectedIndex = 1
//            case .Twenty:
//                selectedIndex = 2
//            case .Fifty:
//                selectedIndex = 3
//            }
//            self.filterSegmentedControl.selectedSegmentIndex = selectedIndex
//        }
        
//        settings.persist()
        
        var object = defaults.doubleForKey("FilterState")
        if object == 0 {
            object = SearchDistance.Twenty.rawValue
        }
        
        let distance = SearchDistance(rawValue: object)!
        
        var selectedIndex = 0
        
        switch distance {
        case .Five:
            selectedIndex = 0
        case .Ten:
            selectedIndex = 1
        case .Twenty:
            selectedIndex = 2
        case .Fifty:
            selectedIndex = 3
        }
        
        filterSegmentedControl.selectedSegmentIndex = selectedIndex
    }
    
    @IBAction func distanceFilterChanged(sender: UISegmentedControl) {
        var distance: Double = 5
        
        switch sender.selectedSegmentIndex {
        case 0: distance = SearchDistance.Five.rawValue
        case 1: distance = SearchDistance.Ten.rawValue
        case 2: distance = SearchDistance.Twenty.rawValue
        case 3: distance = SearchDistance.Fifty.rawValue
            
        default: SearchDistance.Five.rawValue
        }
        defaults.setDouble(distance, forKey: "FilterState")
    }
}
