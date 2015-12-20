//
//  StartResqViewController.swift
//  ResQSwift
//
//  Created by Eliel Gordon on 10/3/15.
//  Copyright © 2015 Resq Medical. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var pageViewController: UIPageViewController!
    // Init
    let pageTitles = ["Find mentors in your city", "Connect and engage with mentors", "Let's get started"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.primaryBlueColor()
        
        /* Getting the page View controller */
        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let pageContentViewController = createViewController(0)
        pageViewController.setViewControllers([pageContentViewController], direction: .Forward, animated: true, completion: nil)
        
        /* We are substracting 60 because we have a start again button whose height is 60*/
        pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 60)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)

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
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.Portrait, .PortraitUpsideDown]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageTitles.count
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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