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
    
    var mentor: User? {
        didSet {
            mentor?.fetchProfileImage()
            mentor?.image.bindTo(profileImage.bnd_image)
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
        dataSource = ArrayDataSource(items: [mentor!], cellIdentifier: MentorBrowserCellIdentifier) {
            (cell, user) in
            
            let mentorBrowserCell = cell as! MentorBrowserCell
            
            if let user = user as? User {
                mentorBrowserCell.mentor = user
            }
        }
        
        collectionView.dataSource = dataSource
        collectionView.registerNib(MentorBrowserCell.nib(), forCellWithReuseIdentifier: MentorBrowserCellIdentifier)
    }
}
