//
//  TitleSubtitleAlertView.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

final class TitleSubtitleAlertView: UIView {
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
    
    private let titleText: String
    private let subtitleText: String?

    public init(
        titleText: String,
        subtitleText: String? = nil
    ) {
        self.titleText = titleText
        self.subtitleText = subtitleText
        
        super.init(frame: .zero)
        
        setup()
        configureUI()
    }

    public required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setup() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurView)
        addSubview(mainView)
        
        mainView.addSubview(vStack)
        
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
            vStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20)
        ])
    }
    
    func configureUI() {
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        
        subtitleLabel.isHidden = subtitleText == nil
    }
}
