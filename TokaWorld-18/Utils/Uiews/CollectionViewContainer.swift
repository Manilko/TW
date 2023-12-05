//
//  CollectionViewContainer.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 02.12.2023.
//

import UIKit

class CollectionViewContainer: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var index = 0
    var count: Int{
        didSet {
            DispatchQueue.main.async {
                self.secondCollectionView.reloadData()
            }
        }
    }
    
    var oneStep: HerosBodyElementSet = HerosBodyElementSet() {
        didSet {
            self.storyCharacterChangesReaim.item.append(oneStep)
        }
    }
    
    var storyCharacterChangesReaim: StoryCharacterChanges = StoryCharacterChanges()
    
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
    
    var obgect: HerosBodyElementSet = HerosBodyElementSet()
    
    init(obj: StoryCharacterChanges) {

        obgect = obj.item.last ?? HerosBodyElementSet()
        self.count = obj.item.first?.items.first?.item.count ?? 0
        self.storyCharacterChangesReaim = obj
        
        super.init(frame: .zero)
        setupViews()
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        
        
        for i in obgect {
            
            let imageView = UIImageView()
            var fileName: String = ""

//            if obgect.gender == .girl{
//                if i.isMandatoryPresentation{
//                    fileName = "\((i.girl[i.valueS ].vcbVnbvbvBBB)!)"
//                }
//            }
            
            if i.isMandatoryPresentation{
                fileName = "\((i.boy[i.valueS ].vcbVnbvbvBBB)!)"
            } else {
                // for deleteButton
                    let del = ComponentsHero(id: "w", imageName: "nil", previewName: "deleteButton_ic_round")
                i.item.insert(del, at: 0)
            }
            
//            if let fileName {
                imageView.image = getImageFromFile(with: fileName)
//            }
            
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
           
                self.firstCollectionView.reloadData()
                self.secondCollectionView.reloadData()
            
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
        
        // MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == firstCollectionView {
                return obgect.items.count
            } else {
                return count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
//            let gender = 0
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
                
                print(">>>>>>>  obgect.items[indexPath.row].nameS\(obgect.items[indexPath.row].nameS) ===  isMandatoryPresentation  \(obgect.items[indexPath.row].isMandatoryPresentation)        ")
                
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
                
//                if obgect.items[index].isMandatoryPresentation{
//
//                }
                
                if obgect.gender == .girl{
                    fileName = obgect.items[index].girl[indexPath.item].vcbVnbvbvBBB ?? ""
                } else{
                    fileName = obgect.items[index].boy[indexPath.item].vcbVnbvbvBBB ?? ""
                }
   
                if index != 0{
                    let image = getImageFromFile(with: fileName)
                    let  a = characterView.subviews[index] as? UIImageView
                    a?.image = image

                } else {
                    print("indexPath.item\(indexPath.item)")
                    if indexPath.item == 0{
                        for (ind, subview) in characterView.subviews.enumerated() {
                            if let imageView = subview as? UIImageView {
                                obgect.gender = .boy
                                if ind != 0{
                                    let fileName = obgect.items[ind].boy.first?.vcbVnbvbvBBB ?? ""
                                    imageView.image = getImageFromFile(with: fileName)
                                }
                                
                            }
                        }
                    } else{
                        for (ind, subview) in characterView.subviews.enumerated() {
                            if let imageView = subview as? UIImageView {
                                obgect.gender = .girl
                                if ind != 0{
                                    let fileName = obgect.items[ind].girl.first?.vcbVnbvbvBBB ?? ""
                                    imageView.image = getImageFromFile(with: fileName)
                                }
                            }
                        }
                    }
                }
                
               
//                oneStep = createOneNextStep(with: fileName, and: indexPath.item, changedItem: obgect.items[index])
                
//                print(storyCharacterChangesReaim)
                
      
            }
        }
    
    
    func createOneNextStep(with fileName: String, and index: Int, changedItem: HerosElement) -> HerosBodyElementSet {
        let lastSet = storyCharacterChangesReaim.item.last
        var newStep: HerosBodyElementSet = HerosBodyElementSet()
        
        let item = HerosElement(name: changedItem.nameS ?? "", hierarchy: changedItem.hierarchy, isMandatoryPresentation: changedItem.isMandatoryPresentation, value: index, item: changedItem.item)
        
        guard let lastEl = lastSet else { return HerosBodyElementSet() }
        
        for element in lastEl {
            if element.nameS == item.nameS {
                    newStep.items.append(item)
                } else {
                    newStep.items.append(element)
                }
            }
        
        return newStep
    }
    
    }


