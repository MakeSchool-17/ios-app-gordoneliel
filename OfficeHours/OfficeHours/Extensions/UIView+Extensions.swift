//
//  UIView+Extensions.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/17/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
        self.clipsToBounds = true
    }
}