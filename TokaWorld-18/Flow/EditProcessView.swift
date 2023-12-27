//
//  EditProcessView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit
import RealmSwift
import Realm

final class EditProcessView: UIView {
   
    // MARK: - Properties
    var navView = NavigationView(leftButtonType: .leftArrow, title: "", rightButtonType: ImageNameNawMenuType.loading)
    
    let collectionViewContainer: CollectionViewContainer
    let navigationButtons: NavigationButtons = NavigationButtons()
    
    var startSetQ: HeroSet = HeroSet()
    
    var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var frameView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "frame")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    // MARK: - Lifecycle
    init(startSet: HeroSet) {
        collectionViewContainer = CollectionViewContainer()
        var bodyParts: List<BodyPart> = List<BodyPart>()
        
        for i in startSet.bodyParts{
            var bodyPart: BodyPart = BodyPart(value: i)
            bodyParts.append(bodyPart)
        }

        startSetQ = HeroSet()
        startSetQ.id = startSet.id
        startSetQ.bodyParts.append(objectsIn: bodyParts)
        startSetQ.gender = startSet.gender
        super.init(frame: .zero)

        configureLayout()
    }
    
    func configure(startSet: HeroSet) {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(backgroundView)
        backgroundColor = .backgroundBlue
        addSubview(frameView)
        addSubview(characterView)
        addSubview(navView)
        navView.addSubview(navigationButtons)
        addSubview(collectionViewContainer)
        
        
        navigationButtons.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        frameView.translatesAutoresizingMaskIntoConstraints = false

//        characterView.backgroundColor = .gray
        
        let screenWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),
            
            navigationButtons.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navigationButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            navigationButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            navigationButtons.heightAnchor.constraint(equalToConstant: 100),
  
            collectionViewContainer.heightAnchor.constraint(equalToConstant: Sizes.editorCollectionViewHeight),
            collectionViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            characterView.bottomAnchor.constraint(equalTo: collectionViewContainer.topAnchor, constant: -40),
            characterView.widthAnchor.constraint(equalToConstant: screenWidth * 1.1),
            characterView.heightAnchor.constraint(equalToConstant: (screenWidth * 1.1) * 1.25),
            characterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            frameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.editorFrameBottom),
            frameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.editorFrameSideIndents),
            frameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.editorFrameSideIndents),
            frameView.heightAnchor.constraint(equalToConstant: Sizes.editorFrameHeight),
        ])
        
        setupBodyParts(set: startSetQ)
    }
    
    private func setupBodyParts(set: HeroSet) {

        for bodyPart in set {
            let imageView = UIImageView()
            var fileName = ""

            if bodyPart.valueValue != nil {
                fileName = bodyPart.valueValue ?? ""
            }
            
            imageView.image = ImageSeries.getImageFromFile(with: fileName)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            characterView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: characterView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: characterView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: characterView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: characterView.bottomAnchor),
            ])
        }
    }
}

