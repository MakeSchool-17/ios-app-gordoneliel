//
//  ActivityCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/22/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let ActivityCellIdentifier = "ActivityCell"

class ActivityCell: UICollectionViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    
    var connectionRequest: ConnectionRequest? {
        didSet {
            let username = connectionRequest!.fromUser.name!
//            infoLabel.text = "\(username) wants to connect"
            let string = NSMutableAttributedString(string: "\(username) wants to connect")
            string.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGrayColor(), range: NSMakeRange(0, username.characters.count))
                
            infoLabel.attributedText = string
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(.AllCorners, radius: 6)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: ActivityCellIdentifier, bundle: nil)
    }
}
