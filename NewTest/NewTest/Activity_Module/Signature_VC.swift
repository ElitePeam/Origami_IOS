//
//  Signature_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 12/10/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import YPDrawSignatureView

class Signature_VC: UIViewController {

    @IBOutlet weak var sign_view: YPDrawSignatureView!
    @IBOutlet weak var clear: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ic = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneSign))
        self.navigationItem.rightBarButtonItem  = ic
        
        self.sign_view.clear()
        sign_view.layer.borderWidth = 1
        sign_view.layer.borderColor = gb.color_border.cgColor
        sign_view.layer.cornerRadius = 10
        sign_view.layer.backgroundColor = UIColor.white.cgColor
        sign_view.clipsToBounds = true
    }
    
    @IBAction func tapClear(_ sender: Any) {
        sign_view.clear()
    }
    
    @objc func doneSign(sender:UIBarButtonItem!) {
        print("Done Sign")
    }
}
