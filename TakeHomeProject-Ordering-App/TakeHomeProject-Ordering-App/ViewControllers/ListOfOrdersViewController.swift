//
//  ListOfOrdersViewController.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class ListOfOrdersViewController: UIViewController {
    
    @IBOutlet weak var listOfOrdersTableView : UITableView!
    
    var orderListData = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Orders"
        setupTableView()
    }
}

//MARK: -  UITableViewDataSource
extension ListOfOrdersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfOrdersTableView.dequeueReusableCell(withIdentifier: OrderTableCell.identifier) as! OrderTableCell
        let data = orderListData[indexPath.row]
        cell.configureCell(withData: data)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListOfOrdersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOrder = orderListData[indexPath.row]
        let helpVC = HelpViewController()
        helpVC.orderLabel = "\(selectedOrder.orderId)"
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        listOfOrdersTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - Private
private extension ListOfOrdersViewController {
    func setupTableView() {
        listOfOrdersTableView.dataSource = self
        listOfOrdersTableView.delegate = self
        listOfOrdersTableView.register(OrderTableCell.nib(), forCellReuseIdentifier: OrderTableCell.identifier)
        listOfOrdersTableView.separatorStyle = .none
    }
}
