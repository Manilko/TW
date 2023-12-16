//
//  EditProcessController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

//import UIKit
//import RealmSwift
//import PDFKit
//
//final class EditProcessController: UIViewController {
//    
//    var startSetBodyElementSet: HeroSet = HeroSet()
//    
//    // MARK: - Properties
//    weak var coordinatorDelegate: EditProcessDelegate?
//    
//    init(item: HeroSet) {
//        super.init(nibName: nil, bundle: nil)
//        startSetBodyElementSet = HeroSet(value: item)
//        
//        view().navView.leftButton.addTarget(self, action: #selector(leftDidTaped), for: .touchUpInside)
//        
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    deinit {
//        print(" 🗑️☑️  EditProcessController is deinited")
//    }
//
//    override func loadView() {
//        super.loadView()
//        
//        self.view = EditProcessView(startSet: startSetBodyElementSet)
//
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//    }
//    
//    @objc private func leftDidTaped(_ celector: UIButton) {
//        coordinatorDelegate?.pop(self)
//    }
//
//}
//
//
//// MARK: - ViewSeparatable
//extension EditProcessController: ViewSeparatable {
//    typealias RootView = EditProcessView
//}



import UIKit
import RealmSwift
import Realm
import PDFKit

final class EditProcessController: UIViewController {
    
    var startSetBodyElementSet: HeroSet = HeroSet()
    
    var currentIndex: Int = 0{
        didSet{
            self.view().navigationButtons.currentIndex = currentIndex
        }
        
    }
    
    var index = 0
    var countSecondCVCell: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.view().collectionViewContainer.secondCollectionView.reloadData()
            }
        }
    }
    
    var oneStep: HeroSet = HeroSet() {
        didSet {
            self.storyHeroChanges.item.append(oneStep)
            view().navigationButtons.totalCount = storyHeroChanges.item.count
//            view().navigationButtons.currentIndex = storyHeroChanges.item.count
            currentIndex =  storyHeroChanges.item.count
            print("              storyHeroChanges.item.count      \(storyHeroChanges.item.count)")
            print("              storyHeroChanges.item.count      \(storyHeroChanges.item.count)")
        }
    }
    
    var startSetQ: HeroSet = HeroSet()
    
    var storyHeroChanges: StoryCharacterChanges = StoryCharacterChanges()
    var startToDel: HeroSet
    
    // MARK: - Properties
    weak var coordinatorDelegate: EditProcessDelegate?
    
    init(item: HeroSet) {
        
        startToDel = item
        
        super.init(nibName: nil, bundle: nil)
        startSetBodyElementSet = HeroSet(value: item)

        var bodyParts: List<BodyPart> = List<BodyPart>()
        
        for i in item.bodyParts{
            var bodyPart: BodyPart = BodyPart(value: i)
            bodyParts.append(bodyPart)
        }
       
        startSetQ = HeroSet()
        startSetQ.id = item.id
        startSetQ.bodyParts.append(objectsIn: bodyParts)
        startSetQ.gender = item.gender
        
        self.countSecondCVCell = item.bodyParts.first?.item.count ?? 0

        
        //navView
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        
        //navigationButtons
        view().navigationButtons.totalCount = storyHeroChanges.item.count
        view().navigationButtons.currentIndex = currentIndex
        view().navigationButtons.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        view().navigationButtons.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        view().collectionViewContainer.secondCollectionView.delegate = self
        view().collectionViewContainer.secondCollectionView.dataSource = self
        view().collectionViewContainer.secondCollectionView.register(EditorCategoryItemCell.self, forCellWithReuseIdentifier: EditorCategoryItemCell.identifier)
        
        view().collectionViewContainer.firstCollectionView.delegate = self
        view().collectionViewContainer.firstCollectionView.dataSource = self
        view().collectionViewContainer.firstCollectionView.register(EditorCategoryCell.self, forCellWithReuseIdentifier: EditorCategoryCell.identifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print(" 🗑️☑️  EditProcessController is deinited")
    }

    override func loadView() {
        super.loadView()
        
        self.view = EditProcessView(startSet: startSetBodyElementSet)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneStep = startSetQ
        view.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }
    
    @objc func leftButtonTapped() {
        if currentIndex > 0 {
            currentIndex -= 1
            view().navigationButtons.currentIndex = currentIndex
        }
    }

    @objc func rightButtonTapped() {
        if currentIndex < storyHeroChanges.item.count - 1 {
            currentIndex += 1
            view().navigationButtons.currentIndex = currentIndex
        }
    }
    
    @objc private func backDidTaped(_ celector: UIButton) {
        
        if storyHeroChanges.item.count > 1 {
            self.presentTwoVLabelAndTwoHButtonAlert(
                titleText: "Do you want to exit?",
                subtitleText: "All your actions will be canceled",
                leftButtonImageType: .cancelButton,
                rightButtonImageType: .exitButton,
                leftCompletion: {
                    print("leftCompletion tapped")
                },
                rightCompletion: {
                    print("rightCompletion tapped")
                    self.dismiss(animated: true)
                    self.coordinatorDelegate?.pop(self)
                }
                
            )
        } else{
            self.coordinatorDelegate?.pop(self)
        }
        
       
 
    }
    
    @objc private func saveToRealm() {

        let image = UIImage(data: createImageFromLayers() ?? Data())
        view().collectionViewContainer.viewImage.image = image

        print("Data saved to Realm")
        
        guard let lastSet = storyHeroChanges.item.last else { return }

        RealmManager.shared.deleteObject(HeroSet.self, primaryKeyValue: startToDel.id)
        RealmManager.shared.add(lastSet)
        
        coordinatorDelegate?.pop(self)
    }

}


// MARK: - ViewSeparatable
extension EditProcessController: ViewSeparatable {
    typealias RootView = EditProcessView
}


// MARK: - UICollectionViewDelegate and UICollectionViewDataSource methods
extension EditProcessController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == view().collectionViewContainer.firstCollectionView {
            return startSetQ.bodyParts.count
        } else {
            return countSecondCVCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == view().collectionViewContainer.firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryCell.identifier, for: indexPath) as! EditorCategoryCell
            cell.configure(with: "\(startSetQ.bodyParts[indexPath.row].nameS ?? "no name 🤷")")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryItemCell.identifier, for: indexPath) as! EditorCategoryItemCell
            
            var fileName = ""
            
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

        if collectionView == view().collectionViewContainer.firstCollectionView {
            DispatchQueue.main.async {
                self.view().collectionViewContainer.secondCollectionView.reloadData()
            }

            if startSetQ.gender == .girl {
                countSecondCVCell = startSetQ.bodyParts[indexPath.row].girl.count
            } else {
                countSecondCVCell = startSetQ.bodyParts[indexPath.row].boy.count
            }

            index = indexPath.row
            
        }

        if collectionView == view().collectionViewContainer.secondCollectionView {
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
                if let view = view().collectionViewContainer.characterView.subviews[index] as? UIImageView {
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

        for (ind, subview) in view().collectionViewContainer.characterView.subviews.enumerated() {
            
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
                let image = createImageFromLayers()
                genderChangeSet.iconImage = image
//                }  //
            }
        }

        oneStep = genderChangeSet
    }

    func createOneNextStep(with fileName: String, and index: Int) -> HeroSet {
        guard let previousHeroSet = storyHeroChanges.item.last else { return HeroSet() }
        var newHeroSet = HeroSet()

        print("previousHeroSet.bodyParts.count   =   \(previousHeroSet.bodyParts.count)")
        print("index   =   \(index)")
        
        newHeroSet.gender = previousHeroSet.gender
        newHeroSet.bodyParts.append(objectsIn: previousHeroSet.bodyParts)
        newHeroSet.bodyParts[index].valueValue = fileName
        let image = createImageFromLayers()
        newHeroSet.iconImage = image
        
//        print("newHeroSet.iconImage   =   \(newHeroSet.iconImage)")
       
        return newHeroSet
    }
    
  
}



// MARK: - getImageFromFile

extension EditProcessController{
    
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
    
    func createImageFromLayers() -> Data? {
        UIGraphicsBeginImageContextWithOptions(view().collectionViewContainer.characterView.bounds.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view().collectionViewContainer.characterView.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext(),
              let imageData = image.pngData() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return imageData
    }
}

