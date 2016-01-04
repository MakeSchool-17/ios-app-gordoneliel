//
//  MessagingViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/24/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

class MessagingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    var users: [User]? {
        didSet {
            setupCollectionView()
        }
    }
    
    let insets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)

    override func viewDidLoad() {
        super.viewDidLoad()

        ParseHelper.connectionsForUser(User.currentUser()!) {
            (users, error) in
            
            self.users = users as? [User] ?? []
            
        }
    }

    func setupCollectionView() {
        dataSource = ArrayDataSource(items: users!, cellIdentifier: ChatCellIdentifier) {
            (cell, user) in
            
            let chatCell = cell as! ChatCell
            
            if let user = user as? User {
                chatCell.user = user
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.registerNib(ChatCell.nib(), forCellWithReuseIdentifier: ChatCellIdentifier)
    }
}

extension MessagingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.size.width - (insets.left * 2)
        let height: CGFloat = 70
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
