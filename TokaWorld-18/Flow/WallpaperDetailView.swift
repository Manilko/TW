//
//  WallpaperDetailView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

final class WallpaperDetailView: UIView {

    // MARK: - Properties
    var navView: NavigationView

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .mainBlue
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = .borderColorBlue.cgColor
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.mainBlue
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 2
        button.layer.borderColor = .borderColorWhite.cgColor
        button.titleLabel?.font = .customFont(type: .lilitaOne, size: 24)
        button.titleLabel?.textColor = .lettersWhite
        button.setTitle("Download", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    init(isFavorite: Bool) {
        let rightButtonType: ImageNameNawMenuType = isFavorite ? .favorite : .unFavorite
        navView = NavigationView(leftButtonType: .leftArrow, title: "Wallpaper", rightButtonType: rightButtonType)

        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Wallpaper) {
        imageView.image = .getImageFromFile(fileName: "/Wallpapers/\(model.rd1Lf2 ?? "" )")
    }

    private func configureLayout() {
        backgroundColor = UIColor.backgroundWhite
        addSubview(navView)
        addSubview(imageView)
        addSubview(downloadButton)

        navView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),

            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 140),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),

            downloadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIDevice.current.isIPad ?  20 : 12),
            downloadButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            downloadButton.heightAnchor.constraint(equalToConstant: 52),

        ])
    }
}

