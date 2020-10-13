//
//  Preview_Image2_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 2/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class Preview_Image2_VC: UIViewController {
    
    @IBOutlet weak var image_preview: UIImageView!
    
    var img_preview = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "preview_image".localized(gb.lang_now)
        view.backgroundColor = UIColor.black
        image_preview.image = img_preview
    }
}
