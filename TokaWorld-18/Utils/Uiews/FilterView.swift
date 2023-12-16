//
//  FilterView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 15.11.2023.
//

import UIKit

// MARK: - FilterType
enum FilterType: Int, CaseIterable {
    case all = 0
    case new
    case favorite
    case top
    
    var title: String {
        switch self {
        case .all:
            "All"
        case .new:
            "New"
        case .favorite:
            "Favorite"
        case .top:
            "Top"
        }
    }
    
    
}

// MARK: - FilterView
class FilterView: UIView {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        view.layer.cornerRadius = 40
        
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 40)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 5
        layer0.shadowOffset = CGSize(width: 0, height: -4)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeButton: RoundButton = {
        let button = RoundButton()
        button.setImageA(UIImage.image(name: "close"))
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(closeButton)
        mainView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            mainView.heightAnchor.constraint(equalToConstant: 148),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
    }
    
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("didSelectItemAt \(indexPath.row)")
//    }
//    
//      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//          FilterType.allCases.count
//      }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
//        // Configure the cell as needed
//        cell.textLabel.text = "Cell \(indexPath.item)"
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDelegateFlowLayout
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width / 4.4, height: 200)
//    }
//    
//    // MARK: - Target Action
//    
//    @objc private func closeButtonTapped() {
//        self.isHidden = true
//    }
}


// MARK: - MyCollectionViewCell

class MyCollectionViewCell: UICollectionViewCell {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .backgroundWhite
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(filter: FilterType, flag: FilterType) {
        textLabel.text = filter.title
        
        if filter == flag {
            textLabel.textColor = .mainBlue
        } else {
            textLabel.textColor = .lettersBlack
        }
    }
}
