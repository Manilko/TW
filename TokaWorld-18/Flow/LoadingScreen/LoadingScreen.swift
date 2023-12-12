//
//  LoadingScreen.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 26.11.2023.
//

import UIKit
import RealmSwift
import Realm

class LoadingScreenViewController: UIViewController {
    
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    let viewModel: LoadingScreenViewModel
    private var loadingLabel = UILabel()
    private var progressView: UIView!
    private var loadingIndicator = LinearLoadingIndicator()
    let containerView = UIView()
    
    var dataDictionary: [JsonPathType: Data?] = [:]{
        didSet{
            dataArray = JsonParsingManager.parseJSON(data: dataDictionary)
        }
    }
    var dataArray: Result<[[JsonPathType: Codable]], ParseError> = .success([]){
        didSet{
        // pay attention to this
            StorageHandler.handleStorage(array: dataArray) {
                let modManager = DownloadManager<Mod>(results: RealmManager.shared.getObjects(Mod.self))
                modManager.downloadData(nameDirectory: .mods) {
                    self.loadingIndicator.updateProgressView(progress: 1 / 7, completion: {})
                    print(" 🔶  DONE Mods")
                }
                
                let furnitureElementManager = DownloadManager<FurnitureElement>(results: RealmManager.shared.getObjects(FurnitureElement.self))
                modManager.downloadData(nameDirectory: .furniture) {
                    self.loadingIndicator.updateProgressView(progress: 2 / 7, completion: {})
                    print(" 🔶  DONE Mods")
                }
                
              
                let houseManager = DownloadManager<HouseIdea>(results: RealmManager.shared.getObjects(HouseIdea.self))
                modManager.downloadData(nameDirectory: .house) {
                    self.loadingIndicator.updateProgressView(progress: 3 / 7, completion: {})
                    print(" 🔶  DONE Mods")
                }
                
                let recipesManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
                modManager.downloadData(nameDirectory: .recipes) {
                    self.loadingIndicator.updateProgressView(progress: 4 / 7, completion: {})
                    print(" 🔶  DONE Mods")
                }
                
                let guidesManager = DownloadManager<Guide>(results: RealmManager.shared.getObjects(Guide.self))
                modManager.downloadData(nameDirectory: .guides) {
                    self.loadingIndicator.updateProgressView(progress: 5 / 7, completion: {})
                    print(" 🔶  DONE Mods")
                }
                let wallpapersManager = DownloadManager<Wallpaper>(results: RealmManager.shared.getObjects(Wallpaper.self))
                modManager.downloadData(nameDirectory: .wallpapers) {
                    self.loadingIndicator.updateProgressView(progress: 6 / 7, completion: {
//                        self.coordinatorDelegate?.didSelectScreen(.mods)
                    })
                    print(" 🔶  DONE Mods")
                }
                
                let editorCategory: [EditorCategory] = Array(RealmManager.shared.getObjects(EditorCategory.self))
                
                let herosElementSet = JsonParsingManager.parseEditorJSON(data: editorCategory)
                guard let herosElementSet else { return }
                for herosElement in herosElementSet {
                    herosElement.downloadPDFs {
                        self.loadingIndicator.updateProgressView(progress: 7 / 7, completion: {
                            self.coordinatorDelegate?.didSelectScreen(.mods)
                        })
                        print("@@@@@@@@>>>>>>>>")
                    }
                }
                

            }
        }
    }


    init(viewModel: LoadingScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red


        configureLayout()
        loadDataWithLoadingIndicator()
        
    }
    
    private func loadDataWithLoadingIndicator() {
        viewModel.getJson(completion: { dictionary in
            self.dataDictionary = dictionary
        })
    }

    private func configureLayout() {
        
        let width = view.frame.width
        
        let imageName = ImageType.loadingBackground
        let image = UIImage(named: imageName)
        let backgroundImageView = UIImageView(image: image)
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.3 * width),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        loadingLabel.text = NSLocalizedString("loading", comment: "")
        loadingLabel.font = UIFont(name: "ReadexPro-Bold", size: 25)
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        let screenWidth = UIScreen.main.bounds.width
        let alertWidth = UIDevice.current.isIPhone ? screenWidth - 40 : screenWidth * 0.6
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.heightAnchor.constraint(equalToConstant: UIDevice.current.isIPhone ? 32 : 40),
            loadingIndicator.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 16),
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: alertWidth),
        ])
    }
}

// MARK: - JsonPathType
//enum JsonPathType: String, CaseIterable {
//    case mods = "/Mods/Mods.json"
//    case furniture = "/Furniture/Furniture.json"
//    case house = "/House_Ideas/House_Ideas.json"
//    case recipes = "/Recipes/Recipes.json"
//    case guides = "/Guides/Guides.json"
//    case wallpapers = "/Wallpapers/Wallpapers.json"
//    case editor = "/json.json"
//    
//    var caseName: String {
//        return String(describing: self)
//    }
//    
//    var correspondingModel: Codable.Type {
//        switch self {
//        case .mods:
//            return Mods.self
//        case .furniture:
//            return Furniture.self
//        case .house:
//            return HouseIdeas.self
//        case .recipes:
//            return Recipes.self
//        case .guides:
//            return Guides.self
//        case .wallpapers:
//            return Wallpapers.self
//        case .editor:
//            return EditorRespondModel.self
//        }
//    }
//}

// MARK: - LoadingScreenViewModel
class LoadingScreenViewModel {
    
    init() {}
    
    func getJson(completion: @escaping ([JsonPathType: Data?]) -> Void) {
        var dataResults: [JsonPathType: Data?] = [:]
        
        let dispatchGroup = DispatchGroup()
        
        JsonPathType.allCases.forEach { jsonPathEnum in
            let jsonPath = jsonPathEnum.rawValue
            dispatchGroup.enter()
            
            ServerManager.shared.downloadJSONFile(filePath: jsonPath) { data in
                //                print("          \(jsonPathEnum.caseName) ✅ \(String(describing: data))")
                dataResults[jsonPathEnum] = data
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(dataResults)
        }
    }
    
    func downloadFile(completion: @escaping ([JsonPathType: Data?]) -> Void) {
        
        //        let results: Results<Wallpapers>
        //        let array: [Wallpapers]
        //
        //        results = RealmManager.shared.getObjects(Wallpapers.self)
        //        array = Array(RealmManager.shared.getObjects(Wallpapers.self))
        //
        //        let herosElementSet = JsonParsingManager.parseJSON(data: array)
        //        guard let herosElementSet = herosElementSet else { return }
        //        for i in herosElementSet {
        //            i.downloadPDFs {
        //                print("@@@@@@@@>>>>>>>>")
        //            }
        //        }
    }
}

