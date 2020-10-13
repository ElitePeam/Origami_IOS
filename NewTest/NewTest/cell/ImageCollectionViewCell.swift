//
//  ImageCollectionViewCell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 7/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var text_cell: UILabel!
    
    override func awakeFromNib() {
        image_cell.layoutIfNeeded()
        image_cell.layer.cornerRadius = 60/2
        image_cell.backgroundColor = UIColor.white
        image_cell.clipsToBounds = true
    }
}
