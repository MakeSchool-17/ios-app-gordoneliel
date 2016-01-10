//
//  HomeViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD
import Popover
import Bond

class NearbyMentorViewController: UIViewController {
    
    @IBOutlet weak var filterButtonItem: UIBarButtonItem!
    @IBOutlet var mentorView: MentorView!
    @IBOutlet var noMentorView: UIView!
    var activeView: UIView!
    
    var mentors: Observable<[User]?> = Observable(nil)
    
    let defaultNearbyMentorRange = 0...50
    var selectedIndex: Int?
    
    let insets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    var dataSource: ArrayDataSource?
    
    //Popover
    private var popover: Popover!
    private var popoverOptions: [PopoverOption] = [
        .Type(.Down),
        .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.7))
    ]
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refresh Control
        mentorView.collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "loadMentors", forControlEvents: .ValueChanged)
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let object = defaults.doubleForKey("FilterState") ?? 10
        
        loadNearbyMentorsInRange(defaultNearbyMentorRange, distanceFilter: object)
    }
    
    func loadMentors() {
        loadNearbyMentorsInRange(defaultNearbyMentorRange, distanceFilter: 15)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //        activeView?.removeFromSuperview()
        SVProgressHUD.dismiss()
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
            
            var mentors = result as? [User] ?? []
            
            // Filter out connected mentors
            mentors = mentors.filter { mentor in
                User.currentUser()!.isUserConnectedWithMentor(mentor) == false
            }
            
            self.mentors.value = mentors
            self.viewToPresent()
            SVProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
            self.view.userInteractionEnabled = true
        }
    }
    
    // MARK: View To Present
    /**
    Presents a view based on whether a user has trips or not
    */
    func viewToPresent() {
        
        guard let mentors = mentors.value else {return}
        
        // TODO:  Replace with better implementation - problem originates from storyboard offset by 64px, resetting origin to 0,0
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.frame.size)
        
        if mentors.count == 0 {
            activeView = noMentorView
            view.addSubview(activeView)
        } else  {
            activeView = mentorView
            view.addSubview(activeView)
            
            mentorView.mentors = self.mentors
            
            mentorView.setupCollectionView()
        }
        
        activeView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        activeView.frame = frame
        
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        mentorView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func filterPressed(sender: UIBarButtonItem) {
        
        let tableView = NearbySearchFilterTableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .Grouped)
        
        let startPoint = CGPoint(x: view.frame.width - 30, y:57)
        
        self.popover = Popover(options: self.popoverOptions, showHandler: nil, dismissHandler: nil)
        self.popover.show(tableView, point: startPoint)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}

// MARK: UICollectionView Delegate - NearbyMentor VC handles collection view display, MentorView handles DataSource
extension NearbyMentorViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mentorBrowserVC = MentorBrowserViewController()
        mentorBrowserVC.modalPresentationStyle = .FullScreen
        mentorBrowserVC.modalTransitionStyle = .CrossDissolve
        
        
        if let mentors = mentors.value {
            mentorBrowserVC.selectedIndex = indexPath.row
            mentorBrowserVC.mentors = mentors
            presentViewController(mentorBrowserVC, animated: true, completion: nil)
        }
    }
}

extension NearbyMentorViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = ((collectionView.frame.size.width) / 3)  - (insets.left * 2)
        let height: CGFloat = 160
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
