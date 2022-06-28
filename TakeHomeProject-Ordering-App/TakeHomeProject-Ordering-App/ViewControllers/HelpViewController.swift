//
//  HelpViewControllerViewController.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var orderedIdLabel: UILabel!
    
    var orderLabel : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help"
        orderedIdLabel.text = orderLabel
    }
}
