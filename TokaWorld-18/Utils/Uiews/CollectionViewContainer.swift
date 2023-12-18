//
//  CollectionViewContainer.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 02.12.2023.
//

import UIKit
import RealmSwift
import Realm


class CollectionViewContainer: UIView {
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let elementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var index = 0
    var countSecondCVCell: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.elementCollectionView.reloadData()
            }
        }
    }
    
    var oneStep: HeroSet = HeroSet() {
        didSet {
            self.storyHeroChanges.item.append(oneStep)
        }
    }
    
    var startSetQ: HeroSet = HeroSet()
    
    var storyHeroChanges: StoryCharacterChanges = StoryCharacterChanges()
    var startToDel: HeroSet
    
    // MARK: - Life Cycle
    init(startSet: HeroSet) {

        startToDel = startSet
        super.init(frame: .zero)

        var bodyParts: List<BodyPart> = List<BodyPart>()
        
        for i in startSet.bodyParts{
            var bodyPart: BodyPart = BodyPart(value: i)
            bodyParts.append(bodyPart)
        }

        startSetQ = HeroSet()
        startSetQ.id = startSet.id
        startSetQ.bodyParts.append(objectsIn: bodyParts)
        startSetQ.gender = startSet.gender
        
        self.countSecondCVCell = startSet.bodyParts.first?.item.count ?? 0
        
        setupViews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - func
    
    private func setupViews() {
        addSubview(characterView)
        addSubview(categoryCollectionView)
        addSubview(elementCollectionView)
        
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: topAnchor),
            characterView.widthAnchor.constraint(equalToConstant:  400),// UIDevice.current.isIPad ? 356 : 228),
            characterView.heightAnchor.constraint(equalToConstant: 500),//UIDevice.current.isIPad ? 650 : 356),
            characterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Sizes.leading),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            categoryCollectionView.bottomAnchor.constraint(equalTo: elementCollectionView.topAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant:90),
            
            elementCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Sizes.leading),
            elementCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            elementCollectionView.heightAnchor.constraint(equalToConstant: 90),
            elementCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        setupExistingBodyParts()
        
    }
    
       private func setupExistingBodyParts() {

           for bodyPart in startSetQ {
               let imageView = UIImageView()
               var fileName = ""

               if bodyPart.valueValue != nil {
                   fileName = bodyPart.valueValue ?? ""
               }
               
               imageView.image = getImageFromFile(with: fileName)
               imageView.contentMode = .scaleToFill
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


// MARK: - getImageFromFile

extension CollectionViewContainer{
    
    func getImageFromFile(with fileName: String) -> UIImage {
        var image = UIImage()
        
        if let localImage = UIImage(named: fileName) {
            // for local Image
            image = localImage
        } else {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        let fileData = try Data(contentsOf: fileURL)
                        
                        if let im = pdfToImage(data: fileData) {
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
    
    func pdfToImage(data: Data?) -> UIImage? {
        guard let data,
           let provider = CGDataProvider(data: data as CFData),
           let pdfDoc  = CGPDFDocument(provider),
           let pdfPage = pdfDoc.page(at: 1)
        else {
          return nil
        }
        let rectWidth = UIScreen.main.bounds.width
        let pageRect = pdfPage.getBoxRect(.mediaBox)
        let proportion: CGFloat = pageRect.height / pageRect.width
        let proportionRect = CGRect(x: 0, y: 0, width: rectWidth, height: rectWidth * proportion)
        let renderer = UIGraphicsImageRenderer(size: proportionRect.size)
        let scale : CGFloat = proportionRect.width / pageRect.width
        let img = renderer.image { ctx in
          UIColor.white.withAlphaComponent(0).set()
          ctx.cgContext.translateBy(x: 0.0, y: proportionRect.height)
          ctx.cgContext.scaleBy(x: scale, y: -scale)
          ctx.cgContext.drawPDFPage(pdfPage)
        }
        if let pngData = img.pngData() {
          print("Converted PDF to PNG and cached for path")
          return UIImage(data: pngData)
        }
        return img
      }

}
