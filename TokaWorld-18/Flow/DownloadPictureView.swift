//
//  DownloadPictureView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class DownloadPictureView: UIView{
   
   // MARK: - Properties
    var navView: NavigationView
    
    lazy var detailModsView: DetailModsView = {
        let view = DetailModsView()
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 2
        view.layer.borderColor = .borderColorWhite.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
     }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lettersBlack
        label.font = .customFont(type: .lilitaOne, size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.87
        label.attributedText = NSMutableAttributedString(string: "Recommended", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    lazy var recommendedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundWhite
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var downloadButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 2
        button.layer.borderColor = .borderColorWhite.cgColor
        button.titleLabel?.font = .customFont(type: .lilitaOne, size: 20)
        button.titleLabel?.textColor = .lettersWhite
        button.setTitle("Download File", for: .normal)
       return button
     }()

   // MARK: - Lifecycle
    init(isFavorite: Bool) {
        let rightButtonType: ImageNameNawMenuType = isFavorite ? .favorite : .unFavorite
        navView = NavigationView(leftButtonType: .leftArrow, title: "Download Picture", rightButtonType: rightButtonType)
              
       super.init(frame: .zero)
       configureLayout()

   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   private func configureLayout() {
       backgroundColor = .backgroundWhite
       
       addSubview(navView)
       addSubview(recommendedCollectionView)
       addSubview(detailModsView)
       addSubview(downloadButton)
       addSubview(titleLabel)
       
       navView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),

            detailModsView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
            detailModsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            detailModsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            detailModsView.heightAnchor.constraint(equalToConstant: 480),

            downloadButton.topAnchor.constraint(equalTo: detailModsView.bottomAnchor, constant: 12),
            downloadButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 52),
            
            titleLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            recommendedCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            recommendedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recommendedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            recommendedCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0),

       ])
   }
}
