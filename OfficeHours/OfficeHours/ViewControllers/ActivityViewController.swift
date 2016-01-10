//
//  ActivityViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/22/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD
import Bond

class ActivityViewController: UIViewController {
    
    @IBOutlet var noConnectionView: UIView!
    
    @IBOutlet var connectionView: ConnectionView!
    
    var dataSource: ArrayDataSource?
    
    var connectionRequests: Observable<[ConnectionRequest]?> = Observable(nil)
    
    var activeView: UIView!
    var refreshControl = UIRefreshControl()
    let insets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    
    override func viewDidLoad() {
        connectionView.collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "fetchPendingRequests", forControlEvents: .ValueChanged)
//
        navigationController?.navigationBar.hidden = true
//        SVProgressHUD.show()
//        fetchPendingRequests()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        fetchPendingRequests()
    }
    
    func fetchPendingRequests() {
        view.userInteractionEnabled = false
        
        ParseHelper.pendingRequestsForUser() {
            (results, error) -> Void in
            let connectionRequests = results as? [ConnectionRequest] ?? []
            self.connectionRequests.value = connectionRequests
            
            
            self.viewToPresent()
            SVProgressHUD.dismiss()
            self.view.userInteractionEnabled = true
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        activeView?.removeFromSuperview()
        SVProgressHUD.dismiss()
    }
    
    // MARK: View To Present
    /**
    Presents a view based on whether a user has trips or not
    */
    func viewToPresent() {
        
        guard let connectionRequests = connectionRequests.value else {return}
        
        // TODO:  Replace with better implementation - problem originates from storyboard offset by 64px, resetting origin to 0,0
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.frame.size)
        
//        let myTopLayoutGuide = topLayoutGuide
//        activeView.addConstraints([NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide]-20-[button]", options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: self)])
        
        if connectionRequests.count == 0 {
            activeView = noConnectionView
            view.addSubview(activeView)
        } else  {
            activeView = connectionView
            view.addSubview(activeView)
            
            connectionView.connectionRequests = self.connectionRequests
            
            connectionView.setupCollectionView()
        }
        
        activeView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        activeView.frame = frame
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        connectionView.collectionView.collectionViewLayout.invalidateLayout()
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
        let mentors = connectionRequests.value?.map { request in
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
