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
        dataSource = ArrayDataSource(items:mentors!, cellIdentifier: "waypointsCell") {
            (cell, item) in
            
            if let mentorCell = cell as? MentorCell {
                if let mentor = item as? User {
                    mentorCell.mentor = mentor
                }
            }
        }
        collectionView.dataSource = dataSource
    }
}

extension MentorView: UICollectionViewDelegate {
    
}