//
//  ViewController.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var infoTableView: UITableView!
    
    var networkManager = NetworkManager()
    
    var tableSection = [
        Section(label: "My Profile", imageName: "person.fill"),
        Section(label: "My Addresses", imageName: "mappin.and.ellipse")
    ]
    
    var presenter = AccountViewPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.delegate = self
        presenter.requestOrdersHistory()
    }
}

//MARK: - UITableViewDelegate
extension AccountViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        case 1 :
            let myAddressesVC = MyAddressViewController()
            navigationController?.pushViewController(myAddressesVC, animated: true)
            
        default :
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 220
        default :
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension AccountViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1 :
            return tableSection.count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0 :
            let cell = infoTableView.dequeueReusableCell(withIdentifier: OrderContainerTableCell.identifier, for: indexPath) as! OrderContainerTableCell
            cell.delegate = self
            cell.data = presenter.listOfOrdersData
            return cell
        case 1 :
            let cell = infoTableView.dequeueReusableCell(withIdentifier: SectionTableCell.identifier, for: indexPath) as! SectionTableCell
            cell.configureCell(withData: tableSection[indexPath.row])
            return cell
        default :
            return UITableViewCell()
        }
        
    }
}

//MARK: - OrderContainerTableCellDelegate
extension AccountViewController : OrderContainerTableCellDelegate {
    func didTapOrderCell(_ view: OrderContainerTableCell, data: Order) {
        DispatchQueue.main.async {
            let helpVC = HelpViewController()
            helpVC.orderLabel = "\(data.orderId)"
            self.navigationController?.pushViewController(helpVC, animated: true)
        }
    }
    
    func didTapAllOrders(_ view: OrderContainerTableCell) {
        let listOfOrderVC = ListOfOrdersViewController()
        listOfOrderVC.orderListData = presenter.listOfOrdersData
        self.navigationController?.pushViewController(listOfOrderVC, animated: true)
    }
}

//MARK: - AccountViewPresenterDelegate
extension AccountViewController : AccountViewPresenterDelegate {
    func renderListOfOrders(_ accountViewPresenter: AccountViewPresenter) {
        DispatchQueue.main.async { [weak self] in
            self?.infoTableView.reloadData()
        }
    }
    
    func renderError(_ accountViewPresenter: AccountViewPresenter, error: APIError) {
        DispatchQueue.main.async { [weak self] in
            self?.presentErrorAlert(message: error)
        }
    }
}

//MARK: - Private
private extension AccountViewController {
    func presentErrorAlert(message : APIError) {
        let alert = UIAlertController(title: "Error", message: message.rawValue, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let retryAction = UIAlertAction(title: "Retry", style: .default) {  [weak self]  _ in
            self?.presenter.refreshOrderList()
            self?.infoTableView.reloadData()
            
        }
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        self.present(alert, animated: true)
    }
    
    func setupTableView() {
        infoTableView.separatorStyle = .none
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(OrderContainerTableCell.nib(), forCellReuseIdentifier: OrderContainerTableCell.identifier)
        infoTableView.register(SectionTableCell.nib(), forCellReuseIdentifier: SectionTableCell.identifier)
    }
}
