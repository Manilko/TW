//
//  CollectionViewContainer.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 02.12.2023.
//

import UIKit
import RealmSwift
import Realm


class CollectionViewContainer: UIView {
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let elementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    private func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 40
        addSubview(categoryCollectionView)
        addSubview(elementCollectionView)
        
        NSLayoutConstraint.activate([

            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Sizes.leading),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            categoryCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.editorCategoryColViewTop),
            categoryCollectionView.heightAnchor.constraint(equalToConstant:Sizes.editorCategoryCellHeight),
            
            elementCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  Sizes.leading),
            elementCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            elementCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: Sizes.editorCategoryColViewTop),
            elementCollectionView.heightAnchor.constraint(equalToConstant:Sizes.editorElementCellHeight),
        ])
        
    }
        
}
