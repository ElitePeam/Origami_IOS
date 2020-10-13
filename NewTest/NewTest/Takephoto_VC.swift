//
//  Takephoto_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 2/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import Foundation
import UIKit

class Takephoto_VC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var preview_image: UIImageView!
    var imagePicker: UIImagePickerController!


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        preview_image.image = info[.originalImage] as? UIImage
    }
}
