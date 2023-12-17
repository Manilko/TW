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
        view.backgroundColor = .backgroundWhite
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
        guard let image = setHeroBodyPart.iconImage else { return }
        imageView.image = UIImage(data: image)
        
        if type == 0{
            optionButton.isHidden = true
        } else{
            optionButton.isHidden = false
        }
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {

        addSubview(imageView)
        addSubview(optionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            optionButton.topAnchor.constraint(equalTo: topAnchor),
            optionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionButton.widthAnchor.constraint(equalToConstant: 32),
            optionButton.heightAnchor.constraint(equalToConstant: 32),
        ])
        
    }
}
