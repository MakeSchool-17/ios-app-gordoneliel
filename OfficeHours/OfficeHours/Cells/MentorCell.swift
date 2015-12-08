//
//  MentorCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/1/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Bond
import Parse

let MentorCellIdentifier = "MentorCell"
class MentorCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var workName: UILabel!
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
            
            name.text = mentor?.name
            jobTitle.text = mentor?.jobTitle
            
            mentor?.image.bindTo(profileImage.bnd_image)
        }
    }
    
    func configureCell() {
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: MentorCellIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        layer.cornerRadius = 3
        clipsToBounds = true
    }
}
