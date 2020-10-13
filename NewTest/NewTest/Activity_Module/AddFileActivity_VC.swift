//
//  AddFileActivity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 4/8/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SCLAlertView

class AddFileActivity_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection_file: UICollectionView!
    @IBOutlet weak var button_file: UIButton!
    
    var imagePicker = UIImagePickerController()
    var array_image = [UIImage]()
    var new_image   = [UIImage]()
    var show_image  = [UIImage]()
    var array_image_id = [String]()
    var delete_image_id = [String]()
    var standardReturn:StandardReturn? = nil
    var slt_id = ""
    var remove_index = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let done_save = UIBarButtonItem(title: "save".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        imagePicker.delegate = self
        button_file.setTitle("  \("upload_photo".localized(gb.lang_now))", for: .normal)
        button_file.setTitleColor(gb.color_lightgrey, for: .normal)
        button_file.layer.borderColor = gb.color_lightgrey.cgColor
        button_file.layer.borderWidth = 1
        button_file.layer.cornerRadius = 3
        button_file.clipsToBounds = true
        collection_file.backgroundColor = UIColor.clear
        show_image = array_image
    }
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        for item in delete_image_id {
            deleteActivityImage(image_id: item)
        }
        for item in new_image {
            uploadActivity(activity_id: slt_id, image_: item)
        }
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("close".localized(gb.lang_now)) {
           alert.hideView()
            self.backTwo()
        }
        alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
    }
    
    func uploadActivity(activity_id:String,image_:UIImage) {
        let image_name = "\(Date().millisecondsSince1970).jpeg"
        var image_base64 = ""
        let image_data = image_.jpegData(compressionQuality: 1)
        if image_data != nil {
            image_base64 = image_data!.base64EncodedString()
            image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
            
            let postString = "activity_id=\(activity_id)&image_name=\(image_name)&image_type=image&emp_id=\(String((gb.user?.emp_id)!))&base64=\(image_base64)"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACTIVITY_IMAGE)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                do{
                    self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
                }catch let err{
                    print("Error : ",err)
                }

                DispatchQueue.main.async {
                    print(self.standardReturn?.msg ?? "")
                }
            }
            task.resume()
        }
    }
    
    func deleteActivityImage(image_id: String) {
        let postString = "image_id=\(image_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_ACTIVITY_IMAGE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                print(self.standardReturn?.msg ?? "")
            }
        }
        task.resume()
    }
    
    func openImage(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
        
        let choose = UIAlertAction(title: "choose_photo".localized(gb.lang_now), style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let take = UIAlertAction(title: "new_photo".localized(gb.lang_now), style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(choose)
        actionSheet.addAction(take)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let im = rotateImage(image: image)
            new_image.append(im!)
            show_image.append(im!)
            array_image_id.append("")
            collection_file.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func rotateImage(image: UIImage) -> UIImage? {
        if (image.imageOrientation == UIImage.Orientation.up ) {
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    
    @IBAction func tapDone(_ sender: Any) {
//        for item in delete_image_id {
//            deleteActivityImage(image_id: item)
//        }
//        for item in new_image {
//            uploadActivity(activity_id: slt_id, image_: item)
//        }
//        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
//        let alert = SCLAlertView(appearance: appearance)
//        alert.addButton("close".localized(gb.lang_now)) {
//           alert.hideView()
//            self.backTwo()
//        }
//        alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
    }
    
    func deleteImage() -> String{
        var image_list = ""
        if (delete_image_id.count) > 0{
            for item in delete_image_id {
                image_list = "\(image_list),\(item)"
            }
            image_list.remove(at: image_list.startIndex)
        }
        return image_list
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    @IBAction func tapNewFile(_ sender: Any) {
        openImage()
    }
    
    @objc func handleTap(_ sender: MyTapGesture) {
        confirmDelete(image_id : sender.image_id, image_index : sender.image_index)
    }
    
    func confirmDelete(image_id : String, image_index : String){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
        
        let option1 = UIAlertAction(title: "confirm_delete".localized(gb.lang_now), style: .destructive) { action in
            if image_id != "" {
                self.delete_image_id.append(image_id)
            }
            if Int(image_index)! >= self.array_image.count {
                self.new_image.remove(at: Int(image_index)! - self.array_image.count)
            }
            else {
                self.array_image.remove(at: Int(image_index)!)
                self.array_image_id.remove(at: Int(image_index)!)
            }
            self.show_image.remove(at: Int(image_index)!)
            self.collection_file.reloadData()
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return show_image.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ActivityFile_CVC
        cell.image_file.image = show_image[indexPath.row]
        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.image_id = array_image_id[indexPath.row]
        tap.image_index = String(indexPath.row)
        cell.icon_delete.addGestureRecognizer(tap)
        cell.icon_delete.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collection_file.frame.width / 2) - 3, height: (collection_file.frame.width / 2) - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "previewimage") as? PreviewImage_VC
        vc?.image = show_image[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

class MyTapGesture: UITapGestureRecognizer {
    var image_id = String()
    var image_index = String()
}
