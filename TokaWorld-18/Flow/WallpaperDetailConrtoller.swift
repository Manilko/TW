//
//  WallpaperDetailConrtoller.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import RealmSwift
import Realm

final class WallpaperDetailConrtoller: UIViewController {
    
    // MARK: - Properties
    weak var coordinatorDelegate: WallpaperDetailDelegate?
    let model: Wallpaper?
    let recommended: [Wallpaper]
    
    init(item: Wallpaper, recommended: [Wallpaper]) {
        self.model = item
        self.recommended = recommended
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(favoriteDidTaped), for: .touchUpInside)
               
        view().downloadButton.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = WallpaperDetailView(isFavorite: model?.favorites ?? false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view().configure(with: model ?? Wallpaper())
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
        guard let image = view().imageView.image else { return }

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

// MARK: - ViewSeparatable
extension WallpaperDetailConrtoller: ViewSeparatable {
    typealias RootView = WallpaperDetailView
}
