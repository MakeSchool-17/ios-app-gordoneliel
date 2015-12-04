//
//  ConnectonsViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/3/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

class ConnectonsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: users!, cellIdentifier: ConnectionCellIdentifier) {
            (cell, user) in
            
            let connectionsCell = cell as! ConnectionCell
            
            if let user = user as? User {
                connectionsCell.user = user
            }
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension ConnectonsViewController: UICollectionViewDelegate {
    
}

extension ConnectonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}