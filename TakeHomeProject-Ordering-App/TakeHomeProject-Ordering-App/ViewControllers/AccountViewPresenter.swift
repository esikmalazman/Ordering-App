//
//  OrderViewPresenter.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import Foundation

protocol AccountViewPresenterDelegate : AnyObject{
    func renderListOfOrders(_ accountViewPresenter : AccountViewPresenter)
    func renderError(_ accountViewPresenter : AccountViewPresenter, error : APIError)
}

class AccountViewPresenter {
    
    weak var delegate : AccountViewPresenterDelegate?
    
    var networkManager = NetworkManager()
    var listOfOrdersData = [Order]() {
        didSet {
            listOfOrdersData.sort { firstItem, secondItem in
                firstItem.arrivesAtUtc! > secondItem.arrivesAtUtc!
            }
        }
    }
    
    func requestOrdersHistory() {
        networkManager.requestAPI(for: .listOfOrders) { [weak self] response in
            switch response {
            case .success(let data):
                self?.listOfOrdersData = data.orders
                self?.delegate?.renderListOfOrders(self!)
            case .failure(let error):
                self?.delegate?.renderError(self!, error: error)
            }
        }
    }
    
    func refreshOrderList() {
        listOfOrdersData = []
        requestOrdersHistory()
    }
}
