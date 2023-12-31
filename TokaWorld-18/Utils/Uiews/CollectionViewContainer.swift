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
    
    // MARK: - ______
    
    let firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let secondCollectionView: UICollectionView = {
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
//            print("countSecondCVCell =  \(countSecondCVCell)")
            DispatchQueue.main.async {
                self.secondCollectionView.reloadData()
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
        addSubview(firstCollectionView)
        addSubview(secondCollectionView)
        
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: topAnchor),
            characterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            characterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            characterView.heightAnchor.constraint(equalToConstant: 350),
            
            firstCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 350),
            firstCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            secondCollectionView.topAnchor.constraint(equalTo: firstCollectionView.bottomAnchor),
            secondCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
}
