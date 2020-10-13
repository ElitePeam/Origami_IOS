//
//  ApproveTableViewCell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 25/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ApproveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var label_person: UILabel!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
