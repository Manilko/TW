//
//  DetailModsView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit

class DetailModsView: UIView {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .mainBlue
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainBlue
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .lettersWhite
        
        let shadowLabel = UILabel()
        shadowLabel.text = label.text
        shadowLabel.font = label.font
        shadowLabel.textColor = .black
        shadowLabel.translatesAutoresizingMaskIntoConstraints = false
        label.addSubview(shadowLabel)

        NSLayoutConstraint.activate([
            shadowLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            shadowLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            shadowLabel.topAnchor.constraint(equalTo: label.topAnchor),
            shadowLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor),
        ])
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lettersWhite
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Methods
    
    func configure(with model: Mod) {
        imageView.image = .getImageFromFile(fileName: "/Mods/\(model.rd1Lf2 ?? "" )")
        nameLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
    }

    private func setupUI() {
        backgroundColor = .mainBlue

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}

