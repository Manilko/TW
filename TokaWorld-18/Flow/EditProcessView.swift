//
//  EditProcessView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class EditProcessView: UIView {
   
    // MARK: - Properties
    var navView = NavigationView(leftButtonType: .left, title: "Editor", rightButtonType: ImageNameNawMenuType.filter)
    
    let collectionViewContainer: CollectionViewContainer

    // MARK: - Lifecycle
    init(obj: HeroSet) {
        collectionViewContainer = CollectionViewContainer(obj: obj)
        super.init(frame: .zero)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    private func configureLayout() {
        addSubview(navView)
        addSubview(collectionViewContainer)
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),
            
            collectionViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            collectionViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

