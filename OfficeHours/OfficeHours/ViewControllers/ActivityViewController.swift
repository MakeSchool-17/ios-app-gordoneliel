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
}

// MARK: - UICollectionView Delegate
extension ActivityViewController: UICollectionViewDelegate {
    // Handle Accepting Connection Requests
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        ParseHelper.acceptConnectionRequest(connectionRequests![indexPath.row]) {
            (result, error) -> Void in
            
            self.collectionView.reloadData()
        }
    }
}

extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = 65
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
