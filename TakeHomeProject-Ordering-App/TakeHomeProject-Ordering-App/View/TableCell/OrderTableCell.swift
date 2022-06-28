//
//  OrderTableCell.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class OrderTableCell: UITableViewCell {
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var arrivesTimeLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    
    static let identifier = "OrderTableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "OrderTableCell", bundle: nil)
    }
    
    func configureCell(withData data : Order) {
        orderIdLabel.text = "#\(data.orderId)"
        arrivesTimeLabel.text = arriveTime(data.arrivesAtUtc ?? 0)
        paymentMethodLabel.text = data.paidWith
        statusLabel.text = deliveryStatus(data.arrivesAtUtc ?? 0)
        selectionStyle = .none
    }
}

private extension OrderTableCell {
    func arriveTime(_ date : Int) -> String {
        let convertedDate = Date(miliseconds: date)
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let currentTime = dateFormatter.string(from: convertedDate)
        return currentTime
    }
    
    func deliveryStatus(_ date : Int) -> String {
        let convertedDate = Date(miliseconds: date)
        if convertedDate > Date.now {
            return "Confirmed"
        } else if convertedDate < Date.now {
            return "Delivered"
        } else {
            return "Cancelled"
        }
    }
}
