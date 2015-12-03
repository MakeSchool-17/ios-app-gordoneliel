//
//  HomeViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var mentorView: MentorView!
    @IBOutlet var noMentorView: UIView!
    var mentors: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewToPresent()
        // Do any additional setup after loading the view.
    }
    
    /**
     Presents a view based on whether a user has trips or not
     */
    func viewToPresent() {
        
        guard let mentors = mentors else {return}
        let frame = self.view.frame
        
        if mentors.count == 0 {
            noMentorView.frame = frame
            noMentorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.view.addSubview(noMentorView)
            return
        } else  {
            mentorView.frame = frame
            mentorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.view.addSubview(mentorView)
            
            mentorView.mentors = mentors
            mentorView.setupCollectionView()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
