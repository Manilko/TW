//
//  DetailEditController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

//final class DetailEditController: UIViewController {
//    
//    // MARK: - Properties
////    weak var sideMenuDelegate: SideMenuDelegate?
//    weak var coordinatorDelegate: DetailEditDelegate?
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        //        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
//        //        
//        //        view().recommendedCollectionView.delegate = self
//        //        view().recommendedCollectionView.dataSource = self
//        //        view().recommendedCollectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: RecommendedCell.identifier)
//        //        
//        //        view().downloadButton.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
//        
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func loadView() {
//        super.loadView()
////        self.view = DetailEditView(ItemModel(title: "", icon: "", discription: ""))
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//    }
//    
//    @objc private func menuDidTaped(_ celector: UIButton) {
////        sideMenuDelegate?.showSideMenu()
//        coordinatorDelegate?.pop(self)
//    }
//    
////    @objc private func downloadFile(_ celector: UIButton) {
////        guard let cell = view().recommendedCollectionView.visibleCells.first as? RecommendedCell,
//////              cell.ima
////                let image = cell.imageView.image else {
////              return
////          }
////
////          UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
////      }
////
////      @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
////          if let error = error {
////              // Handle the error
////              print("Error saving image: \(error.localizedDescription)")
////          } else {
////              // Image saved successfully
////              print("Image saved successfully")
////          }
////      }
//
//}
//
//extension DetailEditController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }
//
//                let item = ItemModel(title: "title", icon: "mocImage", discription: "description")
//                cell.configure(with: item)
//
//                return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           CGSize(width: 80, height: 180)
//       }
//    
//    
//}
//
//// MARK: - ViewSeparatable
//extension DetailEditController: ViewSeparatable {
//    typealias RootView = DetailEditView
//}
