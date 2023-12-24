//
//  ViewMod.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 26.11.2023.
//

import UIKit

// MARK: - class ModsView
final class ModsView: UIView {
    
    let navView = NavigationView(leftButtonType: .menu, title: "Mods", rightButtonType: ImageNameNawMenuType.filter)
    let searchView = SearchView()
    
    lazy var filterView: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var modcCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
//    private var searchViewHeightConstraint: NSLayoutConstraint!
    
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
        modcCollectionView.reloadData()
    }
    
    private func configureLayout() {
        
        addSubview(navView)
        addSubview(modcCollectionView)
        addSubview(searchView)
        addSubview(filterView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        modcCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),
            
            searchView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            
            modcCollectionView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 84),
            modcCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            modcCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            modcCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            filterView.topAnchor.constraint(equalTo: topAnchor),
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        filterView.isHidden = true
//        bringSubviewToFront(searchView)
        
//        searchViewHeightConstraint = searchView.heightAnchor.constraint(equalToConstant: 310)
//        searchViewHeightConstraint.isActive = true
    }
}
