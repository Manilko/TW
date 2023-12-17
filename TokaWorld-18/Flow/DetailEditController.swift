//
//  DetailEditController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit
import RealmSwift
import Realm
import PDFKit

final class DetailEditController: UIViewController {
    
    var list: [HeroSet] = []
    var startSetBodyElementSet: HeroSet = HeroSet()
    
    var countEl: Int
    var indexDisplayedHero: Int{
        didSet{
            view().configure(startSet: list[indexDisplayedHero])
        }
    }
    
    
    // MARK: - Properties
    weak var coordinatorDelegate: DetailEditDelegate?
    
    init(item: [HeroSet], index: Int) {
        self.indexDisplayedHero = index
        self.countEl = item.count
        list = item
        let item = item[index]
        
        super.init(nibName: nil, bundle: nil)
        startSetBodyElementSet = HeroSet(value: item)


//        view().configure(startSet: startSetBodyElementSet)
        
        //navView
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
//        view().navView.rightButton.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        
        //navigationButtons
//        view().navigationButtons.totalCount = storyHeroChanges.item.count
//        view().navigationButtons.currentIndex = currentIndex
        view().navigationButtons.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        view().navigationButtons.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        view().editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        view().deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print(" 🗑️☑️  EditProcessController is deinited")
    }

    override func loadView() {
        super.loadView()
        
        self.view = DetailEditView(startSet: startSetBodyElementSet)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func leftButtonTapped() {
//        if currentIndex > 0 {
//            currentIndex -= 1
//            view().navigationButtons.currentIndex = currentIndex
//        }
    }

    @objc func rightButtonTapped() {
//        if currentIndex < storyHeroChanges.item.count - 1 {
//            currentIndex += 1
//            view().navigationButtons.currentIndex = currentIndex
//        }
    }
    
    @objc func editButtonTapped() {
        coordinatorDelegate?.pop(self)
        coordinatorDelegate?.presentEditProcessController(hero: startSetBodyElementSet)
    }

    @objc func deleteButtonTapped() {
        RealmManager.shared.deleteObject(HeroSet.self, primaryKeyValue: startSetBodyElementSet.id)
        self.coordinatorDelegate?.pop(self)
    }
    
    
    @objc private func backDidTaped(_ celector: UIButton) {
            self.coordinatorDelegate?.pop(self)
    }
    
//    @objc private func saveToRealm() {
//    }

}


// MARK: - ViewSeparatable
extension DetailEditController: ViewSeparatable {
    typealias RootView = DetailEditView
}
