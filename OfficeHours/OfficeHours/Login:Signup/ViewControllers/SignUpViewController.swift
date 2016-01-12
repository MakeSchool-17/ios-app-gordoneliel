//
//  SignUpViewController.swift
//  TripPlanner
//
//  Created by Eliel Gordon on 10/17/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import QuartzCore
import SVProgressHUD
import Bond

class SignUpViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var profileImageButton: DesignableButton!
    @IBOutlet weak var userNameTextField : DesignableTextField!
    @IBOutlet weak var passwordTextField : DesignableTextField!
    @IBOutlet weak var inputContainerCenterConstraint : NSLayoutConstraint!
    @IBOutlet weak var loginButton: DesignableButton!
    
    @IBOutlet weak var profileViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /**
    Determines whether the login button should be enabled or disabled.
    
    - parameter enabled: - A boolean of the state of the login button.
    */
    func loginButton(enabled: Bool) -> () {
        func enable() {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.loginButton.backgroundColor = UIColor(red: 10/255, green: 101/255, blue: 172/255, alpha: 1.0)
                }, completion: nil)
            
            loginButton.enabled = true
        }
        func disable() {
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.loginButton.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    // Resign the keyboard when user touches anything other than the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        moveInputContainer(false)
    }
    
    func signUpUser() {
        SVProgressHUD.showWithStatus("Signing you up", maskType: .Black)

        SVProgressHUD.dismiss()
        
        
    }
    // MARK: Login Action
    @IBAction func signUpPressed(sender: AnyObject) {
        signUpUser()
    }
    
    func moveToTabBarController() {
        dispatch_async(dispatch_get_main_queue())  {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("HomeTabBar") as! UITabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = viewController
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    /**
    Prefer the status bar to be hidden
    
    - returns: true -> we want a hidden status bar
    */
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    func takePhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) {
           [unowned self] photo in
            self.profileImageButton.setBackgroundImage(photo, forState: .Normal)
            self.profileImageButton.setTitle("", forState: .Normal)
        }
    }
    @IBAction func profileImagePressed(sender: AnyObject) {
        takePhoto()
    }
}

// MARK: - UITextField Delegate & Helpers

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Move the input container containing all the textfields up for convienience
        moveInputContainer(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField.returnKeyType == UIReturnKeyType.Next) {
            let next: UIView = textField.superview?.viewWithTag(textField.tag+1) as UIView!
            next.becomeFirstResponder()
        } else if (textField.returnKeyType == UIReturnKeyType.Go) {
            textField.resignFirstResponder()
            moveInputContainer(false)
        }
        
        return true
    }
    
    /**
    Helper method that moves the container view for the uitextfields
    */
    func moveInputContainer(moveUp: Bool) {
        
        if moveUp {
            
            // Move TextFields up
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//                self.inputContainerCenterConstraint.constant = 100
                self.profileViewTopConstraint.active = true
                self.titleTopConstraint.active = false
                self.view.layoutIfNeeded()
                
                }, completion: nil)
            
        } else {
            
            // Move TextFields down
            UIView.animateWithDuration(0.3) {
//                self.inputContainerCenterConstraint.constant = 0
                self.profileViewTopConstraint.active = false
                self.titleTopConstraint.active = true
                self.view.layoutIfNeeded()
            }
        }
    }

}
