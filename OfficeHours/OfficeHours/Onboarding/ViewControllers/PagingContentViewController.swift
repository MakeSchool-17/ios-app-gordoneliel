//
//  PagingContentViewController.swift
//  OnboardingTutorial
//
//  Created by Eliel Gordon on 10/6/15.
//  Copyright © 2015 Resq Medical. All rights reserved.
//

import UIKit

class PagingContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var model: OnboardingDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTutorialView()
    }
    
    func configureTutorialView() {
        pageControl.currentPage = model!.index
        titleLabel.text = model?.title
        imageView.image = model?.circleImage.toUIImage()

    }
    
    
}
