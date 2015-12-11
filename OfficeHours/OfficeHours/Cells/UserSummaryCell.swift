//
//  UserSummaryCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let UserSummaryCellIdentifier = "UserSummaryCell"

class UserSummaryCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var userSummary: UILabel!
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
            mentor?.userName.bindTo(name.bnd_text)
            mentor?.userJobTitle.bindTo(jobTitle.bnd_text)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
    }
    static func nib() -> UINib {
        return UINib(nibName: UserSummaryCellIdentifier, bundle: nil)
    }
}
