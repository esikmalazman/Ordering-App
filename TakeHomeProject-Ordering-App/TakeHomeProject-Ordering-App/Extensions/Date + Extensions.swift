//
//  Date + Extensions.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import Foundation

extension Date {
    var milisecondsSince1970 : Int {
        Int(self.timeIntervalSince1970 * 1000.rounded())
    }
    
    init(miliseconds : Int) {
        self = Date(timeIntervalSince1970: TimeInterval(miliseconds) / 1000)
    }
}
