//
//  OnboardingDataModel.swift
//  OnboardingTutorial
//
//  Created by Eliel Gordon on 10/20/15.
//  Copyright © 2015 Resq Medical. All rights reserved.
//

import Foundation
import UIKit

/**
*  Onboarding DataModel for the onboarding display
*/
struct OnboardingDataModel {
    var title: String
    var circleImage: CircleImage
    var index: Int
    
    init(title: String, index: Int) {
        self.title = title
        self.index = index
        
        switch index {
        case 0:
            circleImage = .City
        case 1:
            circleImage = .Mentor
        case 2:
            circleImage = .Logo
        default:
            circleImage = .Logo
        }
    }
}

extension OnboardingDataModel {
    
    /**
    Describes the image to use for a view
    
    - City:  Image for City Illustration
    - Mentor: Image for Mentor Illustration
    - Logo:     Image App Logo
    */
    enum CircleImage {
        case City
        case Mentor
        case Logo
        
        func toUIImage() -> UIImage {
            switch self {
            case .City:
                return UIImage(named: "CityIllustration")!
            case .Mentor:
                return UIImage(named: "MentorIllustration")!
            case .Logo:
                return UIImage(named: "LogoIllustration")!
                
            }
        }
    }
}