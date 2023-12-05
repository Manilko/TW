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
                    print(" 🔶  DONE Mods")
                }
                
                let furnitureElementManager = DownloadManager<FurnitureElement>(results: RealmManager.shared.getObjects(FurnitureElement.self))
                modManager.downloadData(nameDirectory: .furniture) {
                    print(" 🔶  DONE Mods")
                }
                
              
                let houseManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
                modManager.downloadData(nameDirectory: .house) {
                    print(" 🔶  DONE Mods")
                }
                
                let recipesManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
                modManager.downloadData(nameDirectory: .recipes) {
                    print(" 🔶  DONE Mods")
                }
                
                let guidesManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
                modManager.downloadData(nameDirectory: .guides) {
                    print(" 🔶  DONE Mods")
                }
                let wallpapersManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
                modManager.downloadData(nameDirectory: .wallpapers) {
                    print(" 🔶  DONE Mods")
                }
                
//                let RecipeManager = DownloadManager<Recipe>(results: RealmManager.shared.getObjects(Recipe.self))
//                modManager.downloadData(nameDirectory: .editor) {
//                    print(" 🔶  DONE Mods")
//                }
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
        
        self.loadingIndicator.setProgress(300, duration: 8) {
            self.coordinatorDelegate?.didSelectScreen(.mods)
        }
        
        
        let width = view.frame.width

        let backgroundImageView = UIImageView(image: UIImage(named: "mocImage"))
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
//            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
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

        progressView = UIView()
        progressView.backgroundColor = .white
        progressView.layer.cornerRadius = 11
        progressView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 22)
        ])

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: progressView.topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: progressView.bottomAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
        ])
    }
}

