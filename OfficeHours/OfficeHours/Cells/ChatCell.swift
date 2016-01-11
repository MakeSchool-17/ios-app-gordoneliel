//
//  ChatCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/24/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let ChatCellIdentifier =  "ChatCell"

class ChatCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    
    var user: User? {
        didSet {
            user?.fetchProfileInfo()
            user?.image.bindTo(profileImage.bnd_image)
            user?.userName.bindTo(username.bnd_text)
            user?.userJobTitle.map {
                $0! + ", " + (self.user?.userWorkName.value)!
                }.bindTo(jobTitle.bnd_text)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(.AllCorners, radius: 6)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.roundCorners(.AllCorners, radius: profileImage.frame.size.width / 2)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: ChatCellIdentifier, bundle: nil)
    }
}
