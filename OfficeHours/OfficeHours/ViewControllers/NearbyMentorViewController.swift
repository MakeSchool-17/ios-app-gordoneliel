//
//  HomeViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

class NearbyMentorViewController: UIViewController {
    
    @IBOutlet var mentorView: MentorView!
    @IBOutlet var noMentorView: UIView!
    
    var mentors: [User]?
    let defaultNearbyMentorRange = 0...10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadNearbyMentorsInRange(defaultNearbyMentorRange, distanceFilter: 10) {
            [unowned self] users in
            
            self.mentors = users
            self.viewToPresent()
        }
    }
    // MARK: Load Nearby Mentors
    func loadNearbyMentorsInRange(range: Range<Int>, distanceFilter: Double, completionBlock: ([User]?) -> Void) {
        ParseHelper.mentorsNearbyCurrentUser(range, distanceFilter: distanceFilter) {
            (result, error) -> Void in
            
            let mentors = result as? [User] ?? []
            
            completionBlock(mentors)
        }
    }
    
    // MARK: View To Present
    /**
     Presents a view based on whether a user has trips or not
     */
    func viewToPresent() {
        
        guard let mentors = mentors else {return}
        
        // TODO:  Replace with better implementation - problem originates from storyboard offset by 64px, resetting origin to 0,0
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.frame.size)
        
        if mentors.count == 0 {
            noMentorView.frame = frame
            noMentorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.view.addSubview(noMentorView)
        } else  {
            mentorView.frame = frame
            mentorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.view.addSubview(mentorView)
            
            mentorView.mentors = mentors
            mentorView.setupCollectionView()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}

