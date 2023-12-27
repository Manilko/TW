//
//  FurnitureDetailView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.12.2023.
//

import UIKit

final class FurnitureDetailView: UIView {

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

    lazy var detailFurnitureView: DetailFurnitureView = {
        let view = DetailFurnitureView()
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

    // MARK: - Lifecycle
    init(isFavorite: Bool) {
        let rightButtonType: ImageNameNawMenuType = isFavorite ? .favorite : .unFavorite
        navView = NavigationView(leftButtonType: .leftArrow, title: "Furniture", rightButtonType: rightButtonType)

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
        contentView.addSubview(detailFurnitureView)
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

            detailFurnitureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            detailFurnitureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leading),
            detailFurnitureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Sizes.trailing),

            titleLabel.topAnchor.constraint(equalTo: detailFurnitureView.bottomAnchor, constant: UIDevice.current.isIPad ?  40 : 24),
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

