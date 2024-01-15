//
//  DownloadingPictureController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit
import RealmSwift
import Realm

final class DownloadPictureController: UIViewController {
    
    // MARK: - Properties
    weak var coordinatorDelegate: DownloadPictureDelegate?
    let model: Mod?
    let recommended: [Mod]
    
    init(item: Mod, recommended: [Mod]) {
        self.model = item
        self.recommended = recommended
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(backDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(favoriteDidTaped), for: .touchUpInside)
        
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
        self.view = DownloadPictureView(isFavorite: model?.favorites ?? false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view().detailModsView.configure(with: model ?? Mod())
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
        let path = model?.rd1Lf3 ?? "1"
        print(model?.rd1Lf3)
        let str = "/Mods/" + path
        
        
        let name = str

        let fileManager = FileManager.default

        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        var fileName = str

        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if !fileManager.fileExists(atPath: fileURL.path) {
            ServerManager.shared.getData(forPath: fileName) { data in
                if let data = data {
                    print(" ℹ️  data at: \(data)")
                    saveDataToFileManager(data: data, fileURL: fileURL)
                }
            }
        } else {
            print(" ℹ️  File already exists: \(fileURL)")
            coordinatorDelegate?.showActivityController_preTok(fileURL: fileURL, completedCompletion: {
                print(" ✅  File saved")
            })
        }
        
        
        func saveDataToFileManager(data: Data, fileURL: URL) {
            do {
                let directoryURL = fileURL.deletingLastPathComponent()
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                try data.write(to: fileURL)
                print(" ✅  File saved successfully at: \(fileURL)")
                coordinatorDelegate?.showActivityController_preTok(fileURL: fileURL, completedCompletion: {
                    print(" ✅  File saved")
                })
            } catch {
                print(" ⛔ Error saving file: \(error)")
            }
        }
        
      }
    
    

      @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
          if let error = error {
              print("Error saving image: \(error.localizedDescription)")
          } else {
              print("Image saved successfully")
          }
      }

}

extension DownloadPictureController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }
        cell.configure(with: recommended[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - ViewSeparatable
extension DownloadPictureController: ViewSeparatable {
    typealias RootView = DownloadPictureView
}
