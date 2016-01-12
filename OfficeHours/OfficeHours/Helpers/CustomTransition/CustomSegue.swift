//
//  CustomSegue.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/10/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let initialVC = self.sourceViewController.view as UIView!
        let destinationVC = self.destinationViewController as UIViewController!
        
        let nav = self.sourceViewController.navigationController
        // Specify the initial position of the destination view.
        destinationVC.view.transform = CGAffineTransformMakeScale(2, 2)
//        destinationVC.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(destinationVC.view, aboveSubview: initialVC)
        
        // Animate the transition.
        UIView.animateWithDuration(0.9, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity:0.5, options: .CurveEaseOut, animations: { () -> Void in
            destinationVC.view.transform = CGAffineTransformIdentity
            initialVC.backgroundColor = UIColor.whiteColor()
            }) { (Finished) -> Void in
                UIView.animateWithDuration(0.8, animations: { () -> Void in

                    }, completion: { (Finished) -> Void in
                        destinationVC.view.transform = CGAffineTransformIdentity
                        if let nav = nav {
                            nav.pushViewController(self.destinationViewController, animated: false)
                        }else {
//                        self.sourceViewController.showViewController(self.destinationViewController, sender: initialVC)
//                        self.sourceViewController.showDetailViewController(self.destinationViewController, sender: initialVC)
                        self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                            animated: false,
                            completion: nil)
                        }
                })

        }
    }
}
