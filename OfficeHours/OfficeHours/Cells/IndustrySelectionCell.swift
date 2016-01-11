//
//  IndustrySelectionCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/10/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

let IndustrySelectionCellIdentifier = "IndustrySelectionCell"

class IndustrySelectionCell: UICollectionViewCell {
    @IBOutlet weak var industry: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(.AllCorners, radius: 6)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.primaryBlueColor()
        selectedBackgroundView = selectedView
    }

    static func nib() -> UINib {
        return UINib(nibName: IndustrySelectionCellIdentifier, bundle: nil)
    }
}
