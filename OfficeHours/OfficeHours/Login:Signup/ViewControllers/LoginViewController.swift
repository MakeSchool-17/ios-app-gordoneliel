//
//  RELoginViewControllerSwift.swift
//  ResQ
//
//  Created by Eliel Gordon on 8/31/15.
//

import UIKit
import QuartzCore
import SVProgressHUD
import Bond

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var userNameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var inputContainerCenterConstraint : NSLayoutConstraint!
    @IBOutlet weak var loginButton: DesignableButton!
    
    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.text = "gordoneliel"
        passwordTextField.text = "men"
        
        loginButton.bnd_controlEvent
            .filter { $0 == UIControlEvents.TouchUpInside }
            .observe { e in
                self.loginUser()
        }

        combineLatest(userNameTextField.bnd_text, passwordTextField.bnd_text)
            .map { email, pass in
                return email?.characters.count > 0 && pass?.characters.count > 2
        }.bindTo(loginButton.bnd_enabled)
        
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
    
    func loginUser() {
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        
        guard let username = userNameTextField.text, let password = passwordTextField.text else {return}
        
        User.logInWithUsernameInBackground(username,
            password: password) {
                (user, error) in
                
                let user = user as? User
                user?.fetchConnections()
                
                if error == nil && user != nil {
                    self.moveToTabBarController()
                }else {
                    SVProgressHUD.showErrorWithStatus("Username or password incorrect", maskType: .Black)
                }

               self.view.userInteractionEnabled = true
        }
    }

    @IBAction func unwindSignUp(segue: UIStoryboardSegue, sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func moveToTabBarController() {
        dispatch_async(dispatch_get_main_queue())  {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("HomeTabBar") as! UITabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = viewController
            appDelegate.window?.makeKeyAndVisible()
            self.navigationController?.popToRootViewControllerAnimated(false)
            
        }
    }
    
    /**
     Prefer the status bar to be hidden
     
     - returns: true -> we want a hidden status bar
     */
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}

// MARK: - UITextField Delegate & Helpers

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Move the input container containing all the textfields up for convienience
        moveInputContainer(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
            return false
        } else {
            moveInputContainer(false)
            textField.resignFirstResponder()
            return true
        }
    }
    
    /**
     Helper method that moves the container view for the uitextfields
     */
    func moveInputContainer(moveUp: Bool) {
        if moveUp {
            // Move TextFields up
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.inputContainerCenterConstraint.constant = 100
                self.view.backgroundColor = UIColor.primaryBlueColor()
                self.logoView.tintColor = UIColor.whiteColor()
                self.view.layoutIfNeeded()
                
                }, completion: nil)
            
        } else {
            // Move TextFields down
            UIView.animateWithDuration(0.3) {
                self.view.backgroundColor = UIColor.whiteColor()
                self.logoView.tintColor = UIColor.primaryBlueColor()
                self.inputContainerCenterConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}
