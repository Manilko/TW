//
//  EditorController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit
import RealmSwift


final class EditorController: UIViewController {
    
    // MARK: - Properties
    var listHeros: [HeroSet] = []
    // Delegates
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var itemDelegate: PresrntDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)

        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        
        // MARK: - collectionView
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           reloadData()
       }
    
    private func reloadData() {
        listHeros.removeAll()
        let firstCell = createStartSet()
        if let image = UIImage(named: "Component 17"), let imageData = image.pngData() {
            firstCell.iconImage = imageData
        }

        listHeros.append(firstCell)
        listHeros.append(contentsOf: Array(RealmManager.shared.getObjects(HeroSet.self)))
        view().collectionView.reloadData()
        }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }
    
    private func createStartSet() -> HeroSet {
        
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

// MARK: - UICollectionViewDataSource
extension EditorController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listHeros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt indexPath")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorCollectionCell.identifier, for: indexPath) as! EditorCollectionCell
        let item = listHeros[indexPath.row]
        cell.configure(setHeroBodyPart: item, type: indexPath.row)
        
        // need fix? 
        cell.optionTappedCallback = { [weak self] in
            guard let self = self else { return }
            self.presentEditAlert(
                topCompletion: {
                    print("topCompletion")
                    self.itemDelegate?.presentEditProcessController(hero: item)
                },
                dismissCompletion: { [weak self] in
                    self?.presentTwoVLabelAndTwoHButtonAlert(
                        titleText: "Another Alert",
                        subtitleText: "Another alert's subtitle",
                        leftButtonImageType: .noButton,
                        rightButtonImageType: .deleteButton,
                        leftCompletion: {
                            print("noButton tapped")
                        },
                        rightCompletion: {
                            print("deleteObject button tapped")
                            RealmManager.shared.deleteObject(HeroSet.self, primaryKeyValue: item.id)
                            self?.reloadData()
                        }
                    )
                }
            )
        }
                
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == 0{
            itemDelegate?.presentEditProcessController(hero: listHeros[indexPath.row])
        } else{
            itemDelegate?.presentDetailViewController(herosSet: listHeros,  chosenIndex: indexPath.row)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = 166.0
        let cellHeight = 211.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


// MARK: - ViewSeparatable
extension EditorController: ViewSeparatable {
    typealias RootView = EditirView
}
