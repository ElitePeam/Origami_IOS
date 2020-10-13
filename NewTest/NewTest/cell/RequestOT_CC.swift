//
//  RequestOT_CC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 20/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class RequestOT_CC: UICollectionViewCell {
    
    @IBOutlet weak var image_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image_user.layoutIfNeeded()
        image_user.layer.cornerRadius = 60/2
        image_user.backgroundColor = UIColor.white
        image_user.clipsToBounds = true
    }
}
