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
    
    var frameView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "frame")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

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
        addSubview(frameView)
        addSubview(collectionViewContainer)
        
        
        navigationButtons.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        frameView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),
            
            navigationButtons.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navigationButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            navigationButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            navigationButtons.heightAnchor.constraint(equalToConstant: 100),
  
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 500),
            collectionViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            frameView.bottomAnchor.constraint(equalTo: bottomAnchor),
            frameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            frameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            frameView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
}

