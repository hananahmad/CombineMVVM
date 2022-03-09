//
//  ActivityIndicatorView.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        color = .white
        backgroundColor = .darkGray
        layer.cornerRadius = 5.0
        hidesWhenStopped = true
    }
}
