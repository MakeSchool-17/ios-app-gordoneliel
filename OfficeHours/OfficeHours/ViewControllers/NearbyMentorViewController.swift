//
//  HomeViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD
import MCCardPickerCollectionViewController

class NearbyMentorViewController: UIViewController {
    
    @IBOutlet var mentorView: MentorView!
    @IBOutlet var noMentorView: UIView!
    
    var mentors: [User]? {
        didSet {
            viewToPresent()
        }
    }
    
    let defaultNearbyMentorRange = 0...50
    var selectedIndex: Int?
    
    let insets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    var dataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        
        loadNearbyMentorsInRange(defaultNearbyMentorRange, distanceFilter: 10)
    }
    // MARK: Load Nearby Mentors
    func loadNearbyMentorsInRange(range: Range<Int>, distanceFilter: Double) {
        ParseHelper.mentorsNearbyCurrentUser(range, distanceFilter: distanceFilter) {
            (result, error) -> Void in
            
            // Handle error
            if error != nil {
                SVProgressHUD.showErrorWithStatus("Error Loading nearby mentors")
                return
            }
            
            let mentors = result as? [User] ?? []
            
            self.mentors = mentors
            SVProgressHUD.dismiss()
            self.view.userInteractionEnabled = true
            
            
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

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        mentorView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}

// MARK: UICollectionView Delegate - NearbyMentor VC handles collection view display, MentorView handles DataSource
extension NearbyMentorViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mentorBrowserVC = MentorBrowserViewController()
        mentorBrowserVC.modalPresentationStyle = .OverFullScreen
        mentorBrowserVC.modalTransitionStyle = .CrossDissolve


        if let mentors = mentors {
            mentorBrowserVC.selectedIndex = indexPath.row
            mentorBrowserVC.mentors = mentors
            presentViewController(mentorBrowserVC, animated: true, completion: nil)
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return insets
    }
}
