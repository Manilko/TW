//
//  FurnitureViewController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//
import UIKit
import RealmSwift
import Realm


final class FurnitureViewController: UIViewController {
    
    private var dataSource: [FurnitureElement]
    
    private var filterFlag: FilterType
    private var searchResults: [FurnitureElement] = []
    private var filteredCollection: [FurnitureElement] = []
    
    // MARK: - Properties
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    weak var itemDelegate: FurnitureCoordinatorDelegate?
    
    private lazy var furnitureView = FurnitureView(frame: UIScreen.main.bounds)
    
    init() {
        self.filterFlag = .all
        self.dataSource = Array(RealmManager.shared.getObjects(FurnitureElement.self))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlue
        
        furnitureView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(furnitureView)
        
        NSLayoutConstraint.activate([
            furnitureView.topAnchor.constraint(equalTo: view.topAnchor),
            furnitureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            furnitureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            furnitureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupSubViews()
        
        filteredCollection = filterCollection(dataSource, by: .all)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.removeAll()
        dataSource = Array(RealmManager.shared.getObjects(FurnitureElement.self))
        furnitureView.collectionView.reloadData()
    }
    
    private func filterCollection(_ collection: [FurnitureElement], by filterType: FilterType) -> [FurnitureElement] {
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
        furnitureView.navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        furnitureView.navView.rightButton.addTarget(self, action: #selector(showContainerButtonTapped), for: .touchUpInside)
        
        furnitureView.collectionView.register(FurnitureElementCell.self, forCellWithReuseIdentifier: FurnitureElementCell.identifier)
        furnitureView.collectionView.delegate = self
        furnitureView.collectionView.dataSource = self
        
        furnitureView.searchView.resultTableView.delegate = self
        furnitureView.searchView.resultTableView.dataSource = self
        furnitureView.searchView.resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchResults = Array(filteredCollection.prefix(3))
        
        // MARK: - searchView
        furnitureView.searchView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        furnitureView.searchView.searchTextField.delegate = self
        furnitureView.searchView.searchTextField.addTarget(self, action: #selector(searchFieldDidChange(_:)), for: .editingChanged)
        
        // MARK: - filterView
        furnitureView.filterView.collectionView.dataSource = self
        furnitureView.filterView.collectionView.delegate = self
        furnitureView.filterView.collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        furnitureView.filterView.closeButton.addTarget(self, action: #selector(closeButtonTappedFilterView), for: .touchUpInside)
    }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }
    
    @objc private func showContainerButtonTapped(_ celector: UIButton) {
        furnitureView.filterView.isHidden = false
    }
}

// MARK: - filterView UICollectionViewDataSource
extension FurnitureViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == furnitureView.filterView.collectionView {
            guard let selectedFilter = FilterType(rawValue: indexPath.item) else { return }
            
            filterFlag = selectedFilter
            furnitureView.filterView.collectionView.reloadData()
            
            filteredCollection = filterCollection(dataSource, by: selectedFilter)
            
            furnitureView.collectionView.reloadData()
            furnitureView.filterView.isHidden = true
        } else if collectionView == furnitureView.collectionView {
            let item = dataSource[indexPath.row]
            let recommended = Array(dataSource[1...5])  // ????
            itemDelegate?.presentDetailViewController(with: item, recommended: recommended)
            updateSearchHideTabel()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == furnitureView.filterView.collectionView {
            return FilterType.allCases.count
        }  else if collectionView == furnitureView.collectionView {
            return filteredCollection.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == furnitureView.filterView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
            
            let filterType = FilterType(rawValue: indexPath.item) ?? .all
            cell.configure(filter: filterType, flag: filterFlag)
            
            return cell
        } else if collectionView == furnitureView.collectionView {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FurnitureElementCell.identifier, for: indexPath) as? FurnitureElementCell
            else { return UICollectionViewCell() }
            // create service for configuration cell
            let item = dataSource[indexPath.row]
            cell.configure(with: item)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == furnitureView.filterView.collectionView {
            return CGSize(width: collectionView.bounds.width / 4.4, height: 200)
        } else {
            return CGSize(width: Sizes.cellWidth , height: Sizes.cellHeight)
        }
    }
    
    // Target Action
    @objc private func closeButtonTappedFilterView() {
        furnitureView.filterView.isHidden = true
    }
}

// MARK: - UITextFieldDelegate, search Target Actions
extension FurnitureViewController: UITextFieldDelegate {
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
        furnitureView.searchView.resultTableView.reloadData()
        furnitureView.searchView.resultTableView.isHidden = searchResults.isEmpty
        updateSearchViewHeight()
    }
    
    private func updateSearchViewHeight() {
        UIView.animate(withDuration: 0.3) {
            let newHeight = self.furnitureView.searchView.resultTableView.isHidden ? 80 : 310
            self.furnitureView.searchView.searchViewHeightConstraint.constant = CGFloat(newHeight)
        }
    }
    
    private func updateSearchHideTabel() {
        furnitureView.searchView.searchTextField.text = nil
        updateSearch("")
    }
}

//// MARK: - TableViewDelegate
extension FurnitureViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredCollection[indexPath.row]
        let recommended = Array(dataSource[1...5])  // ????
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
