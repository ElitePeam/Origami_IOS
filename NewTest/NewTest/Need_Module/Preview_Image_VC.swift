//
//  Preview_Image_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 19/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class Preview_Image_VC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var image_preview: UIImageView!
    
    var sd_image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "preview_image".localized(gb.lang_now)
        let button_trash = UIBarButtonItem(title: "delete".localized(gb.lang_now), style: .done, target: self, action: #selector(trash))
        self.navigationItem.rightBarButtonItem  = button_trash
        view.backgroundColor = UIColor.black
        image_preview.image = sd_image
    }
    
    @objc func trash(sender:UIBarButtonItem!) {
        gb.image_del = true
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.image_preview
    }
}
