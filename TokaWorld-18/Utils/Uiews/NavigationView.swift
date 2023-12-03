//
//  NavigationView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 10.11.2023.
//

import UIKit


class NavigationView: UIView {

    let leftButton:  RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    let rightButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    private let titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "LilitaOne", size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.87
        
        return titleLabel
    }()

    // MARK: - Initialization

    required init(leftButtonType: ImageNameNawMenuType, title: String, rightButtonType: ImageNameNawMenuType) {
        super.init(frame: .zero)

        setupButton(leftButton, withImageName: leftButtonType)
        setupButton(rightButton, withImageName: rightButtonType)
        titleLabel.text = title
        
        setupViews()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View Setup
    
    private func setupButton(_ button: RoundButton, withImageName: ImageNameNawMenuType) {
        
        if withImageName == .none {
            button.isHidden = true
        } else{
            button.setImageA(UIImage(named: withImageName.rawValue))
        }
        
    }

    private func setupViews() {
        backgroundColor = .white
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 30),
            leftButton.heightAnchor.constraint(equalToConstant: 30),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 30),
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ])

    }
}

