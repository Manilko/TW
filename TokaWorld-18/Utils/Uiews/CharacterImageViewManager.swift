//
//  CharacterImageViewManager.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 22.11.2023.
//

import UIKit


class CharacterImageViewManager {
    
    
    
}


class CharacterImageView: UIView {

//    var characterModel: CharacterModel

    let characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }

//    func updateSelectedCategory(with number: Int) {
//        self.number = number
//    }

    private func setupUI() {
        
//        let propertyValues = characterModel.propertyValues()

//        for (propertyName, propertyValue) in propertyValues {
//            print("\(propertyName): \(propertyValue)")
//        }
//        
//        for (propertyName, propertyValue) in propertyValues {
//            let imageView = UIImageView()
//            imageView.contentMode = .scaleAspectFit
//            imageView.clipsToBounds = true
//            imageView.translatesAutoresizingMaskIntoConstraints = false
////            imageView.tag = i
//            addSubview(imageView)
//            print(propertyValue)
//            imageView.image = UIImage(named: "\(propertyValue)")
//        }
        addSubview(characterView)

        NSLayoutConstraint.activate([
            characterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterView.widthAnchor.constraint(equalTo: widthAnchor),
            characterView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
