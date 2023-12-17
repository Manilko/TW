//
//  DetailEditView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class DetailEditView: UIView {

    // MARK: - Properties
    var navView = NavigationView(leftButtonType: .leftArrow, title: "Detail", rightButtonType: ImageNameNawMenuType.loading)

    let navigationButtons: NavigationButtons = NavigationButtons()
    
    var characterView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var frameView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "frame")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let editButton: UIButton = {
        let b = UIButton()
        b.tintColor = .clear
        b.backgroundColor = .backgroundBlue
        b.setTitle("Edit", for: .normal)
        b.titleLabel?.font = .customFont(type: .lilitaOne, size: 20)
        b.setTitleColor(.lettersBlue, for: .normal)
        b.layer.cornerRadius = 20
        b.isUserInteractionEnabled = true
        return b
    }()
    
    let deleteButton: UIButton = {
        let b = UIButton()
        b.tintColor = .clear
        b.backgroundColor = .backgroundGrey
        b.setTitle("Delete", for: .normal)
        b.titleLabel?.font = .customFont(type: .lilitaOne, size: 20)
        b.setTitleColor(.lettersWhite, for: .normal)
        b.layer.cornerRadius = 20
        b.layer.borderWidth = 2
        b.layer.borderColor = .borderColorWhite.cgColor
        b.isUserInteractionEnabled = true
        return b
    }()
    
    private lazy var hStack: UIStackView = {
        let h = UIStackView(arrangedSubviews: [deleteButton, editButton])
        h.axis = .horizontal
        h.alignment = .center
        h.distribution = .fillEqually
        h.spacing = 8
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()

    // MARK: - Lifecycle
    init(startSet: HeroSet) {
        
        super.init(frame: .zero)

        guard let iconData = startSet.iconImage else {return}
        characterView.image = UIImage(data: iconData)
        
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(startSet: HeroSet) {
        guard let iconData = startSet.iconImage else {return}
        characterView.image = UIImage(data: iconData)
    }

    private func configureLayout() {
        backgroundColor = .backgroundBlue
        
        addSubview(navView)
        addSubview(characterView)
        addSubview(navigationButtons)
        addSubview(frameView)
        addSubview(hStack)

        frameView.translatesAutoresizingMaskIntoConstraints = false
        navigationButtons.translatesAutoresizingMaskIntoConstraints = false
        characterView.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),

            navigationButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            navigationButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            navigationButtons.heightAnchor.constraint(equalToConstant: 100),
            navigationButtons.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            characterView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            characterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            characterView.heightAnchor.constraint(equalToConstant: 350),
            
            hStack.topAnchor.constraint(equalTo: characterView.bottomAnchor, constant: 30),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.heightAnchor.constraint(equalToConstant: 52),
            
            frameView.bottomAnchor.constraint(equalTo: bottomAnchor),
            frameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            frameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            frameView.heightAnchor.constraint(equalToConstant: 230),

        ])
    }
}

