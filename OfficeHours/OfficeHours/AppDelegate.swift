//
//  AppDelegate.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/1/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /**
     *  Styling
     */
    struct NavigationStyling {
        static func removeHairline() {
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        }
        static func tintTabBar() {
            UITabBar.appearance().tintColor = UIColor.primaryBlueColor()
            UITabBar.appearance().barTintColor = UIColor.whiteColor()
        }
        static func backButtonStyling() {
            // Custom back icon
            UINavigationBar.appearance().backIndicatorImage = UIImage(named: "BackButton");
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "BackButton");
            
            // Adjust the back text for our new image
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -600.0, vertical: 100.0), forBarMetrics: .Default);
            UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 10)!], forState: .Normal)

        }
    }
    
    func setupParse() {
        Parse.setApplicationId("ZAPP8nFlwnGTeeglDN8Yd9EC8koBJl3tABfFsjUQ", clientKey: "nWCKSkkOqjshjCvkv8STnMROFmDDEi0GRvBCxo22")
        let acl = PFACL()
        acl.publicReadAccess = true
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
    }
    
    func setupPush(application: UIApplication) {
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)

        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NavigationStyling.removeHairline()
        NavigationStyling.tintTabBar()
        NavigationStyling.backButtonStyling()
        setupParse()
        setupPush(application)
        
        return true
    }

    // MARK: Notifications
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        // Store the deviceToken in the current Installation and save it to Parse
        let currentInstallation = PFInstallation.currentInstallation()
        
        if let user = User.currentUser() {
            currentInstallation["user"] = user
        }
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        PFPush.handlePush(userInfo)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let currentInstallation = PFInstallation.currentInstallation()
        if currentInstallation.badge != 0 {
            currentInstallation.badge = 0
            currentInstallation.saveEventually()
        }

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

