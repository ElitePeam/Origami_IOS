//
//  UnderUserCollectionViewCell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 15/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class UnderUserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var name_text: UILabel!
    
    override func awakeFromNib() {
        image_cell.layoutIfNeeded()
        image_cell.layer.cornerRadius = 60/2
        image_cell.backgroundColor = UIColor.white
        image_cell.clipsToBounds = true
    }
}
