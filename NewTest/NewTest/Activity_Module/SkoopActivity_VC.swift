//
//  SkoopActivity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SCLAlertView

class SkoopActivity_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collection_photo: UICollectionView!
    @IBOutlet weak var txtv_skoop: UITextView!
    @IBOutlet weak var btn_location: UIButton!
    @IBOutlet weak var btn_photo: UIButton!
    @IBOutlet weak var icon_location: UIButton!
    @IBOutlet weak var view_separate1: UIView!
    @IBOutlet weak var view_textview: UIView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var txt_location: UILabel!
    @IBOutlet weak var label_description: UILabel!
    
    var standardReturn:StandardReturn? = nil
    var skoopFiles:SkoopFiles? = nil
    var imagePicker = UIImagePickerController()
    var toolBar : UIToolbar = UIToolbar()
    var doneButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    var new_image   = [UIImage]()
    var old_image   = [UIImage]()
    var all_image   = [UIImage]()
    var old_image_id = [String]()
    var delete_image_id = [String]()
    var icon_size = 35
    var done_save:UIBarButtonItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        initLayout()
        initData()
        setDataLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if gb.activityData != nil {
            setDataLayout()
        }
    }
    
    func initData(){
        getSkoopImage()
    }
    
    func setDataLayout() {
        txtv_skoop.text = gb.activityData?.skoop_description
        if txtv_skoop.text.isEmpty {
            txtv_skoop.text = "description".localized(gb.lang_now)
            txtv_skoop.textColor = gb.color_phd
            gb.activityData?.skoop_description = ""
        }
        else {
            txtv_skoop.textColor = gb.color_darkgrey
        }
        
        txt_location.text = gb.activityData?.skoop_location
        if (gb.activityData?.skoop_lat == "" || gb.activityData?.skoop_lat == nil) && (gb.activityData?.skoop_lng == "" || gb.activityData?.skoop_lng == nil){
            btn_location.setTitle("add_map".localized(gb.lang_now), for: .normal)
            icon_location.isHidden = true
        }
        else {
            btn_location.setTitle("edit_map".localized(gb.lang_now), for: .normal)
            icon_location.isHidden = false
        }
    }
    
    func initLayout(){
        self.title = "skoop".localized(gb.lang_now)
        done_save = UIBarButtonItem(title: "done".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),
                                       style: .plain,
                                       target: self,
                                       action: #selector(cancelTapped))
        doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),
                                       style: .done,
                                       target: self,
                                       action: #selector(doneTapped))
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil,
                                       action: nil)
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        view_textview.backgroundColor = UIColor.clear
        txtv_skoop.backgroundColor = UIColor.white
        txtv_skoop.layer.borderWidth = 1.0
        txtv_skoop.layer.cornerRadius = 22.5
        txtv_skoop.layer.borderColor = UIColor.lightGray.cgColor
        txtv_skoop.textColor = gb.color_phd
        txtv_skoop.text = "description".localized(gb.lang_now)
        txtv_skoop.delegate = self
        txtv_skoop.inputAccessoryView = toolBar
        label_location.text = "Uactivity_location".localized(gb.lang_now)
        btn_photo.setTitle("add_photo".localized(gb.lang_now), for: .normal)
        collection_photo.backgroundColor = UIColor.clear
        btn_location.setTitleColor(gb.color_main, for: .normal)
        btn_photo.setTitleColor(gb.color_main, for: .normal)
        view_separate1.backgroundColor = gb.color_seperate
        icon_location.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        label_description.text = "description".localized(gb.lang_now)
        label_description.textColor = gb.color_lightgrey
    }
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        done_save!.isEnabled = false
        addSkoop()
    }
    
    func getSkoopImage(){
        let postString = "skoop_id=\(String(gb.activityData?.skoop_id ?? ""))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_SKOOP_IMAGE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.skoopFiles = try JSONDecoder().decode(SkoopFiles.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.loadImage()
            }
        }
        task.resume()
    }
    
    func loadImage(){
        old_image = [UIImage]()
        old_image_id = [String]()
        for item in self.skoopFiles!.data ?? [] {
            old_image_id.append(item.image_id ?? "")
            if item.image_path != nil && item.image_path != "" {
                var image_str = ""
                image_str = "\(Const_Var.BASE_URL)\(String(item.image_path!))"
                print(image_str)
                image_str = image_str.replacingOccurrences(of: " ", with: "%20")
                image_str = image_str.replacingOccurrences(of: "+", with: "%2B")
                image_str = image_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                let url = URL(string: image_str)
                if url != nil {
                    do{
                        let data = try Data(contentsOf: url!)
                        let im = UIImage(data: data) ?? UIImage()
                        self.old_image.append(im)
                        self.all_image.append(im)
                    }
                    catch{
                        self.old_image.append(UIImage())
                        self.all_image.append(UIImage())
                    }
                }
                else{
                    self.old_image.append(UIImage())
                    self.all_image.append(UIImage())
                }
            }
            else {
                self.old_image.append(UIImage())
                self.all_image.append(UIImage())
            }
        }
        collection_photo.reloadData()
        closeLoad()
    }
    
    func addSkoop(){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&activity_id=\(gb.activityData?.activity_id ?? "")&skoop_location=\(gb.activityData?.skoop_location ?? "")&skoop_lat=\(gb.activityData?.skoop_lat ?? "")&skoop_lng=\(gb.activityData?.skoop_lng ?? "")&skoop_detail=\(gb.activityData?.skoop_description ?? "")"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACTIVITY_SKOOP)!
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
                let skoop_id = self.standardReturn?.msg ?? ""
                let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                let alert = SCLAlertView(appearance: appearance)
                alert.addButton("close".localized(gb.lang_now)) {
                  alert.hideView()
                   self.backOne()
                }
                if self.standardReturn?.status == "0" {
                    gb.activityData?.skooped = "1"
                    gb.activityData?.skoop_id = skoop_id
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
                    for item in self.delete_image_id {
                        self.deleteSkoopImage(image_id: item)
                    }
                    for item in self.new_image {
                        self.uploadSkoop(skoop_id:skoop_id,image_:item)
                    }
                }
                else {
                    alert.showSuccess("fail".localized(gb.lang_now), subTitle: "fail_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                self.done_save!.isEnabled = true
            }
        }
        task.resume()
    }
    
    func deleteSkoopImage(image_id: String) {
        let postString = "image_id=\(image_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_SKOOP_IMAGE)!
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
    
    func uploadSkoop(skoop_id:String,image_:UIImage) {
        let image_name = "\(Date().millisecondsSince1970).jpeg"
        var image_base64 = ""
        let image_data = image_.jpegData(compressionQuality: 1)
        if image_data != nil {
            image_base64 = image_data!.base64EncodedString()
            image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
            
            let postString = "skoop_id=\(skoop_id)&image_name=\(image_name)&image_type=image&emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&base64=\(image_base64)"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_SKOOP_IMAGE)!
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
    
    func backOne() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let im = rotateImage(image: image)
            new_image.append(im!)
            all_image.append(im!)
            old_image_id.append("")
            collection_photo.reloadData()
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == gb.color_phd {
            textView.text = nil
            textView.textColor = gb.color_darkgrey
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "description".localized(gb.lang_now)
            textView.textColor = gb.color_phd
            gb.activityData?.skoop_description = ""
        }
        else {
            gb.activityData?.skoop_description = textView.text ?? ""
        }
        setDataLayout()
    }
    
    @IBAction func tapSkoop(_ sender: Any) {
//        addSkoop()
    }
    
    @IBAction func tapAddPhoto(_ sender: Any) {
        openImage()
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txtv_skoop.isFirstResponder{
            txtv_skoop.resignFirstResponder()
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if txtv_skoop.isFirstResponder{
            txtv_skoop.resignFirstResponder()
        }
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
            if Int(image_index)! >= self.old_image.count {
                self.new_image.remove(at: Int(image_index)! - self.old_image.count)
            }
            else {
                self.old_image.remove(at: Int(image_index)!)
                self.old_image_id.remove(at: Int(image_index)!)
            }
            self.all_image.remove(at: Int(image_index)!)
            self.collection_photo.reloadData()
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return all_image.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ActivityPhoto2_CVC
        cell.image_photo.image = all_image[indexPath.row]
        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.image_id = old_image_id[indexPath.row]
        tap.image_index = String(indexPath.row)
        cell.icon_delete.addGestureRecognizer(tap)
        cell.icon_delete.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collection_photo.frame.width / 2) - 3, height: (collection_photo.frame.width / 2) - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "previewimage") as? PreviewImage_VC
        vc?.image = all_image[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_skoop" {
            let sg = segue.destination as? SelectLocation_VC
            sg!.page_type = "from_skoop"
        }
    }
}
