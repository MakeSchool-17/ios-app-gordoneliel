//
//  OnboardingPageViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/1/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    // Init
    let pageTitles = ["Find mentors in your city", "Connect and engage with mentors", "Let's get started", ""]
    
    override func viewDidLoad() {
        // Set the dataSource and delegate in code.
        // I can't figure out how to do this in the Storyboard!
        dataSource = self
        delegate = self
        // this sets the background color of the built-in paging dots
        view.backgroundColor = UIColor.primaryBlueColor()
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lighterGrayColor()
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.lighterDarkGrayColor()
        UIPageControl.appearance().backgroundColor = UIColor.clearColor()
        
        // This is the starting point.  Start with step zero.
        let pageContentViewController = createViewController(0)
        setViewControllers([pageContentViewController], direction: .Forward, animated: true, completion: nil)
    }
//    func getStepZero() -> StepZero {
//        return storyboard!.instantiateViewControllerWithIdentifier("StepZero") as! StepZero
//    }
//    
//    func getStepOne() -> StepOne {
//        return storyboard!.instantiateViewControllerWithIdentifier("StepOne") as! StepOne
//    }
//    
//    func getStepTwo() -> StepTwo {
//        return storyboard!.instantiateViewControllerWithIdentifier("StepTwo") as! StepTwo
//    }
    func createViewController(pageNumber: Int) -> UIViewController {
        let pageIndex = self.pageTitles[pageNumber]
        
        if pageNumber == 3 {
            let storyboard = UIStoryboard(name: "LoginSignup", bundle: nil)
            let contentViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
                as! LoginViewController
            return contentViewController
        }
        
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

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = 0
        
        if viewController is LoginViewController {
            index = 3
        } else {
            index = (viewController as! PagingContentViewController).model!.index
        }
        
        index++
        if index == self.pageTitles.count {
            return nil
        }
        
        return createViewController(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index: Int
        if viewController is SignUpViewController {
            index = 3
        }else {
            index = (viewController as! PagingContentViewController).model!.index
        }
        
        if(index == 0) {
            return nil
        }
        index--
        return createViewController(index)
    }

//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        if viewController.isKindOfClass(StepTwo) {
//            // 2 -> 1
//            return getStepOne()
//        } else if viewController.isKindOfClass(StepOne) {
//            // 1 -> 0
//            return getStepZero()
//        } else {
//            // 0 -> end of the road
//            return nil
//        }
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        if viewController.isKindOfClass(StepZero) {
//            // 0 -> 1
//            return getStepOne()
//        } else if viewController.isKindOfClass(StepOne) {
//            // 1 -> 2
//            return getStepTwo()
//        } else {
//            // 2 -> end of the road
//            return nil
//        }
//    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPageViewController : UIPageViewControllerDelegate {
    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        return [.Portrait, .PortraitUpsideDown]
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        if pendingViewControllers.first is LoginViewController {
            UIView.animateWithDuration(0.3) {
                self.view.backgroundColor = UIColor.whiteColor()
            }
        } else {
            UIView.animateWithDuration(0.3) {
                self.view.backgroundColor = UIColor.primaryBlueColor()
            }
        }
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished && completed {

        }
    }
}