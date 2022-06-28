//
//  ListOfOrderTableCell.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

protocol OrderContainerTableCellDelegate : AnyObject {
    func didTapOrderCell(_ view : OrderContainerTableCell, data : Order)
    func didTapAllOrders(_ view : OrderContainerTableCell)
}

class OrderContainerTableCell: UITableViewCell {
    
    @IBOutlet weak var orderCollectionView : UICollectionView!
    
    weak var delegate : OrderContainerTableCellDelegate?
    
    var data = [Order]() {
        didSet {
            dump(data)
            orderCollectionView.reloadData()
        }
    }
    
    
    static let identifier  = "OrderContainerTableCell"
    static func nib() -> UINib {
        return UINib(nibName: "OrderContainerTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        
        orderCollectionView.register(OrderCollectionCell.nib(), forCellWithReuseIdentifier: OrderCollectionCell.identifier)
    }
    
    
}

extension OrderContainerTableCell {
    @IBAction func allOrdersTapped(_ sender: UIButton) {
        delegate?.didTapAllOrders(self)
    }
}


extension OrderContainerTableCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOrder = data[indexPath.row]
        delegate?.didTapOrderCell(self, data: selectedOrder)
    }
    
}

extension OrderContainerTableCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260, height: 150)
    }
}

extension OrderContainerTableCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = orderCollectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionCell.identifier, for: indexPath) as! OrderCollectionCell
        /// Allow item to be scroll from right to left
        orderCollectionView.transform = CGAffineTransform(scaleX:-1,y: 1)
        cell.transform = CGAffineTransform(scaleX:-1,y: 1)
        cell.configureCell(withData: data[indexPath.row])
        return cell
    }
}
