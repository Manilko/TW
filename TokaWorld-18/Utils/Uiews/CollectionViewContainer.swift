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
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save to Realm", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(EditorCategoryCell.self, forCellWithReuseIdentifier: EditorCategoryCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(EditorCategoryItemCell.self, forCellWithReuseIdentifier: EditorCategoryItemCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
            print("countSecondCVCell =  \(countSecondCVCell)")
            DispatchQueue.main.async {
                self.secondCollectionView.reloadData()
            }
        }
    }
    
    var oneStep: HeroSet = HeroSet() {
        didSet {
            print("              oneStep      \(oneStep)")
            self.storyHeroChanges.item.append(oneStep)
        }
    }
    
    var startSetQ: HeroSet = HeroSet()
    
    var storyHeroChanges: StoryCharacterChanges = StoryCharacterChanges()
    
    // MARK: - Life Cycle
    init(startSet: HeroSet) {

        super.init(frame: .zero)

        var bodyParts: List<BodyPart> = List<BodyPart>()
        
        for i in startSet.bodyParts{
            var bodyPart: BodyPart = BodyPart(value: i)
            bodyParts.append(bodyPart)
        }
        
        
        
        startSetQ = HeroSet()

        startSetQ.bodyParts.append(objectsIn: bodyParts)
        startSetQ.gender = startSet.gender
        
        self.countSecondCVCell = startSet.bodyParts.first?.item.count ?? 0
        
        
        
        
//        print("   init    startSet.gender =  \(startSet.gender)")
        setupViews()

//        print("                             startSet      \(startSet)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    @objc private func saveToRealm() {
        //  save to realm storyHeroChanges.item.last
        let image = createImageFromLayers()
        viewImage.image = image
//        print(image)
        print("Data saved to Realm")
        
        guard let lastSet = storyHeroChanges.item.last else { return }
        RealmManager.shared.add(lastSet)
        
        removeFromSuperview()
    }
    
    func createImageFromLayers() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(characterView.bounds.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        characterView.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setDelButton() {
        for (index, bodyPart) in startSetQ.enumerated(){
            if !bodyPart.isMandatoryPresentation && bodyPart.nameS != "Gender"{
                // for deleteButton
                let del = ComponentsBodyPart(id: "0", imageName: "ic_round", previewName: "deleteButton_ic_round")
                startSetQ.bodyParts[index].item.insert(del, at: 0)
            }
        }
    }
    
    private func setupViews() {
        addSubview(characterView)
        addSubview(firstCollectionView)
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        addSubview(secondCollectionView)
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        
        addSubview(saveButton)
        addSubview(viewImage)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
      
            viewImage.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 4),
            viewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewImage.widthAnchor.constraint(equalToConstant: 150),
            viewImage.heightAnchor.constraint(equalToConstant: 150),
        
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
            secondCollectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
//        setDelButton()
        
        setupExistingBodyParts()
        
    }
    
       private func setupExistingBodyParts() {

           oneStep = startSetQ
           print(startSetQ)
           
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
extension CollectionViewContainer: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return startSetQ.bodyParts.count
        } else {
            return countSecondCVCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryCell.identifier, for: indexPath) as! EditorCategoryCell
            cell.configure(with: "\(startSetQ.bodyParts[indexPath.row].nameS ?? "no name 🤷")")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryItemCell.identifier, for: indexPath) as! EditorCategoryItemCell
            
            var fileName = ""
//            print(startSetQ.gender)
            if startSetQ.gender == .girl {
                fileName = startSetQ.bodyParts[index].girl[indexPath.item].bvcfXbnbjb6Hhn ?? ""
            } else {
                fileName = startSetQ.bodyParts[index].boy[indexPath.item].bvcfXbnbjb6Hhn ?? ""
            }
            
            if fileName == "ic_round-g" { // for gender button
                let previewImage = getImageFromFile(with: fileName)
                cell.configure(with: previewImage, backgroundColorr: .blue)
            } else {
                let previewImage = getImageFromFile(with: fileName)
                cell.configure(with: previewImage)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("🔸 didSelectItemAt = \(indexPath.row)")
        print("🔸 startSetQ.gender = \(startSetQ.gender)")

        if collectionView == firstCollectionView {
            DispatchQueue.main.async {
                self.secondCollectionView.reloadData()
            }

            if startSetQ.gender == .girl {
                countSecondCVCell = startSetQ.bodyParts[indexPath.row].girl.count
            } else {
                countSecondCVCell = startSetQ.bodyParts[indexPath.row].boy.count
            }

            index = indexPath.row
            
        }

        if collectionView == secondCollectionView {
            var fileName = ""

            print(index)
            print(startSetQ.bodyParts.count)
            
            
            
            if startSetQ.gender == .girl {
                fileName = startSetQ.bodyParts[index].girl[indexPath.item].vcbVnbvbvBBB ?? ""
            } else {
                fileName = startSetQ.bodyParts[index].boy[indexPath.item].vcbVnbvbvBBB ?? ""
            }

            if index != 0 {
                let image = getImageFromFile(with: fileName)
                if let view = characterView.subviews[index] as? UIImageView {
                    view.image = image
                }

                oneStep = createOneNextStep(with: fileName, and: index)
            } else {
                updateGenderSet(with: indexPath.item)
            }
        }
    }

    func updateGenderSet(with itemIndex: Int) {
        var genderChangeSet = HeroSet()
        var bodyPartsList = List<BodyPart>()

        startSetQ.gender = (itemIndex == 0) ? .boy : .girl

        for (ind, subview) in characterView.subviews.enumerated() {
            
            let genderBodyPart = (startSetQ.gender == .boy) ?
            startSetQ.bodyParts[ind].boy.first :
            startSetQ.bodyParts[ind].girl.first
            
            if let imageView = subview as? UIImageView {
//                if ind != 0 { // gender cell
                    
                    let fileName = genderBodyPart?.vcbVnbvbvBBB ?? ""
                    let  part = startSetQ.bodyParts[ind]
                    part.valueValue = fileName
                    
                    
                    imageView.image = getImageFromFile(with: fileName)
    
                    genderChangeSet.bodyParts.append(part)
                    genderChangeSet.gender = startSetQ.gender
//                }  //
            }
        }

        oneStep = genderChangeSet
    }

    func createOneNextStep(with fileName: String, and index: Int) -> HeroSet {
        guard let previousHeroSet = storyHeroChanges.item.last else { return HeroSet() }
        var newHeroSet = HeroSet()

        print("previousHeroSet.bodyParts.count   =   \(previousHeroSet.bodyParts.count)")
        
        newHeroSet.gender = previousHeroSet.gender
        newHeroSet.bodyParts.append(objectsIn: previousHeroSet.bodyParts)
        newHeroSet.bodyParts[index].valueValue = fileName
        print("newHeroSet.bodyParts.count   =   \(newHeroSet.bodyParts.count)")
       
        return newHeroSet
    }
}




































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

