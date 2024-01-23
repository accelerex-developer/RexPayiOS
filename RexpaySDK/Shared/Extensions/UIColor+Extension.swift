//
//  UIColor+Extensions.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex = hex.substring(from: index)
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension UIColor {
    class func compare(_ colorA: UIColor?, with colorB: UIColor?, in view: UIView) -> Bool {
        colorA?.resolvedColor(with: view.traitCollection) == colorB?.resolvedColor(with: view.traitCollection)
    }
}

extension UIColor {
    
    @nonobjc class var hex707070: UIColor{
        return UIColor(hex: "#707070")
    }
    
    @nonobjc class var hexEDEDED: UIColor{
        return UIColor(hex: "#EDEDED")
    }
    
    @nonobjc class var hex1A1A1A: UIColor{
        return UIColor(hex: "#1A1A1A")
    }
    
    @nonobjc class var hex1A1A1AWith72Alpha: UIColor{
        return UIColor(hex: "#1A1A1A").withAlphaComponent(0.72)
    }
    
    @nonobjc class var hex9C9898: UIColor{
        return UIColor(hex: "#9C9898")
    }
    
    @nonobjc class var hexD2543: UIColor{
        return UIColor(hex: "#D2543")
    }
    
    @nonobjc class var hexEE4848: UIColor{
        return UIColor(hex: "#EE4848")
    }
    
    @nonobjc class var hex00ab80: UIColor{
        return UIColor(hex: "#00ab80")
    }
    
    @nonobjc class var hexd49426: UIColor{
        return UIColor(hex: "#d49426")
    }
    
    @nonobjc class var hexDADADA: UIColor{
        return UIColor(hex: "#DADADA")
    }
    
    @nonobjc class var hexFFB400: UIColor{
        return UIColor(hex: "#FFB400")
    }
    
    @nonobjc class var hex4B4651: UIColor{
        return UIColor(hex: "#4B4651")
    }
    
    @nonobjc class var hexE5E5E5: UIColor{
        return UIColor(hex: "#E5E5E5")
    }
    
    
    
    
}
