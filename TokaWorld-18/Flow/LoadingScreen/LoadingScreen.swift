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

                self.loadingIndicator.updateProgressView(progress: 1 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 2 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 3 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 4 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 5 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 6 / 7, completion: {})

                self.loadingIndicator.updateProgressView(progress: 7 / 7, completion: {
//                     check sub
                    self.changeVC()
                    
                })

            }
        }
    }

    func changeVC() {
        if configs.unlockOne {
            self.coordinatorDelegate?.didSelectScreen(.mods)
            return
        }
        if configs.unlockTwo {
            self.coordinatorDelegate?.didSelectScreen(.editor)
            return
        }
        if configs.unlockThree {
            self.coordinatorDelegate?.didSelectScreen(.furniture)
            return
        }
        self.coordinatorDelegate?.didSelectScreen(.houseIdeas)
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
        
        loadingLabel.text = NSLocalizedString("Loading", comment: "")
        loadingLabel.font = .customFont(type: .lilitaOne, size: 32)
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
