//
//  SectionTableCell.swift
//  TakeHomeProject-Ordering-App
//
//  Created by Ikmal Azman on 28/06/2022.
//

import UIKit

class SectionTableCell: UITableViewCell {

    @IBOutlet weak var sectionIconImageView: UIImageView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    static let identifier = "SectionTableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionTableCell", bundle: nil)
    }

    func configureCell(withData data : Section) {
        sectionIconImageView.image = UIImage(systemName: data.imageName)!
        sectionTitleLabel.text = data.label
        selectionStyle = .none
    }
}
