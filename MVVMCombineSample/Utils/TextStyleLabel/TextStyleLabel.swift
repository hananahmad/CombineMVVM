//
//  TextStyleLabel.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import UIKit

public class TextStyleLabel: UILabel {
    
    public var textStyle: UIFont.TextStyle = .body {
        didSet {
            font = textStyle.scaledCustomFont()
            adjustsFontForContentSizeCategory = true
        }
    }
    
}

public class TextStyleButton: UIButton {
    
    public var textStyle: UIFont.TextStyle = .body {
        didSet {
            titleLabel?.font = textStyle.scaledCustomFont()
        }
    }
    
}
