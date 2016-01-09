//
//  ActivityViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/22/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    
    var connectionRequests: [ConnectionRequest]? {
        didSet {
            setupCollectionView()
        }
    }
    
    let insets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = true
    
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        
        ParseHelper.pendingRequestsForUser(User.currentUser()!) {
            (results, error) -> Void in
            let connectionRequests = results as? [ConnectionRequest] ?? []
            self.connectionRequests = connectionRequests
            
            SVProgressHUD.dismiss()
            self.view.userInteractionEnabled = true
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }

    func setupCollectionView() {
        dataSource = ArrayDataSource(items: connectionRequests!, cellIdentifier: ActivityCellIdentifier) {
            (cell, request) in
            
            let activityCell = cell as! ActivityCell
            
            if let request = request as? ConnectionRequest {
                activityCell.connectionRequest = request
            }
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerNib(ActivityCell.nib(), forCellWithReuseIdentifier: ActivityCellIdentifier)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}

// MARK: - UICollectionView Delegate
extension ActivityViewController: UICollectionViewDelegate {
    // Handle Accepting Connection Requests
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mentorBrowserVC = MentorBrowserViewController()
        mentorBrowserVC.modalPresentationStyle = .FullScreen
        mentorBrowserVC.modalTransitionStyle = .CrossDissolve
        
        // Filter out mentors from "From user"
        let mentors = connectionRequests?.map { request in
            request.fromUser
        }
        
        mentorBrowserVC.selectedIndex = indexPath.row
        mentorBrowserVC.mentors = mentors
        presentViewController(mentorBrowserVC, animated: true, completion: nil)
    }
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = 140
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
