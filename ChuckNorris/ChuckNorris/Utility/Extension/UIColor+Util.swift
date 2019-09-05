//
//  UIColor+Util.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import Foundation

enum AssetsColor:String{
    case mainColour
}

extension UIColor{
    
    /// Returns a given AssetsColor
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
    /// Converts a hexidecimal String to UIColor
    static func hexadecimal(_ colour:String) -> UIColor? {
        
        var int = UInt32()
        let hex = colour.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        return self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
