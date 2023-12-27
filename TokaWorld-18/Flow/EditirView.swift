//
//  EditirView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class EditirView: UIView {

    let navView = NavigationView(leftButtonType: .menu, title: "Editor", rightButtonType: ImageNameNawMenuType.none)
    
    var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(EditorCollectionCell.self, forCellWithReuseIdentifier: EditorCollectionCell.identifier)
        return collectionView
    }()
    
    private let lackLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.text = "You don’t have any characters yet"
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.mainBlue
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 2
        button.layer.borderColor = .borderColorWhite.cgColor
        button.titleLabel?.font = .customFont(type: .lilitaOne, size: 24)
        button.titleLabel?.textColor = .lettersWhite
        button.setTitle("Add new", for: .normal)
        return button
    }()
    
    lazy var hStack: UIStackView = {
        let h = UIStackView(arrangedSubviews: [lackLabel, addButton])
        h.axis = .vertical
        h.alignment = .fill
        h.distribution = .fillEqually
        h.spacing = 20
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    let downloadingView: EditorDownloadContentView = {
        let v = EditorDownloadContentView()
        v.updateProgressView(progress: 0.001)
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(arrangedSubviews: [downloadingView])
        v.axis = .vertical
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    required init() {
        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(backgroundView)
        addSubview(navView)
        addSubview(hStack)
        addSubview(collectionView)
        
        addSubview(vStack)
        
        backgroundColor = .backgroundBlue
        navView.translatesAutoresizingMaskIntoConstraints = false
        hStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 100),

            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 150),
            
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            downloadingView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
        ])
    }
}
