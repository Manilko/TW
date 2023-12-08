//
//  CollectionViewContainer.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 02.12.2023.
//

import UIKit
import RealmSwift
import Realm

class CollectionViewContainer: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        return collectionView
    }()
    
    let secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(EditorCategoryItemCell.self, forCellWithReuseIdentifier: EditorCategoryItemCell.identifier)
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
    
    var obgect: HeroSet = HeroSet()
    var index = 0
    var count: Int{
        didSet {
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

    
    var storyHeroChanges: StoryCharacterChanges = StoryCharacterChanges()
    
    init(obj: HeroSet) {

        obgect = obj
        self.count = obj.items.count
//        self.storyHeroChanges = obj
        
        
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func saveToRealm() {
        
        let image = createImageFromLayers()
        viewImage.image = image
        print(image)
        print("Data saved to Realm")
    }

    
    func createImageFromLayers() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(characterView.bounds.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        characterView.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private func setupViews() {
        
        addSubview(characterView)
        
        addSubview(firstCollectionView)
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(secondCollectionView)
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(saveButton)
               NSLayoutConstraint.activate([
                   saveButton.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 20),
                   saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                   saveButton.widthAnchor.constraint(equalToConstant: 150),
                   saveButton.heightAnchor.constraint(equalToConstant: 40),
               ])
        addSubview(viewImage)
        NSLayoutConstraint.activate([
            viewImage.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 4),
            viewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewImage.widthAnchor.constraint(equalToConstant: 150),
            viewImage.heightAnchor.constraint(equalToConstant: 150),
        ])
        
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
            secondCollectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        
        
        var startHeroSet: HeroSet = HeroSet()
         
        for bodyPart in obgect {
            
            let imageView = UIImageView()
            var fileName: String?
            
            if (bodyPart.valueValue == nil && bodyPart.isMandatoryPresentation) || bodyPart.nameS == "Gender"{
                fileName = "\((bodyPart.item[bodyPart.valueS ].vcbVnbvbvBBB)!)"
            } else {
                // for deleteButton
                    let del = ComponentsHero(id: "0", imageName: "ic_round", previewName: "deleteButton_ic_round")
                bodyPart.item.insert(del, at: 0)
            }
            
            if let fileName {
                imageView.image = getImageFromFile(with: fileName)
            }
           
            let firstBodyPa = BodyPart(name: bodyPart.nameS ?? "", hierarchy: bodyPart.hierarchy, isMandatoryPresentation: bodyPart.isMandatoryPresentation, value: bodyPart.valueS, item: bodyPart.item, valueValue: fileName)
            
            startHeroSet.items.append(firstBodyPa)
            
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
        
        self.storyHeroChanges.item.append(startHeroSet)
//        RealmManager.shared.add(storyHeroChanges)
           
                self.firstCollectionView.reloadData()
                self.secondCollectionView.reloadData()
            
        }
    
    func getImageFromFile(with fileName: String) -> UIImage {
        var image = UIImage()
        

        if let localImage = UIImage(named: fileName){  //  for local Image
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
        
        // MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
    var genderType = 0
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == firstCollectionView {
                return obgect.items.count
            } else {
                return count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == firstCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryCell.identifier, for: indexPath) as! EditorCategoryCell
                
                cell.configure(with: "\(obgect.items[indexPath.row].nameS ?? "no name 🤷")")
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryItemCell.identifier, for: indexPath) as! EditorCategoryItemCell
                
                var fileName = ""
          
                if obgect.gender == .girl{
                    fileName = obgect.items[index].girl[indexPath.item].bvcfXbnbjb6Hhn ?? ""
                } else{
                    fileName = obgect.items[index].boy[indexPath.item].bvcfXbnbjb6Hhn ?? ""
                }

                if fileName == "ic_round-g"{
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
            
            if collectionView == firstCollectionView {
                DispatchQueue.main.async {
                    self.secondCollectionView.reloadData()
                }
                
                if obgect.gender == .girl{
                    count = obgect.items[indexPath.row].girl.count
                } else{
                    count = obgect.items[indexPath.row].boy.count
                }
                
                index = indexPath.row
                print("index = indexPath.row\(index)")
                
            }
            
            if collectionView == secondCollectionView {
                
                var fileName = ""
                
                if obgect.gender == .girl{
                    fileName = obgect.items[index].girl[indexPath.item].vcbVnbvbvBBB ?? ""
                } else{
                    fileName = obgect.items[index].boy[indexPath.item].vcbVnbvbvBBB ?? ""
                }
   
                if index != 0{
                    let image = getImageFromFile(with: fileName)
                    let  a = characterView.subviews[index] as? UIImageView
                    a?.image = image

                } else {   //   control functionality =>> gender button click. it need fix!
                    var startHeroSet: HeroSet = HeroSet()

                    if indexPath.item == 0{
                        for (ind, subview) in characterView.subviews.enumerated() {
                            if let imageView = subview as? UIImageView {
                                obgect.gender = .boy
                                if ind != 0{ // gender cell
                                    let fileName = obgect.items[ind].boy.first?.vcbVnbvbvBBB ?? ""
                                    imageView.image = getImageFromFile(with: fileName)
                                    let firstBodyPa = BodyPart(name: obgect.items[ind].nameS ?? "", hierarchy: obgect.items[ind].hierarchy, isMandatoryPresentation: obgect.items[ind].isMandatoryPresentation, value: obgect.items[ind].valueS, item: obgect.items[ind].item, valueValue: fileName)
                                    startHeroSet.items.append(firstBodyPa)
                                }
                            }
                        }
                    } else{
                        for (ind, subview) in characterView.subviews.enumerated() {
                            if let imageView = subview as? UIImageView {
                                obgect.gender = .girl
                                if ind != 0{ // gender cell
                                    let fileName = obgect.items[ind].girl.first?.vcbVnbvbvBBB ?? ""
                                    imageView.image = getImageFromFile(with: fileName)
                                    let firstBodyPa = BodyPart(name: obgect.items[ind].nameS ?? "", hierarchy: obgect.items[ind].hierarchy, isMandatoryPresentation: obgect.items[ind].isMandatoryPresentation, value: obgect.items[ind].valueS, item: obgect.items[ind].item, valueValue: fileName)
                                    startHeroSet.items.append(firstBodyPa)
                                }
                            }
                        }
                    }
                
                    oneStep = startHeroSet
                }
                oneStep = createOneNextStep(with: fileName, and: indexPath.item, changedBodyPart: obgect.items[index])
            }
        }
    
    
    func createOneNextStep(with fileName: String, and index: Int, changedBodyPart: BodyPart) -> HeroSet {
        let lastHeroSet = storyHeroChanges.item.last
        var newStepHeroSet: HeroSet = HeroSet()
        
        let newBodyPart = BodyPart(name: changedBodyPart.nameS ?? "", hierarchy: changedBodyPart.hierarchy, isMandatoryPresentation: changedBodyPart.isMandatoryPresentation, value: index, item: changedBodyPart.item, valueValue: fileName)

        guard let lastHeroSet else { return HeroSet() }
        
        for bodyPart in lastHeroSet {
            if bodyPart.nameS == newBodyPart.nameS {
                    newStepHeroSet.items.append(newBodyPart)
                } else {
                    newStepHeroSet.items.append(bodyPart)
                }
            }

        return newStepHeroSet
    }
    
    }

//import UIKit
//
//class YourViewController: UIViewController {
//
//    let firstButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("First Button", for: .normal)
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    let secondButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Second Button", for: .normal)
//        button.backgroundColor = .green
//        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    var df: Int = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(firstButton)
//        view.addSubview(secondButton)
//
//        NSLayoutConstraint.activate([
//            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            firstButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
//            firstButton.widthAnchor.constraint(equalToConstant: 150),
//            firstButton.heightAnchor.constraint(equalToConstant: 40),
//
//            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            secondButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
//            secondButton.widthAnchor.constraint(equalToConstant: 150),
//            secondButton.heightAnchor.constraint(equalToConstant: 40),
//        ])
//    }
//
//    @objc private func firstButtonTapped() {
//        print("First button tapped!")
//        RealmManager.shared.add(df)
//    }
//
//    @objc private func secondButtonTapped() {
//        print("Second button tapped!")
//        df = df + 1
//    }
//}
