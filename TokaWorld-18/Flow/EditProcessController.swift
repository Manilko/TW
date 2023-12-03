//
//  EditProcessController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit
import RealmSwift
import PDFKit

final class EditProcessController: UIViewController {
    
    // MARK: - Properties
    weak var coordinatorDelegate: DetailEditDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(leftDidTaped), for: .touchUpInside)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print(" 🗑️☑️  EditProcessController is deinited")
    }

    override func loadView() {
        super.loadView()
        
        let resultsMod: Results<EditorCategory>
        let arrayMod: [EditorCategory]
        
        resultsMod = RealmManager.shared.getObjects(EditorCategory.self)
        arrayMod = Array(RealmManager.shared.getObjects(EditorCategory.self))
        
        let herosElementSet = JsonParsingManager.parseEditorJSON(data: arrayMod)
        guard let herosElementSet = herosElementSet else { return }
        for i in herosElementSet {
            i.downloadPDFs {
                print("@@@@@@@@>>>>>>>>")
            }
        }
        let sortedHerosElementSet  = herosElementSet.sorted { $0.hierarchy < $1.hierarchy }
        
        let herosElementlist = List<HerosElement>()
        herosElementlist.append(objectsIn: sortedHerosElementSet)
        
        let herosBodyElementSet = HerosBodyElementSet(item: herosElementlist)
        let storyCharacterChanges = StoryCharacterChanges()
        storyCharacterChanges.item.append(herosBodyElementSet)
        
       
        
        self.view = EditProcessView(obj: storyCharacterChanges)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    @objc private func leftDidTaped(_ celector: UIButton) {
        coordinatorDelegate?.pop(self)
    }

}

extension EditProcessController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }

                let item = ItemModel(title: "title", icon: "mocImage", discription: "description")
                cell.configure(with: item)

                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           CGSize(width: 80, height: 180)
       }
    
    
}

// MARK: - ViewSeparatable
extension EditProcessController: ViewSeparatable {
    typealias RootView = EditProcessView
}
