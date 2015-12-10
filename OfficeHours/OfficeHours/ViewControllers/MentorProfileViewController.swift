//
//  MentorProfileViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/9/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Bond

class MentorProfileViewController: UIViewController {
    
    @IBOutlet weak var mentorImage: UIImageView!
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
//            mentor?.image.bindTo(mentorImage.bnd_image)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissMentorProfileView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
