//
//  WallpaperController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import RealmSwift
import Realm

final class WallpaperController: UIViewController {

    var arrayMod: [Wallpaper]

    var filterFlag: FilterType
    private var searchResults: [Wallpaper] = []
    private var filteredCollection: [Wallpaper] = []

    // MARK: - Properties
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    weak var itemDelegate: WallpaperPresrntDelegate?

    private lazy var modView = WallpaperView(frame: UIScreen.main.bounds)

    init() {
        self.filterFlag = .all
        self.arrayMod = Array(RealmManager.shared.getObjects(Wallpaper.self))

        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlue

        modView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(modView)

        NSLayoutConstraint.activate([
            modView.topAnchor.constraint(equalTo: view.topAnchor),
            modView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupSubViews()

        filteredCollection = filterCollection(arrayMod, by: .all)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        arrayMod.removeAll()
        arrayMod = Array(RealmManager.shared.getObjects(Wallpaper.self))
        modView.modcCollectionView.reloadData()
    }

    private func filterCollection(_ collection: [Wallpaper], by filterType: FilterType) -> [Wallpaper] {
        switch filterType {
        case .all:
            return collection
        case .new:
            return collection.filter { $0.isNew }
        case .favorite:
            return collection.filter { $0.favorites }
        case .top:
            return collection.filter { $0.isTop }
        }
    }

    func setupSubViews() {
        modView.navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        modView.navView.rightButton.addTarget(self, action: #selector(showContainerButtonTapped), for: .touchUpInside)

        modView.modcCollectionView.register(WallpaperCell.self, forCellWithReuseIdentifier: WallpaperCell.identifier)
        modView.modcCollectionView.delegate = self
        modView.modcCollectionView.dataSource = self

        // MARK: - filterView
        modView.filterView.collectionView.dataSource = self
        modView.filterView.collectionView.delegate = self
        modView.filterView.collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        modView.filterView.closeButton.addTarget(self, action: #selector(closeButtonTappedFilterView), for: .touchUpInside)
    }

    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }

    @objc private func showContainerButtonTapped(_ celector: UIButton) {
        modView.filterView.isHidden = false
    }
}

// MARK: - filterView UICollectionViewDataSource
extension WallpaperController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == modView.filterView.collectionView {
            guard let selectedFilter = FilterType(rawValue: indexPath.item) else { return }

            filterFlag = selectedFilter
            modView.filterView.collectionView.reloadData()

            filteredCollection = filterCollection(arrayMod, by: selectedFilter)

            modView.modcCollectionView.reloadData()
            modView.filterView.isHidden = true
        } else if collectionView == modView.modcCollectionView {
            let item = filteredCollection[indexPath.row]
            let recommended: [Wallpaper] = []
            itemDelegate?.presentDetailViewController(with: item, recommended: recommended)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == modView.filterView.collectionView {
            return FilterType.allCases.count
        }  else if collectionView == modView.modcCollectionView {
            return filteredCollection.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == modView.filterView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell

            let filterType = FilterType(rawValue: indexPath.item) ?? .all
            cell.configure(filter: filterType, flag: filterFlag)

            return cell
        } else if collectionView == modView.modcCollectionView {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.identifier, for: indexPath) as? WallpaperCell
            else { return UICollectionViewCell() }
            // create service for configuration cell
            let item = arrayMod[indexPath.row]

            cell.configure(with: item)
            return cell

        }
        return UICollectionViewCell()
    }

    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == modView.filterView.collectionView {
            return CGSize(width: collectionView.bounds.width / 2.4, height: 200)
        } else {
            return CGSize(width: Sizes.cellEditoWidth, height: Sizes.cellEditorHeight)
        }
    }

    // Target Action
    @objc private func closeButtonTappedFilterView() {
        modView.filterView.isHidden = true
    }
}
