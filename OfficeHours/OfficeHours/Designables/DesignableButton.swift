//
//  DesignableButton.swift
//
//  Created by Eliel Gordon on 7/10/15.
//

import UIKit

@IBDesignable public class DesignableButton: UIButton {
    
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
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable public var backgroundColorNormal: UIColor? {
        didSet {
            backgroundColor = backgroundColorNormal
        }
    }
    
    @IBInspectable public var backgroundColorHighlighted: UIColor?
    var _backgroundColorHighlighted: UIColor? {
        return backgroundColorHighlighted != nil ? backgroundColorHighlighted : backgroundColorNormal
    }
    
    @IBInspectable public var backgroundColorSelected: UIColor?
    var _backgroundColorSelected: UIColor? {
        return backgroundColorSelected != nil ? backgroundColorSelected : _backgroundColorHighlighted
    }
    
    @IBInspectable public var textColorHighlightedSelected: UIColor? {
        didSet {
            setTitleColor(textColorHighlightedSelected, forState: .Highlighted)
            setTitleColor(textColorHighlightedSelected, forState: .Selected)
        }
    }
    
    @IBInspectable public var backgroundColorHighlightedSelected: UIColor?
    var _backgroundColorHighlightedSelected: UIColor? {
        return backgroundColorHighlightedSelected != nil ? backgroundColorHighlightedSelected : _backgroundColorHighlighted
    }
    
    override public var highlighted: Bool {
        didSet {
            switch (highlighted, selected) {
            case (true, false):
                backgroundColor = _backgroundColorHighlighted
            case (true, true):
                backgroundColor = _backgroundColorHighlightedSelected
            case (false, true):
                backgroundColor = _backgroundColorSelected
            default:
                backgroundColor = backgroundColorNormal
            }
        }
    }
    
}
