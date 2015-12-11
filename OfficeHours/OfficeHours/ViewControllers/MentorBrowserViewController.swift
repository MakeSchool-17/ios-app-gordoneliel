//
//  MentorBrowserViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/10/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import MCCardPickerCollectionViewController
import EBCardCollectionViewLayout

class MentorBrowserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: ArrayDataSource?
    var (mentors, selectedIndex): ([User]?, Int?)
        
    let insets = UIEdgeInsets(top: 50, left: 20, bottom: 10, right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        dataSource = ArrayDataSource(items: mentors!, cellIdentifier: MentorBrowserCellIdentifier) {
            (cell, user) in
            
            let mentorBrowserCell = cell as! MentorBrowserCell
            
            if let user = user as? User {
                mentorBrowserCell.mentor = user
            }
        }
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // CollectionView Layout
        let layout = EBCardCollectionViewLayout()
        layout.layoutType = .Horizontal
        collectionView.collectionViewLayout = layout
        
        var anOffset = UIOffsetZero
        if (layout.layoutType == .Horizontal) {
            anOffset = UIOffsetMake(20, 20)
            layout.offset = anOffset
            layout.layoutType = .Horizontal

        }
        
        collectionView.registerNib(MentorBrowserCell.nib(), forCellWithReuseIdentifier: MentorBrowserCellIdentifier)
    }

    override func shouldAutorotate() -> Bool {
        collectionView.collectionViewLayout.invalidateLayout()
        return true
    }
    @IBAction func dismissMentorBrowser(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MentorBrowserViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension MentorBrowserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = Int((collectionView.frame.size.width) - (insets.left * 2))
        let height = Int((view.frame.height) - (insets.bottom))
        let size = CGSize(width: width, height: height)
        
        return size
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return insets
    }
}