//
//  ModsTVCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 12.11.2023.
//

import UIKit

final class ModsTVCell: UITableViewCell, NibCapable {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .loadingBlue
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
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
        label.font = .customFont(type: .bolt, size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .bolt, size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()

    override func prepareForReuse() {
        image.image = nil
        favoriteImage.isHidden = false
    }

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear

        image.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainView)
        mainView.addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favoriteImage)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
//            image.heightAnchor.constraint(equalToConstant: 120),
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

        selectionStyle = .none
    }

    func configure(with model: Mod) {
//        let im = getImageFromFile(fileName: "/Mods/\(model.rd1Lf2 ?? "")")
//        image.image = im
        
        if let imageq = getImageFromFile(fileName: "/Mods/\(model.rd1Lf2 ?? "" )") {
            image.image = imageq
            print(" ✅ Loaded image from file.")
        }
//        let im = getImageFromFile(with: "/Mods/\(model.rd1Lf2 ?? ""))")
//        print(im)
//        image.image = im
        titleLabel.text = model.rd1Ld4
        descriptionLabel.text = model.rd1Li1
        favoriteImage.isHidden = false
    }

    func updateDescriptionText(isFullDescription: Bool) {
        // descriptionLabel.numberOfLines = 0
    }

    func updateFavoriteImage(isFavorite: Bool = false) {
        // favoriteImage.isHidden = !isFavorite
    }
    
    func getImageFromFile(fileName: String) -> UIImage? {
        let fileManager = FileManager.default
        
        var fixedFileName = fileName
        if fixedFileName == "/Mods/7.jpeg"{   // mistake in json
            fixedFileName = "/Mods/7.png"
        }
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(fixedFileName)

            // Check if the file exists
            guard fileManager.fileExists(atPath: fileURL.path) else {
                print(" ⚠️ File not found at: \(fileURL)")
                return nil
            }

            // Attempt to load the image from the file
            if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
                return image
            } else {
                print(" ⛔ Error loading image from file.")
            }
        } else {
            print("🚫 Document directory not found.")
        }

        return nil
    }




    
//    func transformPdfToImage(data: Data) -> UIImage? {
//        guard let provider = CGDataProvider(data: data as CFData),
//              let pdfDoc = CGPDFDocument(provider),
//              let pdfPage = pdfDoc.page(at: 1)
//        else {
//            return nil
//        }
//
//        let imageSize = CGSize(width: 1000, height: 1000)
//
//        UIGraphicsBeginImageContext(imageSize)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//
//        context.setFillColor(UIColor.clear.cgColor)
//        context.fill(CGRect(origin: .zero, size: imageSize))
//
//        context.translateBy(x: 0, y: imageSize.height)
//        context.scaleBy(x: 1, y: -1)
//
//        let pdfRect = pdfPage.getBoxRect(.mediaBox)
//
//        let scale = min(imageSize.width / pdfRect.width, imageSize.height / pdfRect.height)
//        context.scaleBy(x: scale, y: scale)
//
//        context.drawPDFPage(pdfPage)
//
//        let pdfImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//        return pdfImage
//    }
}
