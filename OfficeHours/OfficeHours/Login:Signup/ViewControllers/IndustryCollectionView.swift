//
//  IndustryCollectionView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/10/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import SVProgressHUD

class IndustryCollectionView: UICollectionViewController {

    let insets = UIEdgeInsets(top: 50, left: 8, bottom: 10, right: 8)
    
    var industries: [String]? {
        didSet {
            setupCollectionView()
            SVProgressHUD.dismiss()
        }
    }
    var dataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.registerNib(IndustrySelectionCell.nib(), forCellWithReuseIdentifier: IndustrySelectionCellIdentifier)
        
        SVProgressHUD.showWithMaskType(.Black)
        ParseHelper.fetchIndustryConfig {
            industries in
            
            self.industries = industries
            
        }
        // Do any additional setup after loading the view.
    }

    func setupCollectionView() {
        dataSource = ArrayDataSource(items: industries!, cellIdentifier: IndustrySelectionCellIdentifier) {
            (cell, item) in
            
            if let cell = cell as? IndustrySelectionCell {
                if let item = item as? String {
                    cell.industry.text = item
                }
            }
        }
        
        collectionView!.dataSource = dataSource
        collectionView?.delegate = self
    }
    
    // MARK: Navigation
}

extension IndustryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = 55
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

extension IndustryCollectionView {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let user = User.currentUser() {
            let industry = industries![indexPath.row]
            user.industry = industry
            user.saveInBackground()
            
            user.userIndustry.next(industry)
            
            self.navigationController?.popViewControllerAnimated(true)
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }
}
