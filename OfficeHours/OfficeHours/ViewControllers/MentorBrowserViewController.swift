//
//  MentorBrowserViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/10/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import EBCardCollectionViewLayout

class MentorBrowserViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var dataSource: ArrayDataSource?
    var (mentors, selectedIndex): ([User]?, Int?)
    
    let insets = UIEdgeInsets(top: 50, left: 20, bottom: 10, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        pageControl.numberOfPages = mentors!.count
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let indexPath = NSIndexPath(forItem: selectedIndex!, inSection: 0)
        //
        if selectedIndex > 1 {
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: selectedIndex! - 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
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
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    @IBAction func dismissMentorBrowser(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MentorBrowserViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var tmp = floor(CGRectGetMidX(scrollView.bounds) / CGRectGetWidth(scrollView.bounds))
        tmp %= CGFloat(mentors!.count + 1)
        pageControl.currentPage = Int(tmp)
    }
}