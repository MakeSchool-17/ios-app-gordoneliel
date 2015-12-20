//
//  PagingContentViewController.swift
//  OnboardingTutorial
//
//  Created by Eliel Gordon on 10/6/15.
//  Copyright © 2015 Resq Medical. All rights reserved.
//

import UIKit

class PagingContentViewController: UIViewController {

    @IBOutlet weak var circleContainerView: DesignableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var model: OnboardingDataModel?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureTutorialView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureTutorialView() {
        circleContainerView.roundCorners(.AllCorners, radius: circleContainerView.frame.size.width / 2)
        
        pageControl.currentPage = model!.index
        titleLabel.text = model?.title
        imageView.image = model?.circleImage.toUIImage()

    }
    
    
}
