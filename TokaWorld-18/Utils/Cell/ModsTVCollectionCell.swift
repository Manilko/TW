//
//  ModsTVCollectionCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.12.2023.
//

import UIKit
import RealmSwift
import Realm

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

    let favoriteButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
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
    
    // MARK: - Initialization
    override func prepareForReuse() {
        image.image = nil
        favoriteButton.isHidden = false
        titleLabel.text = ""
        descriptionLabel.text = ""
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
    
    private func setupButton(_ button: RoundButton, withImageName: ImageNameNawMenuType) {
        if withImageName == .none {
            button.isHidden = true
        } else{
            button.setImageA(UIImage.image(name: withImageName.rawValue))
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        
        image.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(loadingIndicator)
        
        addSubview(mainView)
        mainView.addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favoriteButton)
        
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
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -4),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            descriptionLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -4),
            
            favoriteButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    var configureModel: Mod = Mod()
    
    func configure(with model: Mod) {
        configureModel = model
        loadingIndicator.startAnimating()
        
        let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
        setupButton(favoriteButton, withImageName: imageType)
        
        downloadImage(type: model, nameDirectory: .mods, fileName: "Mods")
        
        titleLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
    }
    
    var configureFurnitureModel: FurnitureElement = FurnitureElement()
    
    func configure(with model: FurnitureElement) {
        configureFurnitureModel = model
        loadingIndicator.startAnimating()
        
        let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
        setupButton(favoriteButton, withImageName: imageType)
        
        downloadImage(type: model, nameDirectory: .furniture, fileName: "Furniture")
        
        titleLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
    }
    
    func downloadImage<T: Object & Codable & MenuTypeNameble>(type: T, nameDirectory: JsonPathType, fileName: String) {
        let _ = DownloadManager(element: type).downloadData(nameDirectory: nameDirectory) { [weak self] in
            self?.loadingIndicator.stopAnimating()
            if let imageq: UIImage = .getImageFromFile(fileName: "/\(fileName)/\(type.rd1Lf2 ?? "" )") {
                self?.image.image = imageq
            }
        }
    }
    
    // Target Action
    @objc private func favoriteButtonTapped() {
        let model = configureModel
        RealmManager.shared.runTransaction {
            if model.favorites {
                model.favorites = false
                updateFavoriteButton(false)
            } else {
                model.favorites = true
                updateFavoriteButton(true)
            }
        }
    }
    func updateFavoriteButton(_ button: Bool) {
        let imageType: ImageNameNawMenuType = button ? .favorite : .unFavorite
        favoriteButton.setImageA(UIImage.image(name: imageType.rawValue))
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


class WallpaperCell: UICollectionViewCell, NibCapable {
    
    // MARK: - Properties

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderColor = .borderColorBlue.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.unFavorite.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
    return indicator
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
        imageView.image = nil
        loadingIndicator.stopAnimating()
    }
    
    @objc func optionTapped() {
        optionTappedCallback?()
    }
    
    // MARK: - Public Method
    
    func configure(with model: Wallpaper) {
        loadingIndicator.startAnimating()
        let _ = DownloadManager<Wallpaper>(element: model).downloadData(nameDirectory: .wallpapers) { [weak self] in
            self?.loadingIndicator.stopAnimating()
            if let imageq: UIImage = .getImageFromFile(fileName: "/Wallpapers/\(model.rd1Lf2 ?? "" )") {
                self?.imageView.image = imageq
            }
        }
        
        let imageType: ImageNameNawMenuType = model.favorites ? .favorite : .unFavorite
        favoriteImage.image = UIImage(named: imageType.rawValue)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {

        addSubview(imageView)
        addSubview(favoriteImage)
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            
            loadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            favoriteImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            favoriteImage.widthAnchor.constraint(equalToConstant: 32),
            favoriteImage.heightAnchor.constraint(equalToConstant: 32),

        ])
    }
}
