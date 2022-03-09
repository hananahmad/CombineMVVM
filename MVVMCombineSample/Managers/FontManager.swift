//
//  FontManager.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation
import UIKit

//MARK: - Font Parts

fileprivate let _largeTitle: (String, CGFloat)   = ( "Poppins-Bold", 17.0 )

fileprivate let _title1: (String, CGFloat)       = ( "Poppins-Bold", 20.0 )
fileprivate let _title2: (String, CGFloat)       = ( "Poppins-Medium", 20.0 )
fileprivate let _title3: (String, CGFloat)       = ( "Poppins-Regular", 20.0 )

fileprivate let _headline: (String, CGFloat)     = ( "Poppins-SemiBold", 17.0 )
fileprivate let _subheadline: (String, CGFloat)  = ( "Poppins-ExtraLight", 17.0 )

fileprivate let _body: (String, CGFloat)         = ( "Poppins-Regular", 17.0 )
fileprivate let _callout: (String, CGFloat)      = ( "Poppins-SemiBold", 16.0 )

fileprivate let _footnote: (String, CGFloat)     = ( "Poppins-Regular", 15.0 )

fileprivate let _caption1: (String, CGFloat)     = ( "Poppins-Medium", 17.0 )
fileprivate let _caption2: (String, CGFloat)     = ( "Poppins-Regular", 11.0 )

fileprivate let _boldHeading: (String, CGFloat)     = ( "Poppins-Bold", 13.0 )

//MARK: - Font TextStyle

extension UIFont.TextStyle {

    /**
     The UIFont metrics for a given font style, useful if you need to do content sizing as well.
     */
    var fontMetrics: UIFontMetrics {
        return UIFontMetrics(forTextStyle: self)
    }

    /**
     The scaled custom UIFont for a given text style, optionally scaled per the trait collection
     */
    func scaledCustomFont(for traitCollection: UITraitCollection? = nil) -> UIFont {
        let (name, size) = UIFont.TextStyle.sizeMap[self]!
        let customFont = UIFont(name: name, size: size)!

        if let traitCollection = traitCollection {
            if let maximumPointSize = maximumPointSize {
                return fontMetrics.scaledFont(for: customFont,
                                 maximumPointSize: maximumPointSize,
                                   compatibleWith: traitCollection)
            }
            return fontMetrics.scaledFont(for: customFont, compatibleWith: traitCollection)
        }

        if let maximumPointSize = maximumPointSize {
            return fontMetrics.scaledFont(for: customFont, maximumPointSize: maximumPointSize)
        }

        return fontMetrics.scaledFont(for: customFont)
    }

    /**
     The un-scaled custom UIFont for a given text style
     */
    fileprivate var customFont: UIFont {
        let (name, size) = UIFont.TextStyle.sizeMap[self]!
        return UIFont(name: name, size: size)!
    }

    /**
     (Optionally) Provide the maximum point size by text style
     */
    fileprivate var maximumPointSize: CGFloat? {
        switch self {
        case .largeTitle: return 44.0
        default: return nil
        }
    }

    fileprivate static let sizeMap: [ UIFont.TextStyle: (String, CGFloat) ] = [
        .largeTitle:  _largeTitle,
        .title1:      _title1,
        .title2:      _title2,
        .title3:      _title3,
        .headline:    _headline,
        .subheadline: _subheadline,
        .body:        _body,
        .callout:     _callout,
        .footnote:    _footnote,
        .caption1:    _caption1,
        .caption2:    _caption2,
        ]

}
