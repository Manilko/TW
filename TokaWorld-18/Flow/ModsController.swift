//
//  ModsController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit
import RealmSwift
import Realm

final class ModsController: UIViewController {
    
    var arrayMod: [Mod]
    
    var filterFlag: FilterType
    private var searchResults: [Mod] = []
    private var filteredCollection: [Mod] = []
    
    // MARK: - Properties
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    weak var itemDelegate: ItemPresrntDelegate?
    
    private lazy var modView = ModsView(frame: UIScreen.main.bounds)
    
    init() {
        self.filterFlag = .all
        self.arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
        
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
        arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
        modView.modcCollectionView.reloadData()
    }
    
    private func filterCollection(_ collection: [Mod], by filterType: FilterType) -> [Mod] {
        switch filterType {
        case .all:
            return collection.filter { $0.isAll }
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
        
        modView.modcCollectionView.register(ModsTVCollectionCell.self, forCellWithReuseIdentifier: ModsTVCollectionCell.identifier)
        modView.modcCollectionView.delegate = self
        modView.modcCollectionView.dataSource = self
        
        modView.searchView.resultTableView.delegate = self
        modView.searchView.resultTableView.dataSource = self
        modView.searchView.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchResults = Array(filteredCollection.prefix(3))
        
        // MARK: - searchView
        modView.searchView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        modView.searchView.searchTextField.delegate = self
        modView.searchView.searchTextField.addTarget(self, action: #selector(searchFieldDidChange(_:)), for: .editingChanged)
        
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
    
    func creationRecommendedArray(from array: [Mod], number elements: Int) -> [Mod] {
        var modifiedArray: [Mod] = []

        for (index, element) in arrayMod.enumerated() {
            if index < elements {
                modifiedArray.append(element)
            } else {
                break
            }
        }

        return modifiedArray
    }
}

// MARK: - filterView UICollectionViewDataSource
extension ModsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            let recommended = creationRecommendedArray(from: filteredCollection, number: 5)
            itemDelegate?.presentDetailViewController(with: item, recommended: recommended)
            updateSearchHideTabel()
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModsTVCollectionCell.identifier, for: indexPath) as? ModsTVCollectionCell
            else { return UICollectionViewCell() }
            // create service for configuration cell
            let item = filteredCollection[indexPath.row]
            cell.configure(with: item)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == modView.filterView.collectionView {
            return CGSize(width: collectionView.bounds.width / 4.4, height: 200)
        } else {
            return CGSize(width: Sizes.cellWidth , height: Sizes.cellHeight)
        }
    }
    
    // Target Action
    @objc private func closeButtonTappedFilterView() {
        modView.filterView.isHidden = true
    }
}

// MARK: - UITextFieldDelegate, search Target Actions
extension ModsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func searchFieldDidChange(_ textField: UITextField) {
        updateSearch(textField.text ?? "")
    }
    
    @objc private func closeButtonTapped() {
        updateSearchHideTabel()
    }
    
    private func updateSearch(_ searchText: String) {
//        modView.searchView.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
//                NSAttributedString.Key.foregroundColor: UIColor.white
//            ])
        searchResults = filteredCollection.filter { ($0.rd1Ld4?.lowercased() ?? "").contains(searchText.lowercased()) }
        modView.searchView.resultTableView.reloadData()
        modView.searchView.resultTableView.isHidden = searchResults.isEmpty
        updateSearchViewHeight()
    }
    
    private func updateSearchViewHeight() {
        UIView.animate(withDuration: 0.3) {
            let newHeight = self.modView.searchView.resultTableView.isHidden ? 80 : 310
            self.modView.searchView.searchViewHeightConstraint.constant = CGFloat(newHeight)
        }
    }
    
    private func updateSearchHideTabel() {
        modView.searchView.searchTextField.text = nil
        updateSearch("")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        modView.searchView.textFieldDidBeginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        modView.searchView.textFieldDidEndEditing()
    }
    
}

//// MARK: - TableViewDelegate
extension ModsController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredCollection[indexPath.row]
        let recommended = Array(arrayMod[1...5])  // ????
        itemDelegate?.presentDetailViewController(with: item, recommended: recommended)
        updateSearchHideTabel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // create service for configuration cell
        cell.textLabel?.text = searchResults[indexPath.row].rd1Ld4
        cell.backgroundColor = .clear
        cell.textLabel?.font = .customFont(type: .lilitaOne, size: 20)
        cell.textLabel?.textColor = .lettersWhite
        returnCell =  cell
        return returnCell
    }
}

// MARK: - ViewSeparatable
//extension ModsController: ViewSeparatable {
//    typealias RootView = ModsView
//}
