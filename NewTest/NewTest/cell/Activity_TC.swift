//
//  Activity_TC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 8/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import FontAwesome_swift

class Activity_TC: UITableViewCell {

    @IBOutlet weak var view_cell: UIView!
    @IBOutlet weak var image_person: UIImageView!
    @IBOutlet weak var image_icon: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_company: UILabel!
    @IBOutlet weak var label_activity: UILabel!
    @IBOutlet weak var label_datetime: UILabel!
    @IBOutlet weak var icon_chage: UIImageView!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon_chage.image = UIImage.fontAwesomeIcon(name: .bolt, style: .solid, textColor: gb.color_ot_yellow, size: CGSize(width: 20, height: 20))
        label_name.textColor = gb.color_main
        label_company.textColor  = gb.color_darkgrey
        label_activity.textColor = gb.color_lightgrey
        label_datetime.textColor = gb.color_lightgrey
        label_status.textColor = gb.color_lightgrey
        label_type.textColor = gb.color_lightgrey
        
        image_person.layoutIfNeeded()
        image_person.layer.cornerRadius = 40 / 2
        image_person.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_person.layer.borderWidth = 1
        image_person.clipsToBounds = true
    }
}
