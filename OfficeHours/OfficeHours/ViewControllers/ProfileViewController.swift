//
//  ProfileViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/5/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: DesignableButton!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var user: User? {
        didSet {
            user?.fetchProfileInfo()
            profileImage.contentMode = .ScaleAspectFill
            profileImage.setBackgroundImage(UIImage(data: try! user!.profileImage!.getData()), forState: .Normal)
            user?.userName.bindTo(name.bnd_text)
            user?.userEmail.bindTo(email.bnd_text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = User.currentUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileImagePressed(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) {
            photo in
            
            self.profileImage.setBackgroundImage(photo, forState: .Normal)
            self.user?.image.value = photo
            self.user?.uploadProfileImage()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)!
        header.textLabel?.textColor = UIColor.darkTextColor()
        header.textLabel?.text = header.textLabel?.text?.capitalizedString
//        header.contentView.backgroundColor = UIColor.whiteColor()
    }
}
