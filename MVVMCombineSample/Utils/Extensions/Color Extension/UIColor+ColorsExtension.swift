//
//  UIColor+ColorsExtension.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation
import UIKit

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


extension UIColor {
    
    // Primary colors
    static let primaryCyan = hexStringToUIColor(hex: "#2ACFCF")
    static let primaryDarkViolet = hexStringToUIColor(hex: "#3B3054")
    
    // Secondary colors
    static let secondaryRed = hexStringToUIColor(hex: "#F46262")
    
    // Neutral colors
    static let neutralLightGray = hexStringToUIColor(hex: "#BFBFBF")
    static let neutralGray = hexStringToUIColor(hex: "#9E9AA7")
    static let neutralGrayishViolet = hexStringToUIColor(hex: "#35323E")
    static let neutralVeryDarkVioletColor = hexStringToUIColor(hex: "#232127")
    
    // Background colors
    static let backgroundWhite = hexStringToUIColor(hex: "#FFFFFF")
    static let backgroundOffWhite = hexStringToUIColor(hex: "#F0F1F6")
    static let backgroundGray = hexStringToUIColor(hex: "#E5E5E5")
    
}
