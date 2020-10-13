//
//  AccountProject_TC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 8/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class AccountProject_TC: UITableViewCell {

    @IBOutlet weak var view_cell: UIView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_company: UILabel!
    @IBOutlet weak var label_person: UILabel!
    @IBOutlet weak var image_person: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label_name.textColor = gb.color_main
        label_company.textColor = gb.color_darkgrey
        label_person.textColor = gb.color_lightgrey
        image_person.tintColor = gb.color_lightgrey
    }
}
