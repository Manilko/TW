//
//  TitleSubtitleAndTwoHButtonView.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

final class TitleSubtitleAndTwoHButtonView: UIView {
    var rightCallback: (() -> Void)?
    var leftCallback: (() -> Void)?
    
    private let mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()
    
    private let blurView: UIImageView = {
        let v = UIImageView()
        v.image = .image(name: .alertBackground)
        v.backgroundColor = .clear
        return v
    }()
    
    private let titleLabel: UILabel = {
        let v = UILabel()
        v.font = .customFont(type: .lilitaOne, size: 28)
        v.textColor = .black
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    private let subtitleLabel: UILabel = {
        let v = UILabel()
        v.font = .customFont(type: .lilitaOne, size: 18)
        v.textColor = .black
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        v.axis = .vertical
        v.alignment = .center
        v.distribution = .fillEqually
        v.spacing = 16
        return v
    }()
    
    private let leftButton: UIButton = {
        let b = UIButton()
        b.tintColor = .clear
        b.isUserInteractionEnabled = true
        return b
    }()
    
    private let rightButton: UIButton = {
        let b = UIButton()
        b.tintColor = .clear
        b.isUserInteractionEnabled = true
        return b
    }()
    
    private lazy var hStack: UIStackView = {
        let h = UIStackView(arrangedSubviews: [leftButton, rightButton])
        h.axis = .horizontal
        h.alignment = .center
        h.distribution = .fillEqually
        h.spacing = 8
        return h
    }()
    
    private let titleText: String
    private let subtitleText: String
    private let leftButtonImageType: ImageType
    private let rightButtonImageType: ImageType
    
    init(
        titleText: String,
        subtitleText: String,
        leftButtonImageType: ImageType,
        rightButtonImageType: ImageType
    ) {
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.leftButtonImageType = leftButtonImageType
        self.rightButtonImageType = rightButtonImageType
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setup() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurView)
        addSubview(mainView)
        
        mainView.addSubview(vStack)
        mainView.addSubview(hStack)
        
        blurView.autoPinEdgesToSuperView()
        
        let width = UIScreen.main.bounds.width
        let alertWidth = UIDevice.current.isIPhone ? width - 40 : width * 0.6
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalToConstant: alertWidth),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            vStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            vStack.bottomAnchor.constraint(equalTo: hStack.topAnchor, constant: -16),
            
            leftButton.heightAnchor.constraint(equalToConstant: 44),
            rightButton.heightAnchor.constraint(equalToConstant: 44),
            
            hStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20)
        ])
        
        leftButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftButtonTapped)))
        rightButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightButtonTapped)))
    }
    
    func configureUI() {
        leftButton.setImage(UIImage.image(name: leftButtonImageType), for: .normal)
        rightButton.setImage(UIImage.image(name: rightButtonImageType), for: .normal)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    @objc
    private func leftButtonTapped(_ sender: UITapGestureRecognizer) {
        leftCallback?()
    }
    
    @objc
    private func rightButtonTapped(sender: UITapGestureRecognizer) {
        rightCallback?()
    }
}
