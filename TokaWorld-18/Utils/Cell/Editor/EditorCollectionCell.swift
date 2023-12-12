//
//  EditorCollectionCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class EditorCollectionCell: UICollectionViewCell, NibCapable {
    
    // MARK: - Properties
    
    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1).cgColor
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(red: 0.338, green: 0.487, blue: 1, alpha: 1).cgColor
        return view
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil  // Reset other UI elements as needed
    }
    
    // MARK: - Public Method
    
    func configure(setHeroBodyPart: HeroSet) {
        guard let image = setHeroBodyPart.iconImage else { return }
//        imageView.image.
        imageView.image = UIImage(data: image)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(characterView)
        
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterView.heightAnchor.constraint(equalToConstant: 210),
        ])
        
        characterView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: characterView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: characterView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: characterView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: characterView.bottomAnchor),
        ])
        
        // Add any additional customization or subviews here
    }
}
