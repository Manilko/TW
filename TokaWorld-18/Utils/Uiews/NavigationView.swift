//
//  NavigationView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 10.11.2023.
//

import UIKit


class NavigationView: UIView {

    let leftButton:  RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()

    let rightButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .customFont(type: .lilitaOne, size: 28)
        titleLabel.contentMode = .center
        
        return titleLabel
    }()

    // MARK: - Initialization

    required init(leftButtonType: ImageNameNawMenuType, title: String, rightButtonType: ImageNameNawMenuType) {
//        required init(leftButtonType: ImageNameNawMenuType, title: SideMenuType, rightButtonType: ImageNameNawMenuType) {
        super.init(frame: .zero)

        setupButton(leftButton, withImageName: leftButtonType)
        setupButton(rightButton, withImageName: rightButtonType)
        
        titleLabel.text = title
        //        titleLabel.text = title.title
        
        setupViews()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View Setup
    
    private func setupButton(_ button: RoundButton, withImageName: ImageNameNawMenuType) {
        if withImageName == .none {
            button.isHidden = true
        } else{
            button.setImageA(UIImage.image(name: withImageName.rawValue))
        }
    }
    
    private func setupButton(_ button: RoundButton, withImageName: ImageType?) {
        if withImageName == nil {
            button.isHidden = true
        } else{
            button.setImage(UIImage.image(name: withImageName?.rawValue ?? ""), for: .normal)
        }
    }
    
    func updateFavoriteButton(_ button: Bool) {
        let imageType: ImageNameNawMenuType = button ? .favorite : .unFavorite
        rightButton.setImageA(UIImage.image(name: imageType.rawValue))
    }

    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            leftButton.heightAnchor.constraint(equalToConstant: 40),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 40),
            rightButton.heightAnchor.constraint(equalToConstant: 40),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

//class NavigationButton: UIView {
//
//    let leftButton:  RoundButton = {
//        let button = RoundButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
//        return button
//    }()
//
//    let rightButton: RoundButton = {
//        let button = RoundButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
//        return button
//    }()
//
//    // MARK: - Initialization
//
//    required init(leftButtonType: ImageNameNawMenuType, rightButtonType: ImageNameNawMenuType) {
//        super.init(frame: .zero)
//
//        setupButton(leftButton, withImageName: .leftGray)
//        setupButton(rightButton, withImageName: .rightGray)
//        
//        setupViews()
//    }
//    
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//
//    // MARK: - View Setup
//    
//    private func setupButton(_ button: RoundButton, withImageName: ImageNameNawMenuType) {
//        if withImageName == .none {
//            button.isHidden = true
//        } else{
//            button.setImageA(UIImage.image(name: withImageName.rawValue))
//        }
//    }
//    
//    private func setupButton(_ button: RoundButton, withImageName: ImageType?) {
//        if withImageName == nil {
//            button.isHidden = true
//        } else{
//            button.setImage(UIImage.image(name: withImageName?.rawValue ?? ""), for: .normal)
//        }
//    }
//    
//    func updateFavoriteButton(_ button: Bool) {
//        let imageType: ImageNameNawMenuType = button ? .favorite : .unFavorite
//        rightButton.setImageA(UIImage.image(name: imageType.rawValue))
//    }
//
//    private func setupViews() {
//        backgroundColor = .clear
//        
//        addSubview(leftButton)
//        addSubview(rightButton)
//
//        NSLayoutConstraint.activate([
//            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            leftButton.widthAnchor.constraint(equalToConstant: 40),
//            leftButton.heightAnchor.constraint(equalToConstant: 40),
//            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//
//            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            rightButton.widthAnchor.constraint(equalToConstant: 40),
//            rightButton.heightAnchor.constraint(equalToConstant: 40),
//            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//        ])
//    }
//}


//
//let arrey = [1,2,3,4,5]

//class ViewController: UIViewController {
//    let array = [1, 2, 3, 4, 5]
//    var currentIndex: Int = 0
//    var navigationButton: NavigationButtons!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationButton = NavigationButtons()
//        navigationButton.totalCount = array.count
//        navigationButton.currentIndex = currentIndex
//        navigationButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(navigationButton)
//
//        NSLayoutConstraint.activate([
//            navigationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            navigationButton.widthAnchor.constraint(equalToConstant: 150),
//            navigationButton.heightAnchor.constraint(equalToConstant: 40),
//            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//
//        // Now you can handle button actions or update currentIndex as needed
//        navigationButton.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
//        navigationButton.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
//    }
//
//    @objc func leftButtonTapped() {
//        if currentIndex > 0 {
//            currentIndex -= 1
//            updateNavigationButton()
//        }
//    }
//
//    @objc func rightButtonTapped() {
//        if currentIndex < array.count - 1 {
//            currentIndex += 1
//            updateNavigationButton()
//        }
//    }
//
//    private func updateNavigationButton() {
//        navigationButton.currentIndex = currentIndex
//    }
//}

class NavigationButtons: UIView {

    let leftButton:  RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()

    let rightButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()

    var currentIndex: Int = 0 {
        didSet {
            updateButtonAppearance()
        }
    }

    var totalCount: Int = 0 {
        didSet {
            updateButtonAppearance()
        }
    }

    // MARK: - Initialization

    required init() {
        super.init(frame: .zero)

        setupButton(leftButton, withImageName: .leftGray)
        setupButton(rightButton, withImageName: .rightGray)

        setupViews()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func setupButton(_ button: RoundButton, withImageName: ImageNameNawMenuType) {
        if withImageName == .none {
            button.isHidden = true
        } else {
            button.setImageA(UIImage.image(name: withImageName.rawValue))
        }
    }

    private func updateButtonAppearance() {
        leftButton.isEnabled = currentIndex > 0
        rightButton.isEnabled = currentIndex < totalCount - 1

        let leftImageName = leftButton.isEnabled ? ImageNameNawMenuType.leftBlue : ImageNameNawMenuType.leftGray
        let rightImageName = rightButton.isEnabled ? ImageNameNawMenuType.rightBlue : ImageNameNawMenuType.rightGray

        leftButton.setImageA(UIImage.image(name: leftImageName.rawValue))
        rightButton.setImageA(UIImage.image(name: rightImageName.rawValue))
    }

    private func setupViews() {
        backgroundColor = .clear

        addSubview(leftButton)
        addSubview(rightButton)

        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            leftButton.heightAnchor.constraint(equalToConstant: 40),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 40),
            rightButton.heightAnchor.constraint(equalToConstant: 40),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
