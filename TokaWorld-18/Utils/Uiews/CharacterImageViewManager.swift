//
//  CharacterImageViewManager.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 22.11.2023.
//

import UIKit

class CharacterImageView: UIView {

    let characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(characterView)

        NSLayoutConstraint.activate([
            characterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterView.widthAnchor.constraint(equalTo: widthAnchor),
            characterView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
