//
//  EditAlert.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 15.12.2023.
//

import UIKit

final class EditAlert: UIView {
        var topButtonCallback: (() -> Void)?
        var bottomButtonCallback: (() -> Void)?
        var closeCallback: (() -> Void)?
        
        private let mainView: UIView = {
            let v = UIView()
            v.backgroundColor = .backgroundWhite
            v.layer.cornerRadius = 24
            return v
        }()
        
        private let blurView: UIImageView = {
            let v = UIImageView()
            v.image = .image(name: .alertBackground)
            v.backgroundColor = .clear
            return v
        }()
        
        private let topButton: UIButton = {
            let b = UIButton()
            b.tintColor = .clear
            b.setTitle("Edit", for: .normal)
            b.isUserInteractionEnabled = true
            b.setTitleColor(.mainBlue, for: .normal)
            b.titleLabel?.font = .customFont(type: .lilitaOne, size: 20)
            b.translatesAutoresizingMaskIntoConstraints = false
            return b
        }()
        
        private let bottomButton: UIButton = {
            let b = UIButton()
            b.tintColor = .clear
            b.setTitle("Delete", for: .normal)
            b.setTitleColor(.lettersGrey, for: .normal)
            b.titleLabel?.font = .customFont(type: .lilitaOne, size: 20)
            b.isUserInteractionEnabled = true
            b.translatesAutoresizingMaskIntoConstraints = false
            return b
        }()
        
        private lazy var hStack: UIStackView = {
            let h = UIStackView(arrangedSubviews: [topButton, bottomButton])
            h.axis = .vertical
            h.alignment = .center
            h.distribution = .fillEqually
            h.spacing = 8
            return h
        }()
    
        private let closeImage: UIButton = {
            let image = UIButton()
            image.backgroundColor = .clear
            image.translatesAutoresizingMaskIntoConstraints = false
            let icon = UIImage(named: ImageNameNawMenuType.closeAlert.rawValue)
            image.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            image.setImage(icon, for: .normal)
            return image
        }()
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        required init?(coder: NSCoder) {
            assertionFailure("init(coder:) has not been implemented")
            return nil
        }
        
        @objc func closeTapped() {
            closeCallback?()
        }
        
        private func setup() {
            blurView.translatesAutoresizingMaskIntoConstraints = false
            mainView.translatesAutoresizingMaskIntoConstraints = false
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(blurView)
            addSubview(mainView)
            mainView.addSubview(closeImage)

            mainView.addSubview(hStack)
            
            blurView.autoPinEdgesToSuperView()
            
            let width = UIScreen.main.bounds.width
            let alertWidth = UIDevice.current.isIPhone ? width * 0.4 : width * 0.6
            NSLayoutConstraint.activate([
                mainView.widthAnchor.constraint(equalToConstant: alertWidth),
                mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
                mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
                mainView.heightAnchor.constraint(equalToConstant: 112),
                
                topButton.heightAnchor.constraint(equalToConstant: 44),
                bottomButton.heightAnchor.constraint(equalToConstant: 44),
                
                hStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
                hStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
                hStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
                
                closeImage.topAnchor.constraint(equalTo: mainView.topAnchor),
                closeImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                closeImage.widthAnchor.constraint(equalToConstant: 32),
                closeImage.heightAnchor.constraint(equalToConstant: 32),
            ])
            
            topButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftButtonTapped)))
            bottomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightButtonTapped)))
        }
        
        func configureUI() {
    //        topButton.setImage(UIImage.image(name: leftButtonImageType), for: .normal)
        }
        
        @objc
        private func leftButtonTapped(_ sender: UITapGestureRecognizer) {
            topButtonCallback?()
        }
        
        @objc
        private func rightButtonTapped(sender: UITapGestureRecognizer) {
            bottomButtonCallback?()
        }
    }
