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
        button.isUserInteractionEnabled = true
        return button
    }()

    let rightButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "LilitaOne", size: 20)
        titleLabel.contentMode = .center
        
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
            button.setImageA(UIImage.image(name: withImageName.rawValue))
        }
    }
    
    private func setupButton(_ button: RoundButton, withImageName: ImageType?) {
        if withImageName == nil {
            button.isHidden = true
        } else{
            button.setImage(UIImage.image(name: withImageName?.rawValue ?? ""), for: .normal)
        }
    }

    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            leftButton.heightAnchor.constraint(equalToConstant: 40),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 40),
            rightButton.heightAnchor.constraint(equalToConstant: 40),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

