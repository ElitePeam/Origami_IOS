//
//  need_cell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 15/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class need_cell: UITableViewCell {

    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_docnumber: UILabel!
    @IBOutlet weak var label_topic: UILabel!
    @IBOutlet weak var label_budget: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var view_cell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
