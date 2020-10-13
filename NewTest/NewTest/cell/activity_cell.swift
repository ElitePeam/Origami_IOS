//
//  activity_cell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 4/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class activity_cell: UITableViewCell {
    
    @IBOutlet weak var topic_label: UILabel!
    @IBOutlet weak var customer_label: UILabel!
    @IBOutlet weak var datetime_label: UILabel!
    @IBOutlet weak var activity_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.layoutIfNeeded()
        activity_view.layer.cornerRadius = 10
        activity_view.layer.masksToBounds = true
    }
    
}
