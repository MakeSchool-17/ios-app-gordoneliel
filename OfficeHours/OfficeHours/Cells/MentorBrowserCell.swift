//
//  MentorBrowserCell.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/10/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

let MentorBrowserCellIdentifier = "MentorBrowserCell"

class MentorBrowserCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let insets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
            mentor?.image.bindTo(profileImage.bnd_image)
            setupCollectionView()
        }
    }
    
    var dataSource: ArrayDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    static func nib() -> UINib {
        return UINib(nibName: MentorBrowserCellIdentifier, bundle: nil)
    }
}

extension MentorBrowserCell {
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: [mentor!], cellIdentifier: UserSummaryCellIdentifier) {
            (cell, user) in
            
            let userSummaryCell = cell as! UserSummaryCell
            
            if let user = user as? User {
                userSummaryCell.mentor = user
            }
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerNib(UserSummaryCell.nib(), forCellWithReuseIdentifier: UserSummaryCellIdentifier)
    }
}

extension MentorBrowserCell: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = 130
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return insets
    }
}
