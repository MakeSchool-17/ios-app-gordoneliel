//
//  DesignableSearchBar.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/9/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSearchBar: UISearchBar {

    @IBInspectable var inputTintColor = UIColor.whiteColor() {
        didSet {
            let inputTextField = self.valueForKey("TextField") as? UITextField
            inputTextField?.backgroundColor = inputTintColor
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
