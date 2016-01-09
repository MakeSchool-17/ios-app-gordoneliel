//
//
//  Created by Eliel Gordon on 8/31/15.
//

import UIKit

public class DesignableTextField: UITextField {
    
    
    
    @IBInspectable public var sidePadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, sidePadding, sidePadding))
            
            leftViewMode = UITextFieldViewMode.Always
            leftView = padding
            
            rightViewMode = UITextFieldViewMode.Always
            rightView = padding
        }
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, leftPadding, 0))
            
            leftViewMode = UITextFieldViewMode.Always
            leftView = padding
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat = 0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, 0, rightPadding))
            
            rightViewMode = UITextFieldViewMode.Always
            rightView = padding
        }
    }
    
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
    
    // Adds a thin borderline to a UITextField
    @IBInspectable var bottomBorder: Bool = true {
        didSet{
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width, 0.5)
            layer.addSublayer(bottomBorder)
            bottomBorder.backgroundColor = borderColor.CGColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var rightBorder: Bool = true {
        didSet{
            let rightBorder = CALayer()
            rightBorder.frame = CGRectMake(self.frame.size.width - 1, 0, 1, self.frame.size.height)
            rightBorder.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).CGColor
            layer.addSublayer(rightBorder)
            setNeedsDisplay()
            
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var lineHeight: CGFloat = 1.5 {
        didSet {
            let font = UIFont(name: self.font!.fontName, size: self.font!.pointSize)
            let text = self.text
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            let attributedString = NSMutableAttributedString(string: text!)
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, attributedString.length))
            
            self.attributedText = attributedString
            setNeedsDisplay()
        }
    }
    
}
