//
//  BlueTitleAlertView.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

final class BlueTitleAlertView: UIView {
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
        v.textColor = .mainBlue
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    private let titleText: String
    
    var dismissCompletion: (() -> ())?

    public init(
        titleText: String
    ) {
        self.titleText = titleText
        
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurView)
        addSubview(mainView)
        
        mainView.addSubview(titleLabel)
        
        blurView.autoPinEdgesToSuperView()

        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
        ])
    }
    
    func configureUI() {
        titleLabel.text = titleText
    }
}
