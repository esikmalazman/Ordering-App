//
//  Orders.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import Foundation

struct OrdersResponse : Decodable {
    let orders : [Order]
}

struct Order : Decodable {
    let orderId : Int
    let arrivesAtUtc : Int?
    let paidWith : String
    let totalPaid : Double
}
