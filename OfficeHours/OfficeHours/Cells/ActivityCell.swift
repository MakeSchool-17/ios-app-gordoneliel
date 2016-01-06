//
//  ActivityCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/22/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import DateTools
import SVProgressHUD

let ActivityCellIdentifier = "ActivityCell"

class ActivityCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var connectionRequest: ConnectionRequest? {
        didSet {
            let username = connectionRequest!.fromUser.name!
            
            let string = NSMutableAttributedString(string: "\(username) wants to connect")
            string.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGrayColor(), range: NSMakeRange(0, username.characters.count))
                
            infoLabel.attributedText = string
            
            //Timestamp
            timestamp.text = connectionRequest!.createdAt!.timeAgoSinceNow()
            
            connectionRequest?.fromUser.fetchProfileImage()
            connectionRequest?.fromUser.image.bindTo(profileImage.bnd_image)
        }
    }
    
    @IBAction func acceptRequestPressed(sender: AnyObject) {
        SVProgressHUD.show()
        
        ParseHelper.acceptConnectionRequest(connectionRequest!) {
            (result, error) -> Void in

            SVProgressHUD.showSuccessWithStatus("Accepted")
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
