//
//  MentorBrowserCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/10/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let MentorBrowserCellIdentifier = "MentorBrowserCell"

class MentorBrowserCell: UICollectionViewCell {
    
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
            mentor?.image.bindTo(profileImage.bnd_image)
            mentor?.userName.bindTo(name.bnd_text)
            mentor?.userJobTitle.bindTo(jobTitle.bnd_text)
            mentor?.userAbout.bindTo(summary.bnd_text)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([UIRectCorner.TopRight, UIRectCorner.TopLeft], radius: 6)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func requestPressed(sender: DesignableButton) {
        if sender.selected {
            sender.selected = false
            sender.setTitle("Request", forState: .Normal)
        } else {
            sender.selected = true
            sender.setTitle("Pending", forState: .Selected)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: MentorBrowserCellIdentifier, bundle: nil)
    }
}