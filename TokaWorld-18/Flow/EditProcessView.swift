//
//  EditProcessView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class EditProcessView: UIView {
   
    // MARK: - Properties
    var navView = NavigationView(leftButtonType: .leftArrow, title: "", rightButtonType: ImageNameNawMenuType.loading)
    
    let collectionViewContainer: CollectionViewContainer
    let navigationButtons: NavigationButtons = NavigationButtons()

    // MARK: - Lifecycle
    init(startSet: HeroSet) {
        collectionViewContainer = CollectionViewContainer(startSet: startSet)
        super.init(frame: .zero)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(navView)
        navView.addSubview(navigationButtons)
        addSubview(collectionViewContainer)
        
        navigationButtons.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),
            
            navigationButtons.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navigationButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            navigationButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            navigationButtons.heightAnchor.constraint(equalToConstant: 100),
  
            collectionViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            collectionViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

