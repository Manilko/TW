//
//  FurnitureDetailController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.12.2023.
//

import UIKit

final class FurnitureDetailController: UIViewController {
    
    // MARK: - Properties
    weak var coordinatorDelegate: FurnitureDetailDelegate?
    let model: FurnitureElement?
    let recommended: [FurnitureElement]
    
    init(item: FurnitureElement, recommended: [FurnitureElement]) {
        self.model = item
        self.recommended = recommended
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(favoriteDidTaped), for: .touchUpInside)
        
        view().recommendedCollectionView.delegate = self
        view().recommendedCollectionView.dataSource = self
        view().recommendedCollectionView.register(FurnitureRecommendedCell.self, forCellWithReuseIdentifier: FurnitureRecommendedCell.identifier)
        
        view().downloadButton.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = FurnitureDetailView(isFavorite: model?.favorites ?? false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view().detailFurnitureView.configure(with: model ?? FurnitureElement())
    }
    
    @objc private func backDidTaped(_ celector: UIButton) {
        coordinatorDelegate?.pop(self)
    }
    
    @objc private func favoriteDidTaped(_ celector: RoundButton) {
        guard let model = model else { return }

        RealmManager.shared.runTransaction {
            if model.favorites {
                model.favorites = false
                view().navView.updateFavoriteButton(false)
            } else {
                model.favorites = true
                view().navView.updateFavoriteButton(true)
            }
        }
    }
    
    @objc private func downloadFile(_ celector: UIButton) {
        guard let cell = view().recommendedCollectionView.visibleCells.first as? FurnitureRecommendedCell,
                let image = cell.imageView.image else { return }

          UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
      }

      @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
          if let error = error {
              print("Error saving image: \(error.localizedDescription)")
          } else {
              print("Image saved successfully")
          }
      }

}

extension FurnitureDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FurnitureRecommendedCell.identifier, for: indexPath) as? FurnitureRecommendedCell else { return UICollectionViewCell() }
//        cell.configure(with: recommended[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - ViewSeparatable
extension FurnitureDetailController: ViewSeparatable {
    typealias RootView = FurnitureDetailView
}

