//
//  GuideDetailView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

final class GuideDetailView: UIView {

    // MARK: - Properties
    var navView: NavigationView

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var detailModsView: DetailGuideView = {
        let view = DetailGuideView()
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 2
        view.layer.borderColor = .borderColorWhite.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lettersBlack
        label.font = .customFont(type: .lilitaOne, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.87
        label.attributedText = NSMutableAttributedString(string: "Recommended", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    lazy var recommendedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundWhite
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
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
        button.setTitle("Download File", for: .normal)
        return button
    }()

    // MARK: - Lifecycle
    init(isFavorite: Bool) {
        let rightButtonType: ImageNameNawMenuType = isFavorite ? .favorite : .unFavorite
        navView = NavigationView(leftButtonType: .leftArrow, title: "Guide", rightButtonType: rightButtonType)

        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        backgroundColor = UIColor.backgroundWhite
        addSubview(navView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(recommendedCollectionView)
        contentView.addSubview(detailModsView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(titleLabel)

        navView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),

            scrollView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            detailModsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            detailModsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leading),
            detailModsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Sizes.trailing),

            downloadButton.topAnchor.constraint(equalTo: detailModsView.bottomAnchor, constant: UIDevice.current.isIPad ?  20 : 12),
            downloadButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leading),
            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Sizes.trailing),
            downloadButton.heightAnchor.constraint(equalToConstant: 52),

            titleLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: UIDevice.current.isIPad ?  40 : 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leading),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            recommendedCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            recommendedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leading),
            recommendedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Sizes.trailing),
            recommendedCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            recommendedCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.width / 3)
        ])
    }
}

