//
//  LinkHistoryView.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit

final class LinkHistoryView: UIView {
    
    
    //MARK: -- Properties
    lazy var logoImageView = UIImageView()
    lazy var illustrationImageView = UIImageView()

    lazy var tableView = UITableView(frame: .zero)
    lazy var bottomView = UIView()
    lazy var backgroundView = UIView()

    lazy var headingLabel: TextStyleLabel = {
        let label = TextStyleLabel(frame: .zero)
        label.textStyle = .caption1
        
        label.text = "Your Link History"
        label.textColor = .neutralGrayishViolet
        return label
    }()
    
    lazy var letsGetStartedLabel: TextStyleLabel = {
        let label = TextStyleLabel(frame: .zero)
        label.textStyle = .title1
        
        label.text = "Let's get started!"
        label.textAlignment = .center
        label.textColor = .neutralGrayishViolet
        return label
    }()
    
    lazy var pasteLinkHintLabel: TextStyleLabel = {
        let label = TextStyleLabel(frame: .zero)
        label.textStyle = .caption1
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Paste your first link into the field to shorten it"
        label.textColor = .neutralGrayishViolet
        return label
    }()

    lazy var addLinkTextField = CustomRoundedTextField()
    lazy var shortURLButton = TextStyleButton()

    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    lazy var backgroundImageView = UIImageView()

    
    //MARK: -- Lifecycle

    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- AddSubviews
    private func addSubviews() {
        let subviews = [ bottomView, bottomView, backgroundImageView, backgroundView, tableView, addLinkTextField, shortURLButton, illustrationImageView, pasteLinkHintLabel, letsGetStartedLabel, activityIndicationView, logoImageView, headingLabel]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            //Top Logo Shortly
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 83.0),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 32.0),
            logoImageView.widthAnchor.constraint(equalToConstant: 120.0),

            //Top Heading for tableview
            headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 69.0),
            headingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headingLabel.heightAnchor.constraint(equalToConstant: 22.0),

            //Center lady image with table
            illustrationImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(243.0/800.0)),
            illustrationImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(350.0/375.0)),
            illustrationImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            illustrationImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60.0),

            //tableview
            tableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 25.0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //Added for bg color
            backgroundView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 25.0),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 204.0),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),

            //Shorten textfield
            addLinkTextField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 46.0),
            addLinkTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48.0),
            addLinkTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48.0),
            addLinkTextField.heightAnchor.constraint(equalToConstant: 49.0),
            
            //Shorten button
            shortURLButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48.0),
            shortURLButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48.0),
            shortURLButton.heightAnchor.constraint(equalToConstant: 49.0),
            shortURLButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50.0),
            
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(237.0/800.0)),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 160.0),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75.0),
          
            
            pasteLinkHintLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pasteLinkHintLabel.widthAnchor.constraint(equalToConstant: 225.0),
            pasteLinkHintLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -29.0),
            
            letsGetStartedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            letsGetStartedLabel.widthAnchor.constraint(equalToConstant: 270.0),
            letsGetStartedLabel.bottomAnchor.constraint(equalTo: pasteLinkHintLabel.topAnchor, constant: -7.0),


            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50.0),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setUpViews() {
        
        self.backgroundColor = .backgroundOffWhite
        tableView.backgroundColor = .backgroundOffWhite
        bottomView.backgroundColor = .primaryDarkViolet
        
        addLinkTextField.autocorrectionType = .no
        addLinkTextField.backgroundColor = .backgroundWhite
        addLinkTextField.placeholder = "Shorten a link here..."
        addLinkTextField.textAlignment = .center
        addLinkTextField.borderStyle = .none
        
        shortURLButton.layer.cornerRadius = 6.0
        shortURLButton.backgroundColor = .primaryCyan
        shortURLButton.setTitle("SHORTEN IT", for: .normal)
        shortURLButton.textStyle = .title1
        illustrationImageView.contentMode = .scaleAspectFill
        illustrationImageView.image = UIImage(named: "tableWithWomen")
        logoImageView.image = UIImage(named: "appLogo")
        
        backgroundImageView.image = UIImage(named: "backgroundImage")
        backgroundImageView.contentMode = .scaleToFill
        backgroundView.backgroundColor = .backgroundOffWhite
        
        initialViewSetup()
    }
    
    func startLoading() {
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        
        activityIndicationView.stopAnimating()
    }
    
    private func initialViewSetup() {
        self.headingLabel.isHidden = true
        self.tableView.isHidden = true
    }
}



