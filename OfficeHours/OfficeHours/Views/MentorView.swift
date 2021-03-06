//
//  MentorView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/2/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

class MentorView: UIView {
    
    var dataSource: ArrayDataSource?
    var mentors: [User]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items:mentors!, cellIdentifier: MentorCellIdentifier) {
            (cell, item) in
            
            if let mentorCell = cell as? MentorCell {
                if let mentor = item as? User {
                    mentorCell.mentor = mentor
                }
            }
        }
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerNib(MentorCell.nib(), forCellWithReuseIdentifier: MentorCellIdentifier)
    }
    
}

extension MentorView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension MentorView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (Int(collectionView.frame.size.width) / 3) - 15
        let height = 180 //Int(collectionView.frame.size.height) / 3
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}