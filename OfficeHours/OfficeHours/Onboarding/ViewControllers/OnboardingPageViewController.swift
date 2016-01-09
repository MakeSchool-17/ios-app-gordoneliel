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
        dataSource = self
        delegate = self

        view.backgroundColor = UIColor.lightBlueColor()


        setViewControllers([getStepOne()], direction: .Forward, animated: true, completion: nil)
    }
    
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewControllerWithIdentifier("StepOne") as! StepOne
    }

    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewControllerWithIdentifier("StepTwo") as! StepTwo
    }
    
    func getStepThree() -> StepThree {
        return storyboard!.instantiateViewControllerWithIdentifier("StepThree") as! StepThree
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController is StepThree {
            // 3 -> 2
            return getStepTwo()
        } else if viewController is StepTwo {
            // 2 -> 1
            return getStepOne()
        } else {
            // 0 -> end of the road
            return nil
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController is StepOne {
            // 1 -> 2
            return getStepTwo()
        } else if viewController is StepTwo {
            // 2 -> 3
            return getStepThree()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPageViewController: UIPageViewControllerDelegate {
//    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
//        return [.Portrait, .PortraitUpsideDown]
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
//        if pendingViewControllers.first is LoginViewController {
//            UIView.animateWithDuration(0.3) {
//                self.view.backgroundColor = UIColor.whiteColor()
//            }
//        } else {
//            UIView.animateWithDuration(0.3) {
//                self.view.backgroundColor = UIColor.primaryBlueColor()
//            }
//        }
//    }
//
//    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if finished && completed {
//
//        }
//    }
}