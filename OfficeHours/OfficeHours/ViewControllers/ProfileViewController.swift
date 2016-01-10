//
//  ProfileViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/5/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import Bond

class ProfileViewController: UITableViewController {

    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: DesignableButton!
    
    var photoTakingHelper: PhotoTakingHelper?
    var disposable: DisposableType?
    
    var user: User? {
        didSet {
            user?.fetchProfileInfo()
            disposable?.dispose()
            
            disposable = user?.image.observe {
                image in
                if image.value != nil {
                    self.profileImage.setBackgroundImage(image, forState: .Normal)
                }
            }
            
            profileImage.contentMode = .ScaleAspectFill
            user?.userName.bindTo(name.bnd_text)
            user?.userEmail.bindTo(email.bnd_text)
            user?.userIndustry.bindTo(industry.bnd_text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User.currentUser()
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
        header.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 15)!
        header.textLabel?.textColor = UIColor.darkTextColor()
        header.textLabel?.text = header.textLabel?.text?.capitalizedString
//        header.contentView.backgroundColor = UIColor.whiteColor()
    }
}
