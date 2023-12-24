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
        backgroundColor = .backgroundBlue
        addSubview(navView)
        navView.addSubview(navigationButtons)
        addSubview(frameView)
        addSubview(characterView)
        addSubview(collectionViewContainer)
        
        
        navigationButtons.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        frameView.translatesAutoresizingMaskIntoConstraints = false

//        characterView.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),
            
            navigationButtons.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navigationButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            navigationButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            navigationButtons.heightAnchor.constraint(equalToConstant: 100),
            
            characterView.bottomAnchor.constraint(equalTo: frameView.topAnchor, constant: 40),
            characterView.widthAnchor.constraint(equalToConstant:  335),
            characterView.heightAnchor.constraint(equalToConstant: 418),
            characterView.centerXAnchor.constraint(equalTo: centerXAnchor),
  
            collectionViewContainer.heightAnchor.constraint(equalToConstant: Sizes.editorCollectionViewHeight),
            collectionViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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

