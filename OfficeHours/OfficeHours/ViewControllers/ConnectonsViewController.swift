//
//  ConnectonsViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD
import Parse
import Bond

class ConnectonsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    var connectedMentors: [User]? {
        didSet {
            setupCollectionView()
        }
    }
    let defaultNearbyMentorRange = 0...50
    var connectionDisposable: DisposableType?
    
    let insets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        connectionDisposable?.dispose()
        User.currentUser()?.fetchConnections()
        connectionDisposable = User.currentUser()?.connections.observe {
            (value: [User]?) -> () in
            if let value = value {
                self.connectedMentors = value
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: connectedMentors!, cellIdentifier: ConnectionCellIdentifier) {
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
        
        if let mentors = connectedMentors {
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