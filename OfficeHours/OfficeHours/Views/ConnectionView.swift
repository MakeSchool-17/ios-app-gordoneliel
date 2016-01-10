//
//  ConnectionView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/10/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import Bond

class ConnectionView: UIView {

    var dataSource: ArrayDataSource?

    var connectionRequests: Observable<[ConnectionRequest]?> = Observable(nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: connectionRequests.value!, cellIdentifier: ActivityCellIdentifier) {
            (cell, request) in
            
            let activityCell = cell as! ActivityCell
            
            if let request = request as? ConnectionRequest {
                activityCell.connectionRequest = request
            }
        }
        
        collectionView.dataSource = dataSource
        collectionView.registerNib(ActivityCell.nib(), forCellWithReuseIdentifier: ActivityCellIdentifier)
    }

}
