//
//  EditorController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit
import RealmSwift


final class EditorController: UIViewController {
    
    let listHeros: Results<HeroSet>
    
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var itemDelegate: PresrntDelegate?
    
    init() {
        listHeros = RealmManager.shared.getObjects(HeroSet.self)
        print("listHeros.count \(listHeros.count)")
        super.init(nibName: nil, bundle: nil)
        
        
        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        
        // MARK: - filterView
        view().collectionView.dataSource = self
        view().collectionView.delegate = self
        view().collectionView.register(EditorCollectionCell.self, forCellWithReuseIdentifier: EditorCollectionCell.identifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        deinit {
            print("🗑️☑️   EditorController is deinited")
        }

    override func loadView() {
        super.loadView()
        self.view = EditirView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
//        RealmManager.shared.delete(listHeros)
        
        
    }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }
    
    func createStartSet() -> HeroSet {
        
        var herosBodyElementSet = HeroSet()
        let editorCategory: [EditorCategory] = Array(RealmManager.shared.getObjects(EditorCategory.self))
        
        let herosElementSet = JsonParsingManager.parseEditorJSON(data: editorCategory)
        guard let herosElementSet else { return HeroSet() }
        
        let sortedHerosElementSet  = herosElementSet.sorted { $0.hierarchy < $1.hierarchy }
        
        let herosElementlist = List<BodyPart>()
        herosElementlist.append(objectsIn: sortedHerosElementSet)
        
        herosBodyElementSet = HeroSet(item: herosElementlist)
        
        return herosBodyElementSet
    }
    
}

// MARK: - filterView UICollectionViewDataSource
extension EditorController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if listHeros.count > 0{
//            return listHeros.count + 1
//        } else{
//            return 1
//        }
        
        return listHeros.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCollectionCell.identifier, for: indexPath) as! EditorCollectionCell
        
        if indexPath.row == 0 {
            cell.backgroundColor = .red
        } else  {
            let item = listHeros[indexPath.row - 1]
            cell.configure(setHeroBodyPart: item)
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenHero: HeroSet
        
        if indexPath.row != 0{
            chosenHero = listHeros[indexPath.row - 1]
        } else{
            chosenHero = createStartSet()
        }
        
        itemDelegate?.presentDetailViewController(hero: chosenHero)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth = (collectionView.frame.width - 16) / 2 
           let cellHeight = collectionView.frame.height / 2
           return CGSize(width: cellWidth, height: cellHeight)
       }
    
}


// MARK: - ViewSeparatable
extension EditorController: ViewSeparatable {
    typealias RootView = EditirView
}
