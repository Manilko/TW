//
//  EditirView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class EditirView: UIView {

    let navView = NavigationView(leftButtonType: .menu, title: "Editor", rightButtonType: ImageNameNawMenuType.none)

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(EditorCollectionCell.self, forCellWithReuseIdentifier: EditorCollectionCell.identifier)
        return collectionView
    }()

    required init() {
        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(navView)
        addSubview(collectionView)
        backgroundColor = .backgroundBlue
        navView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),

            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}
