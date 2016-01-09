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
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileInfo()
            
            mentor?.image.bindTo(profileImage.bnd_image)
            mentor?.userName.bindTo(name.bnd_text)
            mentor?.userJobTitle.bindTo(jobTitle.bnd_text)
            mentor?.userWorkName.bindTo(workName.bnd_text)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: ConnectionCellIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.lighterGrayColor()
        selectedBackgroundView = selectedView
        
        profileImage.roundCorners(.AllCorners, radius: profileImage.frame.size.width / 2)

        layer.cornerRadius = 6
        clipsToBounds = true
    }

}
