//
//  ActivityFile_CVC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 4/8/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ActivityFile_CVC: UICollectionViewCell {
    
    @IBOutlet weak var image_file: UIImageView!
    @IBOutlet weak var icon_delete: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon_delete.layoutIfNeeded()
        icon_delete.backgroundColor = UIColor.white
        icon_delete.layer.cornerRadius = 25 / 2
        icon_delete.clipsToBounds = true
    }
}
