//
//  LoadingScreen.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 26.11.2023.
//

import UIKit
import RealmSwift

class LoadingScreenViewController: UIViewController {
    
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    let viewModel: LoadingScreenViewModel
    private var loadingLabel = UILabel()
    private var progressView: UIView!
    private var loadingIndicator = LinearLoadingIndicator()
    let containerView = UIView()
    
    init(viewModel: LoadingScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        fetchData()
    }
    
    //bad idea, need to fix it
    private func loadDataWithLoadingIndicator() {
        viewModel.getJson { res in
            let array = JsonParsingManager.parseJSON(data: res)
            switch array {
            case .success(let parsedResults):
                for result in parsedResults {
                    for (key, value) in result {
                        switch key {
                        case .mods:
                            if let convertedData = value as? Mods {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 1 / 6)
                            }
                        case .furniture:
                            if let convertedData = value as? Furniture {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 2 / 6)
                            }
                        case .house:
                            if let convertedData = value as? HouseIdeas {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 3 / 6)
                            }
                        case .recipes:
                            if let convertedData = value as? Recipes {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 4 / 6)
                            }
                        case .guides:
                            if let convertedData = value as? Guides {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 5 / 6)
                            }
                        case .wallpapers:
                            if let convertedData = value as? Wallpapers {
                                RealmManager.shared.add(convertedData.item)
                                self.updateProgressView(progress: 6 / 6)
                            }
                        case .editor:
                            if let convertedData = value as? EditorRespondModel {
                                if !RealmManager.shared.isDataExist(EditorRespondModel.self, primaryKeyValue: convertedData.id as Any) {
                                    RealmManager.shared.add(convertedData)
                                }
                            }
                        }
                    }
                }
                
            case .failure(let error):
                switch error {
                case .noData(let jsonPath):
                    print("Error: No data found for \(jsonPath)")
                case .decodingError(let jsonPath, let decodingError):
                    print("Error decoding JSON for \(jsonPath): \(decodingError)")
                }
            }
        }
    }
    
    private func fetchData() {
        if NetworkMonitoring.isConnection {
            configureLayout()
            loadDataWithLoadingIndicator()
            updateProgressView(progress: 0)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.fetchData()
            }
        }
    }
    
    func updateProgressView(progress: CGFloat) {
        self.loadingIndicator.updateProgressView(progress: progress) {
            self.coordinatorDelegate?.didSelectScreen(.mods)
        }
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
//            loadingIndicator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            loadingIndicator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
}

// MARK: - JsonPathType
enum JsonPathType: String, CaseIterable {
    case mods = "/Mods/Mods.json"
    case furniture = "/Furniture/Furniture.json"
    case house = "/House_Ideas/House_Ideas.json"
    case recipes = "/Recipes/Recipes.json"
    case guides = "/Guides/Guides.json"
    case wallpapers = "/Wallpapers/Wallpapers.json"
    case editor = "/json.json"
    
    var caseName: String {
        return String(describing: self)
    }
    
    var correspondingModel: Codable.Type {
        switch self {
        case .mods:
            return Mods.self
        case .furniture:
            return Furniture.self
        case .house:
            return HouseIdeas.self
        case .recipes:
            return Recipes.self
        case .guides:
            return Guides.self
        case .wallpapers:
            return Wallpapers.self
        case .editor:
            return EditorRespondModel.self
        }
    }
}

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

