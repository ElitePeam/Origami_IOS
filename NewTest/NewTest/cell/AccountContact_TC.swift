//
//  AccountContact_TC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 8/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class AccountContact_TC: UITableViewCell {

    @IBOutlet weak var view_cell: UIView!
    @IBOutlet weak var image_person: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_company: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label_name.textColor = gb.color_darkgrey
        label_company.textColor = gb.color_lightgrey
        
        image_person.layoutIfNeeded()
        image_person.layer.cornerRadius = 60 / 2
        image_person.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_person.layer.borderWidth = 1
        image_person.clipsToBounds = true
    }
}
