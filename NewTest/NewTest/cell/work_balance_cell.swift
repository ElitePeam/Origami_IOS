//
//  work_balance_cell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 10/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class work_balance_cell: UITableViewCell {
    
    @IBOutlet weak var view_cell: UIView!
    @IBOutlet weak var view_color: UIView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_used_hour: UILabel!
    @IBOutlet weak var label_remean_hour: UILabel!
    @IBOutlet weak var label_total_hour: UILabel!
    @IBOutlet weak var label_used: UILabel!
    @IBOutlet weak var label_remain: UILabel!
    @IBOutlet weak var label_total: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
