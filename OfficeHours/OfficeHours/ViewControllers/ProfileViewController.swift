//
//  ProfileViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/5/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var profileImage: DesignableButton!
    
    var user: User? {
        didSet {
            user?.fetchProfileImage()
            profileImage.setBackgroundImage(UIImage(data: try! user!.profileImage!.getData()), forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = User.currentUser()
        // Do any additional setup after loading the view.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}
