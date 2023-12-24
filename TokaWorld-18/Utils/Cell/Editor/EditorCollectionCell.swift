//
//  EditorCollectionCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class EditorCollectionCell: UICollectionViewCell, NibCapable {
    
    // MARK: - Properties

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let plusImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Component 17")
        return view
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorBlue.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let optionButton: UIButton = {
        let image = UIButton()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        let icon = UIImage(named: ImageNameNawMenuType.option.rawValue)
        image.addTarget(self, action: #selector(optionTapped), for: .touchUpInside)
        image.setImage(icon, for: .normal)
        return image
    }()
    
    var optionTappedCallback: (() -> Void)?
    
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
    
    @objc func optionTapped() {
        optionTappedCallback?()
    }
    
    // MARK: - Public Method
    
    func configure(setHeroBodyPart: HeroSet, type: Int) {
//        guard let image = setHeroBodyPart.iconImage else { return }
        let data = setHeroBodyPart.iconImage
        imageView.image = UIImage(data: data ?? Data())
        
        optionButton.isHidden = type == 0
        imageView.isHidden = type == 0
        plusImageView.isHidden = type != 0
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {

        addSubview(borderView)
        addSubview(imageView)
        addSubview(optionButton)
        addSubview(plusImageView)
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -15),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            optionButton.topAnchor.constraint(equalTo: topAnchor),
            optionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionButton.widthAnchor.constraint(equalToConstant: 32),
            optionButton.heightAnchor.constraint(equalToConstant: 32),
            
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 88),
            plusImageView.heightAnchor.constraint(equalToConstant: 88),
        ])
    }
}
