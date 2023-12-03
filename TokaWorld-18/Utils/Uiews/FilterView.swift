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
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        backgroundColor = .white.withAlphaComponent(0.5)
        addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(closeButton)
        mainView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            mainView.heightAnchor.constraint(equalToConstant: 250),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
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
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
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
        backgroundColor = .blue
        layer.cornerRadius = 8
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
