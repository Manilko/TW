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
    
    init() {
        self.filterFlag = .all
        self.arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
        
        super.init(nibName: nil, bundle: nil)
        
        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        view().navView.rightButton.addTarget(self, action: #selector(showContainerButtonTapped), for: .touchUpInside)

        view().modsTableView.delegate = self
        view().modsTableView.dataSource = self
        view().modsTableView.register(ModsTVCell.self, forCellReuseIdentifier: ModsTVCell.identifier)
        
        view().searchView.resultTableView.delegate = self
        view().searchView.resultTableView.dataSource = self
        view().searchView.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        searchResults = Array(filteredCollection.prefix(3))
        
        // MARK: - searchView
        view().searchView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view().searchView.searchTextField.delegate = self
        view().searchView.searchTextField.addTarget(self, action: #selector(searchFieldDidChange(_:)), for: .editingChanged)
        
        // MARK: - filterView
        view().filterView.collectionView.dataSource = self
        view().filterView.collectionView.delegate = self
        view().filterView.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view().filterView.closeButton.addTarget(self, action: #selector(closeButtonTappedFilterView), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = ModsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .backgroundBlue
        

        filteredCollection = filterCollection(arrayMod, by: .all)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        arrayMod.removeAll()
        arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
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
    
    
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }
    
    @objc private func showContainerButtonTapped(_ celector: UIButton) {
        view().filterView.isHidden = false
    }
}

// MARK: - filterView UICollectionViewDataSource
extension ModsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            guard let selectedFilter = FilterType(rawValue: indexPath.item) else { return }
            
            filterFlag = selectedFilter
            view().filterView.collectionView.reloadData()
            
            filteredCollection = filterCollection(arrayMod, by: selectedFilter)
        
            view().modsTableView.reloadData()
            view().filterView.isHidden = true
        }
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          FilterType.allCases.count
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell

            let filterType = FilterType(rawValue: indexPath.item) ?? .all
            cell.configure(filter: filterType, flag: filterFlag)
        
            return cell
        }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4.4, height: 200)
    }
    
    // Target Action
    @objc private func closeButtonTappedFilterView() {
        view().filterView.isHidden = true
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
        searchResults = filteredCollection.filter { ($0.rd1Ld4?.lowercased() ?? "").contains(searchText.lowercased()) }
        view().searchView.resultTableView.reloadData()
        view().searchView.resultTableView.isHidden = searchResults.isEmpty
        updateSearchViewHeight()
    }
    
    private func updateSearchViewHeight() {
           UIView.animate(withDuration: 0.3) {
               let newHeight = self.view().searchView.resultTableView.isHidden ? 80 : 310
               self.view().searchView.searchViewHeightConstraint.constant = CGFloat(newHeight)
           }
       }
    
    private func updateSearchHideTabel() {
        view().searchView.searchTextField.text = nil
        updateSearch("")
       }
}

// MARK: - TableViewDelegate
extension ModsController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        
        if tableView == view().modsTableView {
            cellCount =  filteredCollection.count
       } else if tableView == view().searchView.resultTableView {
           cellCount = searchResults.count
       }
        
       return cellCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var cellHeight: CGFloat = 0
        
        if tableView == view().modsTableView {
            cellHeight =  164
       } else if tableView == view().searchView.resultTableView {
           cellHeight = 48
       }
        
        return cellHeight
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
        
        if tableView == view().modsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModsTVCell.identifier, for: indexPath) as? ModsTVCell else { return UITableViewCell() }
            let item = filteredCollection[indexPath.row]
            cell.configure(with: item)
            returnCell = cell
       } else if tableView == view().searchView.resultTableView {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           // create service for configuration cell
                cell.textLabel?.text = searchResults[indexPath.row].rd1Ld4
                cell.backgroundColor = .clear
                cell.textLabel?.font = .customFont(type: .lilitaOne, size: 20)
                cell.textLabel?.textColor = .lettersWhite
           returnCell =  cell
       }
        return returnCell
    }
}

// MARK: - ViewSeparatable
extension ModsController: ViewSeparatable {
    typealias RootView = ModsView
}
