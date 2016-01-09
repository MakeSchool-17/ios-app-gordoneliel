//
//  IndustryCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/9/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

let IndustryCellIdentifier = "IndustryCell"

class IndustryCell: UITableViewCell {

    @IBOutlet weak var industry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
