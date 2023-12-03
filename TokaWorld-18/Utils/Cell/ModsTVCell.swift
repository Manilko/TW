//
//  ModsTVCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 12.11.2023.
//

import UIKit

final class ModsTVCell: UITableViewCell, NibCapable {

    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 30

        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)

        return view
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        // image.set(cornerRadius: 12)
        return image
    }()

    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        // image.set(cornerRadius: 12)
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        // label.font = .customFont(type: .bold, size: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        // label.font = .customFont(type: .semiBold, size: 14)
        label.textColor = .black
        label.numberOfLines = 4
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()

    override func prepareForReuse() {
        image.image = nil
        favoriteImage.isHidden = false
    }

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .yellow

        image.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainView)
        mainView.addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favoriteImage)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            image.widthAnchor.constraint(equalToConstant: 120),

            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 120),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),

            favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            // favoriteImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            favoriteImage.widthAnchor.constraint(equalToConstant: 40),
            favoriteImage.heightAnchor.constraint(equalToConstant: 40),
        ])

        selectionStyle = .none
    }

    func configure(with model: Mod) {
        image.image = UIImage(named: "model.icon")
        titleLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
        favoriteImage.isHidden = false
    }

    func updateDescriptionText(isFullDescription: Bool) {
        // descriptionLabel.numberOfLines = 0
    }

    func updateFavoriteImage(isFavorite: Bool = false) {
        // favoriteImage.isHidden = !isFavorite
    }
}
