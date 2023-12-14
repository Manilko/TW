//
//  RecommendedCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit

class RecommendedCell: UICollectionViewCell, NibCapable {

    // MARK: - Properties
     let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        image.layer.borderWidth = 3
        image.layer.borderColor = .borderColorBlue.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
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

    // MARK: - Public Method

    func configure(with model: Mod) {
        if let imageq: UIImage = .getImageFromFile(fileName: "/Mods/\(model.rd1Lf2 ?? "" )") {
            imageView.image = imageq
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .backgroundWhite

        addSubview(imageView)
//        addSubview(nameLabel)
//        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }
}

