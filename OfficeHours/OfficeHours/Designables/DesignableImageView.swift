//
//  DesignableImageView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/1/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableImageView: UIImageView {
    
    enum ImageCornerType {
        case Circle
        case CustomRadius(Int)
        
        func CornerTypeToRadius(radius: Int) {
            switch self {
            case .Circle:
//                self.layer.cornerRadius = frame.size.width / 2
                break
            case .CustomRadius(radius):
                break
            default: break
            }
        }
    }
    
    let cornerType: ImageCornerType = ImageCornerType.Circle
    
    @IBInspectable public var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = frame.size.width / 2
        }
    }
    
}
