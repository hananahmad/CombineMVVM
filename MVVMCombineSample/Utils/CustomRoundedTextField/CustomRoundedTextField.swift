//
//  CustomRoundedTextField.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import UIKit

@IBDesignable
class CustomRoundedTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    private func sharedInit() {
        borderStyle = .none

        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 8
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 49)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).insetBy(dx: 8, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).insetBy(dx: 8, dy: 0)
    }

}
