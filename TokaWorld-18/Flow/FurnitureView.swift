//
//  FurnitureView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.12.2023.
//

import UIKit

// MARK: - class ModsView
final class FurnitureView: UIView {
    
    let navView = NavigationView(leftButtonType: .menu, title: "Furniture", rightButtonType: ImageNameNawMenuType.filter)
    let searchView = SearchView()
    
    lazy var filterView: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c.backgroundColor = .clear
        c.showsVerticalScrollIndicator = false
        return c
    }()
    
    private var searchViewHeightConstraint: NSLayoutConstraint!
    
    required init() {
        super.init(frame: .zero)
        
        configureLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    private func configureLayout() {
        
        addSubview(navView)
        addSubview(searchView)
        addSubview(collectionView)
        addSubview(filterView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),
            
            searchView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            filterView.topAnchor.constraint(equalTo: topAnchor),
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        filterView.isHidden = true
        
        searchViewHeightConstraint = searchView.heightAnchor.constraint(equalToConstant: 310)
        searchViewHeightConstraint.isActive = true
    }
}

