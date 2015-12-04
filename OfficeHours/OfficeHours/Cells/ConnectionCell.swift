//
//  ConnectionCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/1/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Bond

let ConnectionCellIdentifier = "ConnectionCell"
class ConnectionCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var workName: UILabel!
    
    var user: User? {
        didSet {
            profileImage.image = user?.image.value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
