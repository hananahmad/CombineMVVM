//
//  UIButton+Validation.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import UIKit

extension UIButton {
    var isCopied: Bool {
        get {
             backgroundColor == .primaryDarkViolet
        }
        set {
            backgroundColor = newValue ? .primaryDarkViolet : .primaryCyan
//            isEnabled = newValue
        }
    }
}
