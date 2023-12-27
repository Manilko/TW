//
//  ModsTVCollectionCell.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 17.12.2023.
//

import UIKit

final class ModsTVCollectionCell: UICollectionViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorWhite.cgColor
        view.layer.cornerRadius = 40
        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .sfMedium, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .gray)
            indicator.hidesWhenStopped = true
        return indicator
        }()
    
    override func prepareForReuse() {
        image.image = nil
        favoriteImage.isHidden = false
        titleLabel.text = ""
        descriptionLabel.text = ""
        favoriteImage.image = nil
        loadingIndicator.stopAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        return nil
    }
    
    private func setup() {
        backgroundColor = .clear
        
        image.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(loadingIndicator)
        
        addSubview(mainView)
        mainView.addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favoriteImage)
        
        NSLayoutConstraint.activate([
            
            loadingIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            descriptionLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
            
            favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            favoriteImage.widthAnchor.constraint(equalToConstant: 32),
            favoriteImage.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func configure(with model: Mod) {
        loadingIndicator.startAnimating()
        let _ = DownloadManager<Mod>(element: model).downloadData(nameDirectory: .mods) { [weak self] in
            self?.loadingIndicator.stopAnimating()
            if let imageq: UIImage = .getImageFromFile(fileName: "/Mods/\(model.rd1Lf2 ?? "" )") {
                self?.image.image = imageq
            }
        }
        
        titleLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
        
        let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
        favoriteImage.image = UIImage(named: imageType.rawValue)
    }
    
    func updateDescriptionText(isFullDescription: Bool) {
        // descriptionLabel.numberOfLines = 0
    }
    
    func updateFavoriteImage(isFavorite: Bool = false) {
        // favoriteImage.isHidden = !isFavorite
    }
}



final class FurnitureElementCell: UICollectionViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorWhite.cgColor
        view.layer.cornerRadius = 40
        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .sfMedium, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
    return indicator
    }()

override func prepareForReuse() {
    image.image = nil
    favoriteImage.isHidden = false
    titleLabel.text = ""
    descriptionLabel.text = ""
    favoriteImage.image = nil
    loadingIndicator.stopAnimating()
}

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    return nil
}

private func setup() {
    backgroundColor = .clear
    
    image.translatesAutoresizingMaskIntoConstraints = false
    mainView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteImage.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    image.addSubview(loadingIndicator)
    
    addSubview(mainView)
    mainView.addSubview(image)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(favoriteImage)
    
    NSLayoutConstraint.activate([
        
        loadingIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
        loadingIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
        
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
        image.widthAnchor.constraint(equalTo: image.heightAnchor),
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        descriptionLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
        favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        favoriteImage.widthAnchor.constraint(equalToConstant: 32),
        favoriteImage.heightAnchor.constraint(equalToConstant: 32),
    ])
}

func configure(with model: FurnitureElement) {
    loadingIndicator.startAnimating()
    let _ = DownloadManager<FurnitureElement>(element: model).downloadData(nameDirectory: .furniture) { [weak self] in
        self?.loadingIndicator.stopAnimating()
        if let imageq: UIImage = .getImageFromFile(fileName: "/Furniture/\(model.rd1Lf2 ?? "" )") {
            self?.image.image = imageq
        }
    }
    
    titleLabel.text = model.rd1Ld4
    descriptionLabel.text = model.rd1Li1
    
    let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
    favoriteImage.image = UIImage(named: imageType.rawValue)
}

func updateDescriptionText(isFullDescription: Bool) {
    // descriptionLabel.numberOfLines = 0
}

func updateFavoriteImage(isFavorite: Bool = false) {
    // favoriteImage.isHidden = !isFavorite
}
}

final class RecipeCell: UICollectionViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorWhite.cgColor
        view.layer.cornerRadius = 40
        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .sfMedium, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
    return indicator
    }()

override func prepareForReuse() {
    image.image = nil
    favoriteImage.isHidden = false
    titleLabel.text = ""
    descriptionLabel.text = ""
    favoriteImage.image = nil
    loadingIndicator.stopAnimating()
}

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    return nil
}

private func setup() {
    backgroundColor = .clear
    
    image.translatesAutoresizingMaskIntoConstraints = false
    mainView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteImage.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    image.addSubview(loadingIndicator)
    
    addSubview(mainView)
    mainView.addSubview(image)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(favoriteImage)
    
    NSLayoutConstraint.activate([
        
        loadingIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
        loadingIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
        
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
        image.widthAnchor.constraint(equalTo: image.heightAnchor),
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        descriptionLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
        favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        favoriteImage.widthAnchor.constraint(equalToConstant: 32),
        favoriteImage.heightAnchor.constraint(equalToConstant: 32),
    ])
}

func configure(with model: Recipe) {
    loadingIndicator.startAnimating()
    let _ = DownloadManager<Recipe>(element: model).downloadData(nameDirectory: .recipes) { [weak self] in
        self?.loadingIndicator.stopAnimating()
        if let imageq: UIImage = .getImageFromFile(fileName: "/Recipes/\(model.rd1Lf2 ?? "" )") {
            self?.image.image = imageq
        }
    }
    
    titleLabel.text = model.rd1Ld4
    descriptionLabel.text = model.rd1Li1
    
    let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
    favoriteImage.image = UIImage(named: imageType.rawValue)
}

func updateDescriptionText(isFullDescription: Bool) {
    // descriptionLabel.numberOfLines = 0
}

func updateFavoriteImage(isFavorite: Bool = false) {
    // favoriteImage.isHidden = !isFavorite
}
}


final class GuideCell: UICollectionViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorWhite.cgColor
        view.layer.cornerRadius = 40
        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .sfMedium, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
    return indicator
    }()

override func prepareForReuse() {
    image.image = nil
    favoriteImage.isHidden = false
    titleLabel.text = ""
    descriptionLabel.text = ""
    favoriteImage.image = nil
    loadingIndicator.stopAnimating()
}

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    return nil
}

private func setup() {
    backgroundColor = .clear
    
    image.translatesAutoresizingMaskIntoConstraints = false
    mainView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteImage.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    image.addSubview(loadingIndicator)
    
    addSubview(mainView)
    mainView.addSubview(image)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(favoriteImage)
    
    NSLayoutConstraint.activate([
        
        loadingIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
        loadingIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
        
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
        image.widthAnchor.constraint(equalTo: image.heightAnchor),
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        descriptionLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
        favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        favoriteImage.widthAnchor.constraint(equalToConstant: 32),
        favoriteImage.heightAnchor.constraint(equalToConstant: 32),
    ])
}

func configure(with model: Guide) {
    loadingIndicator.startAnimating()
    let _ = DownloadManager<Guide>(element: model).downloadData(nameDirectory: .guides) { [weak self] in
        self?.loadingIndicator.stopAnimating()
        if let imageq: UIImage = .getImageFromFile(fileName: "/Guides/\(model.rd1Lf2 ?? "" )") {
            self?.image.image = imageq
        }
    }
    
    titleLabel.text = model.rd1Ld4
    descriptionLabel.text = model.rd1Li1
    
    let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
    favoriteImage.image = UIImage(named: imageType.rawValue)
}

func updateDescriptionText(isFullDescription: Bool) {
    // descriptionLabel.numberOfLines = 0
}

func updateFavoriteImage(isFavorite: Bool = false) {
    // favoriteImage.isHidden = !isFavorite
}
}


final class HouseIdeaCell: UICollectionViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = .borderColorWhite.cgColor
        view.layer.cornerRadius = 40
        // Apply shadow to mainView
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .sfMedium, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
    return indicator
    }()

override func prepareForReuse() {
    image.image = nil
    favoriteImage.isHidden = false
    titleLabel.text = ""
    descriptionLabel.text = ""
    favoriteImage.image = nil
    loadingIndicator.stopAnimating()
}

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    return nil
}

private func setup() {
    backgroundColor = .clear
    
    image.translatesAutoresizingMaskIntoConstraints = false
    mainView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteImage.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    image.addSubview(loadingIndicator)
    
    addSubview(mainView)
    mainView.addSubview(image)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(favoriteImage)
    
    NSLayoutConstraint.activate([
        
        loadingIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
        loadingIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
        
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
        image.widthAnchor.constraint(equalTo: image.heightAnchor),
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
        descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        descriptionLabel.trailingAnchor.constraint(equalTo: favoriteImage.leadingAnchor, constant: -4),
        
        favoriteImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
        favoriteImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        favoriteImage.widthAnchor.constraint(equalToConstant: 32),
        favoriteImage.heightAnchor.constraint(equalToConstant: 32),
    ])
}

func configure(with model: HouseIdea) {
    loadingIndicator.startAnimating()
    let _ = DownloadManager<HouseIdea>(element: model).downloadData(nameDirectory: .house) { [weak self] in
        self?.loadingIndicator.stopAnimating()
        if let imageq: UIImage = .getImageFromFile(fileName: "/House_Ideas/\(model.rd1Lf2 ?? "" )") {
            self?.image.image = imageq
        }
    }
    
    titleLabel.text = model.rd1Ld4
    descriptionLabel.text = model.rd1Li1
    
    let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
    favoriteImage.image = UIImage(named: imageType.rawValue)
}

func updateDescriptionText(isFullDescription: Bool) {
    // descriptionLabel.numberOfLines = 0
}

func updateFavoriteImage(isFavorite: Bool = false) {
    // favoriteImage.isHidden = !isFavorite
}
}
