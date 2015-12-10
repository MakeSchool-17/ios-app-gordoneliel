//
//  HomeViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD

class NearbyMentorViewController: UIViewController {
    
    @IBOutlet var mentorView: MentorView!
    @IBOutlet var noMentorView: UIView!
    
    var mentors: [User]?
    let defaultNearbyMentorRange = 0...10
    var selectedIndex: Int?
    
    let insets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        loadNearbyMentorsInRange(defaultNearbyMentorRange, distanceFilter: 10) {
            [unowned self] users in
            
            self.mentors = users
            SVProgressHUD.dismiss()
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

// MARK: UICollectionView Delegate - NearbyMentor VC handles collection view display, MentorView handles DataSource
extension NearbyMentorViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mentorProfileViewController = MentorBrowserViewController()
        mentorProfileViewController.modalPresentationStyle = .OverFullScreen
        mentorProfileViewController.modalTransitionStyle = .CrossDissolve
        
        if let mentors = mentors {
            mentorProfileViewController.mentors = mentors
            mentorProfileViewController.selectedIndex = indexPath.row
            presentViewController(mentorProfileViewController, animated: true, completion: nil)
        }
    }
}

extension NearbyMentorViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = ((collectionView.frame.size.width) / 3)  - (insets.left * 2)
        let height: CGFloat = 170
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return insets
    }
}
