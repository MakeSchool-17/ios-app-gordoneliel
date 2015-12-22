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
    
    @IBOutlet weak var connectionButton: DesignableButton!
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
            canConnect = User.currentUser()?.isUserConnectedWithMentor(mentor!)
            connectionButton.selected = canConnect!
            
        }
    }
    
    var canConnect: Bool? = true {
        didSet {
            /*
            Change the state of the connect button based on whether or not
            it is possible to connect with a user.
            */
            if let canConnect = canConnect {
                connectionButton.selected = canConnect
            }
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
    
    @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Ended {
            // 1
            let velocity = sender.velocityInView(contentView)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            // 2
            let slideFactor = 0.3 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:sender.view!.center.x,
                y:sender.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.contentView.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.contentView.bounds.size.height)
            
            // 5
            UIView.animateWithDuration(Double(slideFactor * 2),
                delay: 0,
                // 6
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {sender.view!.center = finalPoint },
                completion: nil)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: MentorBrowserCellIdentifier, bundle: nil)
    }
}