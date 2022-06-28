//
//  OrderCollectionCell.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class OrderCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var paidMethodLabel: UILabel!
    @IBOutlet weak var deliverStatusLabel: UILabel!
    
    static let identifier = "OrderCollectionCell"
    
    var dateFormatter : DateFormatter = DateFormatter()
    
    static func nib() -> UINib {
        return UINib(nibName: "OrderCollectionCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(withData data : Order) {
        orderIdLabel.text = "#\(data.orderId)"
        arriveTimeLabel.text = arriveTime(data.arrivesAtUtc ?? 0)
        paidMethodLabel.text = data.paidWith
        deliverStatusLabel.text = deliveryStatus(data.arrivesAtUtc ?? 0)
        
    }
}

private extension OrderCollectionCell {
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
