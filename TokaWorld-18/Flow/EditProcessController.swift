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
    
    var startSetBodyElementSet: HeroSet = HeroSet()
    
    // MARK: - Properties
    weak var coordinatorDelegate: EditProcessDelegate?
    
    init(item: HeroSet) {
        
        super.init(nibName: nil, bundle: nil)
        startSetBodyElementSet = HeroSet(value: item)
        
        let editorCategory: [EditorCategory] = Array(RealmManager.shared.getObjects(EditorCategory.self))
        
        let herosElementSet = JsonParsingManager.parseEditorJSON(data: editorCategory)
        guard let herosElementSet else { return }
//        for herosElement in herosElementSet {
//            herosElement.downloadPDFs {   ///   <-    move to load screen
//                print("@@@@@@@@>>>>>>>>")
//            }
//        }

        
        
        
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
        
        self.view = EditProcessView(startSet: startSetBodyElementSet)


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }
    
    @objc private func leftDidTaped(_ celector: UIButton) {
        coordinatorDelegate?.pop(self)
    }

}


// MARK: - ViewSeparatable
extension EditProcessController: ViewSeparatable {
    typealias RootView = EditProcessView
}
