//
//  DetailEditView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

//final class DetailEditView: UIView{
//   
//   // MARK: - Properties
//    var navView = NavigationView(leftButtonType: .left, title: "Download Picture", rightButtonType: ImageNameNawMenuType.filter)
////    let navView = NavigationView
//    
//    lazy var detailModsView: DetailModsView = {
//       let view = DetailModsView()
//       view.translatesAutoresizingMaskIntoConstraints = false
//       return view
//     }()
//
//   lazy var recommendedCollectionView: UICollectionView = {
//       let layout = UICollectionViewFlowLayout()
//       layout.scrollDirection = .vertical
//
//       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//       collectionView.translatesAutoresizingMaskIntoConstraints = false
//      return collectionView
//    }()
//    
//    lazy var downloadButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .blue
//        button.tintColor = .white
//        button.setTitle("Download File", for: .normal)
//       return button
//     }()
//
//   // MARK: - Lifecycle
//    required init(_ model: ItemModel) {
//        // fix it________________
//        let imageNameNawMenuType: ImageNameNawMenuType
//        if model.isFavorite{
//            imageNameNawMenuType = .favorite
//        } else{
//            imageNameNawMenuType = .unFavorite
//        }
//        navView = NavigationView(leftButtonType: .left, title: "Download Picture", rightButtonType: imageNameNawMenuType)
//        //________________
//       super.init(frame: .zero)
//
//       configureLayout()
//   }
//
//   required init?(coder: NSCoder) {
//       fatalError("init(coder:) has not been implemented")
//   }
//
//   override func layoutSubviews() {
//       super.layoutSubviews()
////       tableView.reloadData()
//   }
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//    }
//
//
//   private func configureLayout() {
//       
//       addSubview(navView)
//       addSubview(recommendedCollectionView)
//       addSubview(detailModsView)
//       addSubview(downloadButton)
//       
//
//       navView.translatesAutoresizingMaskIntoConstraints = false
//       NSLayoutConstraint.activate([
//           
//           navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
//           navView.leadingAnchor.constraint(equalTo: leadingAnchor),
//           navView.widthAnchor.constraint(equalTo: widthAnchor),
//           navView.heightAnchor.constraint(equalToConstant: 100),
//           
//           detailModsView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 40),
//           detailModsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
//           detailModsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
//           detailModsView.heightAnchor.constraint(equalToConstant: 300),
//           
//           downloadButton.topAnchor.constraint(equalTo: detailModsView.bottomAnchor, constant: 40),
//           downloadButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
//           downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
//           downloadButton.heightAnchor.constraint(equalToConstant: 80),
//   
//           recommendedCollectionView.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 40),
//           recommendedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
//           recommendedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
//           recommendedCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//
//       ])
//   }
//}
//
//
