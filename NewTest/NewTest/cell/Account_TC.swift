//
//  Account_TC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 28/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import FontAwesome_swift

class Account_TC: UITableViewCell {

    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_des: UILabel!
    @IBOutlet weak var image_icon: UIImageView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var icon_build: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label_name.textColor = gb.color_main
        label_des.textColor  = gb.color_darkgrey
        label_location.textColor = gb.color_lightgrey
        
        image_cell.layoutIfNeeded()
        image_cell.layer.cornerRadius = 60 / 2
        image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_cell.layer.borderWidth = 1
        image_cell.clipsToBounds = true
        icon_build.image = UIImage.fontAwesomeIcon(name: .building, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: 20, height: 20))
    }
}
