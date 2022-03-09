//
//  ShortenURLTableCell.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation
import UIKit
import Combine

final class ShortenURLTableCell: UITableViewCell {
    static let identifier = "ShortenURLTableCell"
    
    var viewModel: ShortenURLCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    lazy var longURLLabel: TextStyleLabel = {
        let label = TextStyleLabel(frame: .zero)
        label.textStyle = .caption1
        
        label.textColor = .neutralGrayishViolet
        return label
    }()
 
    lazy var shortURLLabel: TextStyleLabel = {
        let label = TextStyleLabel(frame: .zero)
        label.textStyle = .caption1
        
        label.textColor = .primaryCyan
        return label
    }()
    
    lazy var copyButton = TextStyleButton()
    lazy var deleteButton = UIButton()
    lazy var separatorView = UIView()
    lazy var parentCardView = UIView()
    lazy var superCardView = UIView()

    var copyBtnPressed : (() -> ())?
    var deleteBtnPressed : (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubiews()
        setUpConstraints()
        setUpCellContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubiews() {
        let subviews = [parentCardView, superCardView, longURLLabel, shortURLLabel, separatorView, deleteButton, copyButton]
        
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
    }
    
    private func setUpCellContents() {
        self.selectionStyle = .none
        backgroundColor = .backgroundOffWhite
        deleteButton.setImage(UIImage(named: "DeleteIcon"), for: .normal)
        separatorView.backgroundColor = .neutralLightGray
        self.copyButton.isCopied = false
        
        copyButton.layer.cornerRadius = 4.0
        copyButton.backgroundColor = .primaryCyan
        copyButton.setTitle("COPY", for: .normal)
        
        copyButton.textStyle = .largeTitle
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)

        self.parentCardView.layer.cornerRadius = 8.0
        self.parentCardView.layer.borderWidth = 1.0
        self.parentCardView.layer.borderColor = UIColor.clear.cgColor
        self.parentCardView.backgroundColor = .white

    }
    
    @objc private func copyAction() {
        UIPasteboard.general.string = copyButton.titleLabel?.text
        copyButton.backgroundColor = .primaryDarkViolet
        copyButton.setTitle("COPIED!", for: .normal)
        copyBtnPressed?()
    }
    
    @objc private func deleteAction() {
        deleteBtnPressed?()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            superCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.0),
            superCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.0),
            superCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.0),
            superCardView.heightAnchor.constraint(equalToConstant: 200.0),
            superCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1.0),
            
            parentCardView.topAnchor.constraint(equalTo: superCardView.topAnchor, constant: 1.0),
            parentCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25.0),
            parentCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.0),
            parentCardView.heightAnchor.constraint(equalToConstant: 176.0),
            parentCardView.bottomAnchor.constraint(equalTo: superCardView.bottomAnchor, constant: -20.0),

            longURLLabel.topAnchor.constraint(equalTo: parentCardView.topAnchor, constant: 23.0),
            longURLLabel.leadingAnchor.constraint(equalTo: parentCardView.leadingAnchor, constant: 23.0),
            longURLLabel.heightAnchor.constraint(equalToConstant: 22.0),

            deleteButton.centerYAnchor.constraint(equalTo: longURLLabel.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: longURLLabel.trailingAnchor, constant: 8.0),
            deleteButton.trailingAnchor.constraint(equalTo: parentCardView.trailingAnchor, constant: -23.0),
            deleteButton.heightAnchor.constraint(equalToConstant: 18.0),
            deleteButton.widthAnchor.constraint(equalToConstant: 14.0),
            
            
            separatorView.topAnchor.constraint(equalTo: longURLLabel.bottomAnchor, constant: 12.0),
            separatorView.leadingAnchor.constraint(equalTo: parentCardView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: parentCardView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),

            shortURLLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12.0),
            shortURLLabel.leadingAnchor.constraint(equalTo: longURLLabel.leadingAnchor),
            shortURLLabel.trailingAnchor.constraint(equalTo: parentCardView.trailingAnchor, constant: -23.0),
            shortURLLabel.heightAnchor.constraint(equalTo: longURLLabel.heightAnchor),
            
            copyButton.topAnchor.constraint(equalTo: shortURLLabel.bottomAnchor, constant: 23.0),
            copyButton.leadingAnchor.constraint(equalTo: longURLLabel.leadingAnchor),
            copyButton.trailingAnchor.constraint(equalTo: parentCardView.trailingAnchor, constant: -23.0),
            copyButton.heightAnchor.constraint(equalToConstant: 39.0),
            copyButton.bottomAnchor.constraint(equalTo: parentCardView.bottomAnchor, constant: -23.0)
        ])
    }
    
    private func setUpViewModel() {
        longURLLabel.text = viewModel.fullLengthURL
        shortURLLabel.text = viewModel.shortenedURL
        
        if viewModel.isCopied {
            copyButton.backgroundColor = .primaryDarkViolet
            copyButton.setTitle("COPIED!", for: .normal)
        } else {
            copyButton.backgroundColor = .primaryCyan
            copyButton.setTitle("COPY", for: .normal)
        }
    }
}
