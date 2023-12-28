//
//  WallpaperView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

// MARK: - class ModsView
final class WallpaperView: UIView {
    
    let navView = NavigationView(leftButtonType: .menu, title: "Wallpaper", rightButtonType: ImageNameNawMenuType.filter)
//    let searchView = SearchView()
    
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
    
    private let lackLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(type: .lilitaOne, size: 20)
        label.text = "We didn’t find anything"
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
        
        addSubview(backgroundView)
        addSubview(lackLabel)
        addSubview(navView)
        addSubview(modcCollectionView)
//        addSubview(searchView)
        addSubview(filterView)
        
//        searchView.translatesAutoresizingMaskIntoConstraints = false
        navView.translatesAutoresizingMaskIntoConstraints = false
        modcCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lackLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lackLabel.heightAnchor.constraint(equalToConstant: 150),
            
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),
            
//            searchView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
//            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
//            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            
            modcCollectionView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 24),
            modcCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.leading),
            modcCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Sizes.trailing),
            modcCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            filterView.topAnchor.constraint(equalTo: topAnchor),
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        filterView.isHidden = true
    }
}

