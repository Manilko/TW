//
//  DownloadingPictureController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit

final class DownloadPictureController: UIViewController {
    
    // MARK: - Properties
//    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: DownloadPictureDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        
        view().recommendedCollectionView.delegate = self
        view().recommendedCollectionView.dataSource = self
        view().recommendedCollectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: RecommendedCell.identifier)
        
        view().downloadButton.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = DownloadPictureView(ItemModel(title: "", icon: "", discription: ""))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.2870183289, green: 0.5633350015, blue: 0.8874290586, alpha: 1)
    }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
//        sideMenuDelegate?.showSideMenu()
        coordinatorDelegate?.pop(self)
    }
    
    @objc private func downloadFile(_ celector: UIButton) {
        guard let cell = view().recommendedCollectionView.visibleCells.first as? RecommendedCell,
//              cell.ima
                let image = cell.imageView.image else {
              return
          }

          UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
      }

      @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
          if let error = error {
              // Handle the error
              print("Error saving image: \(error.localizedDescription)")
          } else {
              // Image saved successfully
              print("Image saved successfully")
          }
      }

}

extension DownloadPictureController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }

                let item = ItemModel(title: "title", icon: "mocImage", discription: "description")
                cell.configure(with: item)

                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           CGSize(width: 80, height: 180)
       }
    
    
}

// MARK: - ViewSeparatable
extension DownloadPictureController: ViewSeparatable {
    typealias RootView = DownloadPictureView
}

