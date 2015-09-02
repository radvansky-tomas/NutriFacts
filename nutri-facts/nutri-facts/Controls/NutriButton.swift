//
//  ALLocalizableButton.swift
//  entreinfidele
//
//  Created by Tomas Radvansky on 02/02/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.
//

import UIKit

@IBDesignable class NutriButton: UIButton {
    //MARK: Localization
    @IBInspectable
    var localizeString:String = "" {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                var bundle = NSBundle(forClass: self.dynamicType)
                self.setTitle(bundle.localizedStringForKey(self.localizeString, value:"", table: nil), forState: UIControlState.Normal)
                #else
                self.setTitle(NSLocalizedString(self.localizeString, comment:""), forState: UIControlState.Normal)
            #endif
        }
    }
    //MARK: Layer parameters
    @IBInspectable
    var borderColor:UIColor = UIColor.clearColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    @IBInspectable
    var borderWidth:CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    var cornerRadius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var rounded:Bool = false {
        didSet {
            if rounded
            {
                self.layer.cornerRadius = self.frame.size.width / 2
                self.layer.masksToBounds = true
            }
            else
            {
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = false
            }
        }
    }
    
    //MARK: Icomoon
    @IBInspectable
    var iconColor:UIColor = UIColor.whiteColor() {
        didSet {
            let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.Center
            let textFontAttributes: [String: AnyObject] = [
                NSFontAttributeName : UIFont(name: "icomoon", size: self.frame.height)!,
                NSForegroundColorAttributeName : iconColor,
                NSParagraphStyleAttributeName : style
            ]
            self.setAttributedTitle(NSAttributedString(string: MoonIcons.allValues[icon].rawValue , attributes: textFontAttributes), forState: UIControlState.Normal)
        }
    }
    
    @IBInspectable
    var icon:Int = 0 {
        didSet {
            if icon <= MoonIcons.allValues.count-1
            {
                let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
                    style.alignment = NSTextAlignment.Center
                    let textFontAttributes: [String: AnyObject] = [
                        NSFontAttributeName : UIFont(name: "icomoon", size: self.frame.height)!,
                        NSForegroundColorAttributeName : iconColor,
                        NSParagraphStyleAttributeName : style
                    ]
                    self.setAttributedTitle(NSAttributedString(string: MoonIcons.allValues[icon].rawValue , attributes: textFontAttributes), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBInspectable
    var IconsSize:Double = 16.0 {
        didSet {
            if icon <= MoonIcons.allValues.count-1 && icon > -1
            {
                self.setAttributedTitle(Globals.GetAttributedTextForIcon(NSTextAlignment.Center, iconSize: CGFloat(IconsSize), iconColor: iconColor, icon: MoonIcons.allValues[icon].rawValue), forState: UIControlState.Normal)
            }
        }
    }

}
