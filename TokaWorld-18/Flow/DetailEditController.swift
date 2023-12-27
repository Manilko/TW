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
    
    var list: [HeroSet]
    
    var countHeros: Int
    
    var indexDisplayedHero: Int{
        didSet{
            updateNavigationButtons()
        }
    }
    
    
    // MARK: - Properties
    weak var coordinatorDelegate: DetailEditDelegate?
    
    init(item: [HeroSet], index: Int) {
        self.indexDisplayedHero = index
        self.countHeros = item.count
        self.list = item
        
        super.init(nibName: nil, bundle: nil)
        
        //navView
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(saveToGallery), for: .touchUpInside)
        
        //navigationButtons
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
        
        self.view = DetailEditView(startSet: list[indexDisplayedHero])
        updateNavigationButtons()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateNavigationButtons() {

        view().navigationButtons.currentIndex = indexDisplayedHero
        view().navigationButtons.totalCount = countHeros

        view().configure(startSet: list[indexDisplayedHero])
    }

    @objc func leftButtonTapped() {
            indexDisplayedHero -= 1
    }

    @objc func rightButtonTapped() {
            indexDisplayedHero += 1
    }

    
    @objc func editButtonTapped() {
        coordinatorDelegate?.pop(self)
        coordinatorDelegate?.presentEditProcessController(hero: list[indexDisplayedHero])
    }

    @objc func deleteButtonTapped() {
        RealmManager.shared.deleteObject(HeroSet.self, primaryKeyValue: list[indexDisplayedHero].id)
        self.coordinatorDelegate?.pop(self)
    }
    
    
    @objc private func backDidTaped(_ celector: UIButton) {
            self.coordinatorDelegate?.pop(self)
    }
    
    @objc private func saveToGallery() {
        guard let imageData: Data = Data?.createImageData(from: view().characterView),
              let image = UIImage(data: imageData) else {
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
        }
    }
}


// MARK: - ViewSeparatable
extension DetailEditController: ViewSeparatable {
    typealias RootView = DetailEditView
}
