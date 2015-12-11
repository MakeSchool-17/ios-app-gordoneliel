//
//  ConnectonsViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD

class ConnectonsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    var mentors: [User]?
    let defaultNearbyMentorRange = 0...10
    
    let insets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        loadUserConnectionInRange(defaultNearbyMentorRange, distanceFilter: 10) {
            [unowned self] users in
            
            self.mentors = users
            self.setupCollectionView()
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: Load Nearby Mentors
    func loadUserConnectionInRange(range: Range<Int>, distanceFilter: Double, completionBlock: ([User]?) -> Void) {
        ParseHelper.fetchUserConnection(range) {
            (result, error) -> Void in
            
            let mentors = result as? [User] ?? []
            
            completionBlock(mentors)
        }
//        ParseHelper.mentorsNearbyCurrentUser(range, distanceFilter: distanceFilter) {
//            (result, error) -> Void in
//            
//            if error != nil {
//                SVProgressHUD.showErrorWithStatus("Error, Please try again")
//            }
//            
//            let mentors = result as? [User] ?? []
//            
//            completionBlock(mentors)
//        }
    }
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: mentors!, cellIdentifier: ConnectionCellIdentifier) {
            (cell, user) in
            
            let connectionsCell = cell as! ConnectionCell
            
            if let user = user as? User {
                connectionsCell.mentor = user
            }
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerNib(ConnectionCell.nib(), forCellWithReuseIdentifier: ConnectionCellIdentifier)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}

extension ConnectonsViewController: UICollectionViewDelegate {
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

extension ConnectonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = 80
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