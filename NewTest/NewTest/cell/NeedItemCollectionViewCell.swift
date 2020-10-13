//
//  NeedItemCollectionViewCell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 16/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class NeedItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_item: UIImageView!
    @IBOutlet weak var label_item: UILabel!
    
    override func awakeFromNib() {
        image_item.layoutIfNeeded()
        image_item.layer.cornerRadius = 30
        image_item.clipsToBounds = true
        
    }
}
