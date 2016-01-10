//
//  IndustryCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/9/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import Parse

let IndustryCellIdentifier = "IndustryCell"

class IndustryCell: UITableViewCell {

    @IBOutlet weak var industry: UILabel!
    
    let selectedIndustry = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let settings = UserSettings(industryFilter: "Accounting", location: PFGeoPoint(latitude: 37, longitude: -122))
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
