//
//  EditProcessController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit
import RealmSwift
import Realm
import PDFKit

final class EditProcessController: UIViewController {
    
    var currentIndex: Int{
        didSet{
            updateNavigationButtons()
            DispatchQueue.main.async {
                self.view().collectionViewContainer.elementCollectionView.reloadData()
                self.view().collectionViewContainer.categoryCollectionView.reloadData()
            }
        }
        
    }
    var selectedCategoryIndex: Int = 0
    var index = 0
    var countSecondCVCell: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.view().collectionViewContainer.elementCollectionView.reloadData()
            }
        }
    }
    
    var oneStep: HeroSet = HeroSet() {
        didSet {
            let newSet = HeroSet(value: oneStep)
            storyHeroChanges.append(newSet)
            updateNavigationButtons()
        }
    }
    
    var startBodyElementSet: HeroSet = HeroSet()

    var storyHeroChanges: [HeroSet] = []{
        didSet {
            currentIndex += 1
        }
    }
    var startToDel: HeroSet
    
    // MARK: - Properties
    weak var coordinatorDelegate: EditProcessDelegate?
    
    init(item: HeroSet) {
        
        self.startToDel = item
        self.currentIndex = 0
        storyHeroChanges.append(item)
        
        super.init(nibName: nil, bundle: nil)

        let bodyParts: List<BodyPart> = List<BodyPart>()
        
        for i in item.bodyParts{
            let bodyPart: BodyPart = BodyPart(value: i)
            bodyParts.append(bodyPart)
        }
       
        startBodyElementSet = HeroSet()
        startBodyElementSet.bodyParts.append(objectsIn: bodyParts)
        startBodyElementSet.gender = item.gender
        
        startBodyElementSet.id = item.id
        
        
        self.countSecondCVCell = item.bodyParts.first?.item.count ?? 0

        
        //navView
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        
        //navigationButtons
        view().navigationButtons.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        view().navigationButtons.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        view().collectionViewContainer.elementCollectionView.delegate = self
        view().collectionViewContainer.elementCollectionView.dataSource = self
        view().collectionViewContainer.elementCollectionView.register(EditorCategoryItemCell.self, forCellWithReuseIdentifier: EditorCategoryItemCell.identifier)
        
        view().collectionViewContainer.categoryCollectionView.delegate = self
        view().collectionViewContainer.categoryCollectionView.dataSource = self
        view().collectionViewContainer.categoryCollectionView.register(EditorCategoryCell.self, forCellWithReuseIdentifier: EditorCategoryCell.identifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print(" 🗑️☑️  EditProcessController is deinited")
    }

    override func loadView() {
        super.loadView()
        
        self.view = EditProcessView(startSet: startBodyElementSet)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneStep = startBodyElementSet
    }
    
    private func updateNavigationButtons() {

        view().navigationButtons.currentIndex = currentIndex
        view().navigationButtons.totalCount = storyHeroChanges.count

        let hero = storyHeroChanges[currentIndex]

        for (ind, subview) in view().characterView.subviews.enumerated() {
            if let imageView = subview as? UIImageView {
                let  fileName = hero.bodyParts[ind].valueValue
                imageView.image = ImageSeries.getImageFromFile(with: fileName ?? "")
            }
        }
        
    }
    
    @objc func leftButtonTapped() {
            currentIndex -= 1
    }

    @objc func rightButtonTapped() {
            currentIndex += 1
    }
    
    @objc private func backDidTaped(_ celector: UIButton) {
        
        if storyHeroChanges.count > 1 {
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

        guard let lastSet = storyHeroChanges.last else { return }

        let image: Data? = .createImageData(from: view().characterView)
        lastSet.iconImage = image
        
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
extension EditProcessController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == view().collectionViewContainer.categoryCollectionView {
            return CGSize(width: collectionView.bounds.width / 3.4, height: 38)
        } else {
            if selectedCategoryIndex == 0{
                return CGSize(width: collectionView.bounds.width / 2, height: 80)
            } else{
                return CGSize(width: 80, height: 80)
            }
            
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == view().collectionViewContainer.categoryCollectionView {
            return startBodyElementSet.bodyParts.count
        } else {
            return countSecondCVCell
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == view().collectionViewContainer.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryCell.identifier, for: indexPath) as! EditorCategoryCell

                  let isSelected = indexPath.row == selectedCategoryIndex
                  cell.configure(with: "\(startBodyElementSet.bodyParts[indexPath.row].nameS ?? "no name 🤷")", isSelected: isSelected)

                  return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCategoryItemCell.identifier, for: indexPath) as! EditorCategoryItemCell
            
            var fileName = ""
            
            if startBodyElementSet.gender == .girl {
                fileName = startBodyElementSet.bodyParts[index].girl[indexPath.item].bvcfXbnbjb6Hhn ?? ""
            } else {
                fileName = startBodyElementSet.bodyParts[index].boy[indexPath.item].bvcfXbnbjb6Hhn ?? ""
            }
            
            let previewImage = ImageSeries.getImageFromFile(with: fileName)
            
            if index == 0 {
                if indexPath.item == 1 {
                    if startBodyElementSet.gender == .girl {
                        cell.configure(with: previewImage, backgroundColorr: .mainBlue, isRound: false, isSelect: true)
                    } else {
                        cell.configure(with: previewImage, backgroundColorr: .backgroundBlue, isRound: false, isSelect: true)
                    }
                } else {
                    if startBodyElementSet.gender == .boy {
                        cell.configure(with: previewImage, backgroundColorr: .mainBlue, isRound: false, isSelect: true)
                    } else {
                        cell.configure(with: previewImage, isRound: false, isSelect: true)
                    }
                }
            } else {
            
                 let extFileName = extractFilename(from: fileName)
                
                let filename = extractFilename(from:storyHeroChanges.last?.bodyParts[index].valueValue ?? "")
                
                if removeSpaces(from: extFileName ?? "") == removeSpaces(from: filename ?? "")  || areStringsEqualIgnoringCase(extFileName ?? "", filename ?? ""){
                    cell.configure(with: previewImage, isSelect: true)
                } else{
                    cell.configure(with: previewImage)
                }
            }
            
            return cell
        }
    }
    
    func extractFilename(from filePath: String) -> String? {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileName = fileURL.deletingPathExtension().lastPathComponent
        return fileName
    }
    
    func removeSpaces(from string: String) -> String {
        let trimmedString = string.replacingOccurrences(of: " ", with: "")
        return trimmedString
    }
    
    func areStringsEqualIgnoringCase(_ string1: String, _ string2: String) -> Bool {
        return string1.caseInsensitiveCompare(string2) == .orderedSame
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == view().collectionViewContainer.categoryCollectionView {
                DispatchQueue.main.async {
                    self.view().collectionViewContainer.elementCollectionView.reloadData()
                }

                if startBodyElementSet.gender == .girl {
                    countSecondCVCell = startBodyElementSet.bodyParts[indexPath.row].girl.count
                } else {
                    countSecondCVCell = startBodyElementSet.bodyParts[indexPath.row].boy.count
                }

                index = indexPath.row
                selectedCategoryIndex = indexPath.row
                collectionView.reloadData()
            }

        if collectionView == view().collectionViewContainer.elementCollectionView {
            var fileName = ""

            if startBodyElementSet.gender == .girl {
                fileName = startBodyElementSet.bodyParts[index].girl[indexPath.item].vcbVnbvbvBBB ?? ""
            } else {
                fileName = startBodyElementSet.bodyParts[index].boy[indexPath.item].vcbVnbvbvBBB ?? ""
            }

            if index != 0 {
                let image = ImageSeries.getImageFromFile(with: fileName)
                if let view = view().characterView.subviews[index] as? UIImageView {
                    view.image = image
                }

                oneStep = createOneNextStep(with: fileName, and: index)
                
                if let cell = collectionView.cellForItem(at: indexPath) as? EditorCategoryItemCell {
                    cell.isSelect = true
                }
                
                DispatchQueue.main.async {
                    self.view().collectionViewContainer.elementCollectionView.reloadData()
                }
                
            } else {
                updateGenderSet(with: indexPath.item)
                collectionView.reloadData()
            }
        }
    }

}



// MARK: -

extension EditProcessController{
    
    func updateGenderSet(with itemIndex: Int) {
        let genderChangeSet = HeroSet()

        startBodyElementSet.gender = (itemIndex == 0) ? .boy : .girl

        for (ind, subview) in view().characterView.subviews.enumerated() {
            
            let genderBodyPart = (startBodyElementSet.gender == .boy) ?
            startBodyElementSet.bodyParts[ind].boy.first :
            startBodyElementSet.bodyParts[ind].girl.first
            
            if let imageView = subview as? UIImageView {

                let fileName = genderBodyPart?.vcbVnbvbvBBB ?? ""
                let  part = startBodyElementSet.bodyParts[ind]
                part.valueValue = fileName

                imageView.image = ImageSeries.getImageFromFile(with: fileName)

                genderChangeSet.bodyParts.append(part)
                genderChangeSet.gender = startBodyElementSet.gender
                let image: Data? = .createImageData(from: view().characterView)
                genderChangeSet.iconImage = image
            }
        }

        oneStep = genderChangeSet
    }
    
    func createOneNextStep(with fileName: String, and index: Int) -> HeroSet {
        
        guard let previousHeroSet = storyHeroChanges.last else { return HeroSet() }
        let newHeroSet = HeroSet()

        let bodyParts: List<BodyPart> = List<BodyPart>()
        
        for element in previousHeroSet.bodyParts{
            let bodyPart: BodyPart = BodyPart(value: element)
            bodyParts.append(bodyPart)
        }

        newHeroSet.gender = previousHeroSet.gender
        newHeroSet.bodyParts.append(objectsIn: bodyParts)
        newHeroSet.bodyParts[index].valueValue = fileName

        let image: Data? = .createImageData(from: view().characterView)
        newHeroSet.iconImage = image
  
        return newHeroSet
    }
}
