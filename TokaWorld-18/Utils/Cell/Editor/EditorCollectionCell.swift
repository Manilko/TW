//
//  EditorCollectionCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

//class EditorCollectionCell: UICollectionViewCell, NibCapable {
//    
//    // MARK: - Properties
//    
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    // MARK: - Initialization
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//    
//    // MARK: - Public Method
//    
//    func configure(with image: UIImage?) {
//        imageView.image = image
//    }
//    
//    // MARK: - Private Methods
//    
//    private func setupUI() {
//        addSubview(imageView)
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        // Image View
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//    }
//}








class EditorCollectionCell: UICollectionViewCell, NibCapable {
    
    // MARK: - Properties
    
    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
    
    // MARK: - Public Method
    
    func configure(setHeroBodyPart: HeroSet) {
        
        for bodyPart in setHeroBodyPart {
            
            let imageView = UIImageView()
            var fileName: String?
//            print("       >>>>>>>>>>    bodyPart.valueValue   \( bodyPart.valueValue)")
            fileName = bodyPart.valueValue
            
            if let fileName {
                imageView.image = getImageFromFile(with: fileName)
            }
            
            imageView.contentMode = .scaleAspectFit
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
    
    func getImageFromFile(with fileName: String) -> UIImage {
        var image = UIImage()
        
//        for local Image
        if let localImage = UIImage(named: fileName){
            image = localImage
        } else{
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(fileName)

                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        let fileData = try Data(contentsOf: fileURL)

                        if let im = transformPdfToImage(data: fileData) {
                            image = im
                        }
                    } catch {
                        print("Failed to read data from file: \(error)")
                    }
                }
            }
        }
        
        return image
    }

    
    func transformPdfToImage(data: Data) -> UIImage? {
        guard let provider = CGDataProvider(data: data as CFData),
              let pdfDoc = CGPDFDocument(provider),
              let pdfPage = pdfDoc.page(at: 1)
        else {
            return nil
        }

        let imageSize = CGSize(width: 1000, height: 1000)

        UIGraphicsBeginImageContext(imageSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.setFillColor(UIColor.clear.cgColor)
        context.fill(CGRect(origin: .zero, size: imageSize))

        context.translateBy(x: 0, y: imageSize.height)
        context.scaleBy(x: 1, y: -1)

        let pdfRect = pdfPage.getBoxRect(.mediaBox)

        let scale = min(imageSize.width / pdfRect.width, imageSize.height / pdfRect.height)
        context.scaleBy(x: scale, y: scale)

        context.drawPDFPage(pdfPage)

        let pdfImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return pdfImage
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(characterView)
        setupConstraints()
        
        
    }
    
    private func setupConstraints() {
        // Image View
        NSLayoutConstraint.activate([
            
            characterView.topAnchor.constraint(equalTo: topAnchor),
            characterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            characterView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
    }

}


