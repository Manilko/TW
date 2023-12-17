//
//  HouseIdeasViewController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit

final class HouseIdeasViewController: UIViewController {
    
    // MARK: - Properties
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        
//        view().tableView.delegate = self
//        view().tableView.dataSource = self
        view().tableView.register(ModsTVCell.self, forCellReuseIdentifier: ModsTVCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = HouseIdeasView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.2870183289, green: 0.5633350015, blue: 0.8874290586, alpha: 1)
//        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }

}

// MARK: - TableViewDelegate
//extension HouseIdeasViewController: UITableViewDataSource, UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        SideMenuType.allCases.count
//    }
//
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        60.0
////    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ModsTVCell.identifier, for: indexPath) as? ModsTVCell else { return UITableViewCell() }
//
//        let item = ItemModel(title: "title", icon: "imageName", discription: "description")
//        
////        cell.configure(with: item)
//
//        return cell
//    }
//
//}

// MARK: - ViewSeparatable
extension HouseIdeasViewController: ViewSeparatable {
    typealias RootView = HouseIdeasView
}

final class HouseIdeasView: UIView{
   
   // MARK: - Properties
    
    let navView = NavigationView(leftButtonType: .menu, title: "House Ideas", rightButtonType: ImageNameNawMenuType.filter)

   lazy var tableView: UITableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      return tableView
    }()

   // MARK: - Lifecycle
   required init() {
       super.init(frame: .zero)

       configureLayout()
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       tableView.reloadData()
   }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }


   private func configureLayout() {
       
       addSubview(navView)
       addSubview(tableView)

       navView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           
           navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
           navView.leadingAnchor.constraint(equalTo: leadingAnchor),
           navView.widthAnchor.constraint(equalTo: widthAnchor),
           navView.heightAnchor.constraint(equalToConstant: 100),
   
           tableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 40),
           tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
           tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
           tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

       ])
   }
}




