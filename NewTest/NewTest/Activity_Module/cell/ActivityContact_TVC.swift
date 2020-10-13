//
//  ActivityContact_TVC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ActivityContact_TVC: UITableViewCell {
    
    @IBOutlet weak var image_contact: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_comp: UILabel!
    @IBOutlet weak var view_cell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image_contact.layoutIfNeeded()
        image_contact.backgroundColor = UIColor.white
        image_contact.layer.cornerRadius = 50 / 2
        image_contact.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_contact.layer.borderWidth = 1
        image_contact.clipsToBounds = true
    }
}
