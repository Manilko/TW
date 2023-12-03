//
//  SideMenuController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 08.11.2023.
//

import UIKit

final class SideMenuController: UIViewController {
    
    // MARK: - Properties
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    var previousSelectedIndexPath: IndexPath?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view().navView.rightButton.addTarget(self, action: #selector(closeDidTaped), for: .touchUpInside)
        view().tableView.delegate = self
        view().tableView.dataSource = self
        view().tableView.register(SideMenuTVCell.self, forCellReuseIdentifier: SideMenuTVCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = SideMenuView()
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
//        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }



    @objc private func closeDidTaped() {
        coordinatorDelegate?.pop(self)
    }

}

// MARK: - TableViewDelegate
extension SideMenuController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SideMenuType.allCases.count
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        60.0
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let previousIndexPath = previousSelectedIndexPath {
            view().deselectCell(at: previousIndexPath)
        }

        view().selectCell(at: indexPath)
        previousSelectedIndexPath = indexPath
        
        print(SideMenuType.allCases[indexPath.row].title)
        
        coordinatorDelegate?.pop(self)
        coordinatorDelegate?.didSelectScreen(SideMenuType.allCases[indexPath.row])
        
//        MenuType.allCases[indexPath.row].title
//        delegate?.pop(self)
//        delegate?.goToItemScreen(MenuType.allCases[indexPath.row])
        
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTVCell.identifier, for: indexPath) as? SideMenuTVCell else { return UITableViewCell() }

        cell.configure(type: SideMenuType.allCases[indexPath.row])

        return cell
    }

}

// MARK: - ViewSeparatable
extension SideMenuController: ViewSeparatable {
    typealias RootView = SideMenuView
}

