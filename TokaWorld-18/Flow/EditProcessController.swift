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
    
    var storyCharacterChanges: StoryCharacterChanges = StoryCharacterChanges()
    
    // MARK: - Properties
    weak var coordinatorDelegate: EditProcessDelegate?
    
    init(item: String) {
        super.init(nibName: nil, bundle: nil)
        
        
        let editorCategory: [EditorCategory] = Array(RealmManager.shared.getObjects(EditorCategory.self))
        
        let herosElementSet = JsonParsingManager.parseEditorJSON(data: editorCategory)
        guard let herosElementSet else { return }
//        for herosElement in herosElementSet {
//            herosElement.downloadPDFs {   ///   <-    move to load screen
//                print("@@@@@@@@>>>>>>>>")
//            }
//        }
        let sortedHerosElementSet  = herosElementSet.sorted { $0.hierarchy < $1.hierarchy }
        
        let herosElementlist = List<BodyPart>()
        herosElementlist.append(objectsIn: sortedHerosElementSet)
        
        let herosBodyElementSet = HeroSet(item: herosElementlist)
//        let storyCharacterChanges = StoryCharacterChanges()
        storyCharacterChanges.item.append(herosBodyElementSet)
        
        
        
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
        
        self.view = EditProcessView(storyChanges: storyCharacterChanges)
        
        let editorCategory = RealmManager.shared.getObjects(HeroSet.self)
        print(">>>>>>>editorCategory      \(editorCategory.count)")

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
