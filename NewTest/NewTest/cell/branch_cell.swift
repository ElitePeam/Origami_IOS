//
//  branch_cell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 3/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class branch_cell: UITableViewCell {
    
    @IBOutlet weak var branch_view: UIView!
    @IBOutlet weak var branch_label: UILabel!
    @IBOutlet weak var topic_label: UILabel!
    @IBOutlet weak var customer_label: UILabel!
    @IBOutlet weak var datetime_label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
        branch_view.layer.cornerRadius = 10
        branch_view.layer.masksToBounds = true
    }
    
}
