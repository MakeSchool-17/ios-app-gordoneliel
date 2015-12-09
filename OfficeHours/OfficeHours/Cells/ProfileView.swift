//
//  ProfileView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/8/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let ProfileViewCellIdentifier = "ProfileView"

class ProfileView: UICollectionReusableView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var workName: UILabel!
    
    var user: User? {
        didSet {
            user?.fetchProfileImage()
            user?.image.bindTo(profileImage.bnd_image)
            
            name.text = user?.name
            jobTitle.text = user?.jobTitle
            workName.text = user?.workName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        user = User.currentUser()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        layer.cornerRadius = 3
        clipsToBounds = true
    }
    
    @IBAction func editProfilePressed(sender: AnyObject) {
    }
    
    @IBAction func myMentorsPressed(sender: AnyObject) {
    }
    
    static func nib() -> UINib {
        return UINib(nibName: ProfileViewCellIdentifier, bundle: nil)
    }
}
