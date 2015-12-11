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
    
    let insets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    @IBOutlet weak var locationLabel: UILabel!
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
        collectionView.registerNib(MentorCell.nib(), forCellWithReuseIdentifier: MentorCellIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let locationHelper = LocationHelper()
        locationHelper.getUserLocationName() {
            (address) -> Void in
            
            self.locationLabel.text = address
        }
    }
}