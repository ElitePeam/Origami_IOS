//
//  ApproveWorkDetail_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 28/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ApproveWorkDetail_VC: UIViewController{

    @IBOutlet weak var label_note: UILabel!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_req_user: UILabel!
    @IBOutlet weak var label_start_date: UILabel!
    @IBOutlet weak var label_end_date: UILabel!
    @IBOutlet weak var label_total: UILabel!
    @IBOutlet weak var label_approve_by: UILabel!
    @IBOutlet weak var view_content: UIView!
    
    @IBOutlet weak var rq_user: UILabel!
    @IBOutlet weak var txt_end: UILabel!
    @IBOutlet weak var txt_start: UILabel!
    @IBOutlet weak var txt_total_hr: UILabel!
    @IBOutlet weak var txt_approve_by: UILabel!
    
    var workRequest:WorkRequest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "detail_work".localized(gb.lang_now)
        
        rq_user.text = "rq_user".localized(gb.lang_now)
        txt_start.text = "start".localized(gb.lang_now)
        txt_end.text = "end".localized(gb.lang_now)
        txt_total_hr.text = "total_hr".localized(gb.lang_now)
        txt_approve_by.text = "approve_by".localized(gb.lang_now)
        
        if gb.lang_now == "en" {
            label_type.text     = "[\(String(workRequest!.u_type_en!))]"
        }
        else {
            label_type.text     = "[\(String(workRequest!.u_type_th!))]"
        }
        
        label_note.text     = workRequest?.u_subject
        label_req_user.text = "\(String(workRequest!.u_firstname!)) \(String(workRequest!.u_lastname!))"
        label_start_date.text = "\(String(workRequest!.u_req_start!)) \(String(workRequest!.u_req_start_time!))"
        label_end_date.text = "\(String(workRequest!.u_req_end!)) \(String(workRequest!.u_req_end_time!))"
        label_total.text    = workRequest?.u_total_time
        label_approve_by.text = workRequest?.approve_name
        
        view_content.layer.cornerRadius = 5.0
        view_content.layer.borderWidth = 0.0
        view_content.layer.shadowColor = UIColor.lightGray.cgColor
        view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_content.layer.shadowRadius = 2.0
        view_content.layer.shadowOpacity = 1
        view_content.layer.masksToBounds = false
    }
}
