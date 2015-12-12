//
//  StartResqViewController.swift
//  ResQSwift
//
//  Created by Eliel Gordon on 10/3/15.
//  Copyright © 2015 Resq Medical. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    // Init
    let pageTitles = ["Find Mentors In Your City", "Connect and engage with mentors", "Let's get started"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.primaryBlueColor()
        
        setViewControllers([createViewController(0)],
            direction: .Forward,
            animated: false,
            completion: nil)
        
        dataSource = self
    }
    
    func createViewController(pageNumber: Int) -> UIViewController {
        let pageIndex = self.pageTitles[pageNumber]
        
        let model = OnboardingDataModel(title: pageIndex, index: pageNumber)
        
        var contentViewController: PagingContentViewController
        
        contentViewController = storyboard?.instantiateViewControllerWithIdentifier("PagingContentViewController")
            as! PagingContentViewController
        
        contentViewController.model = model
        
        return contentViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = 0
        
        index = (viewController as! PagingContentViewController).model!.index

        index++
        if index == self.pageTitles.count {
            return nil
        }
        
        return createViewController(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PagingContentViewController).model!.index
        if(index == 0) {
            return nil
        }
        index--
        return createViewController(index)
    }
}