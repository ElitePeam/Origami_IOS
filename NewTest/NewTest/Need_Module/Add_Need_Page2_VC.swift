//
//  Add_Need_Page2_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 15/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import WeScan
import DropDown
import SCLAlertView
import NVActivityIndicatorView

class Add_Need_Page2_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate, ImageScannerControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collection_upload: UICollectionView!
    @IBOutlet weak var collection_item: UICollectionView!
    @IBOutlet weak var image_upload: UIImageView!
    @IBOutlet weak var textview_detail: UITextView!
    @IBOutlet weak var textfield_price: UITextField!
    @IBOutlet weak var textfield_unit: UITextField!
    @IBOutlet weak var textfield_total: UITextField!
    @IBOutlet weak var choose_image_button: UIButton!
    @IBOutlet weak var scroll_view: UIView!
    @IBOutlet weak var picker_type: UITextField!
    @IBOutlet weak var picker_unit: UITextField!
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var view_unit: UIView!
    @IBOutlet weak var apply_button: UIButton!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_detail: UILabel!
    @IBOutlet weak var label_price: UILabel!
    @IBOutlet weak var label_quantity: UILabel!
    @IBOutlet weak var label_unit: UILabel!
    @IBOutlet weak var label_budget: UILabel!
    @IBOutlet weak var label_photo: UILabel!
    @IBOutlet weak var button_done: UIBarButtonItem!
    @IBOutlet weak var button_preview: UIButton!
    
    
    public class NeedItem {
        var item_id: String
        var type: String
        var type_id: String
        var detail: String
        var price: String
        var amount: String
        var unit: String
        var total: String
        var image: [UIImage]
        var new_image: [UIImage]
        init(item_id: String,type: String,type_id: String,detail: String,price: String,amount: String,unit: String,total: String,image: [UIImage],new_image: [UIImage]) {
            self.item_id = item_id
            self.type = type
            self.type_id = type_id
            self.detail = detail
            self.price = price
            self.amount = amount
            self.unit = unit
            self.total = total
            self.image = image
            self.new_image = new_image
        }
    }
    
    var needDetailLists:NeedDetailLists? = nil
    var needDetail_Unit:NeedDetail_Unit? = nil
    var needDetail_Type:NeedDetail_Type? = nil
    var needItemDetail:NeedItemDetail? = nil
    var item_Id:Item_Id?        = nil
    var request_Id:Request_Id?  = nil
    var sended_data:NeedList?   = nil
    var itemDetail:ItemDetail?  = nil
    var updateNeed:UpdateNeed?  = nil
    var selectedItem: NeedItem? = nil
    var needItem = [NeedItem]()
    var new_needItem = [NeedItem]()
    var all_needItem = [NeedItem]()
    var imagePicker = UIImagePickerController()
    let dropDown_unit = DropDown()
    let dropDown_type = DropDown()
    var need_date: String?
    var need_topic: String?
    var need_reason: String?
    var array_unit : [String] = []
    var array_type : [String] = []
    var array_type_id : [String] = []
    var array_image : [UIImage] = []
    var array_new_image : [UIImage] = []
    var count_image = 0
    var item_row = 0
    var project_id : String?
    var type_id : String?
    var dept_id : String?
    var typerq_id : String?
    var need_type_id : String?
    var request_id : Int?
    var item_id : Int?
    var sended_type = "add"
    var selected_unit = ""
    var selected_type = ""
    var selected_image = UIImage()
    var selected_image_index = 0
    var edit_add = false
    var have_new_update = false
    let pickerView_type = UIPickerView()
    let pickerView_unit = UIPickerView()
    var item_index = 0
    var newItem_index:[Int] = []
    var newImg_index:[Int] = []
    var delete_item = ""
    var preview_image = UIImageView()
    var preview_view  = UIView()
    var preview_close = UIImageView()
    let screen = UIScreen.main.bounds
    var callback = 0
    var delete = false
    var back_from = false
    var image_index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "need_detail".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        let done_save = UIBarButtonItem(title: "done".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        
        view_bg.backgroundColor = gb.color_background
        imagePicker.delegate = self
        textview_detail.delegate = self
        textview_detail.layer.cornerRadius = 5
        textview_detail.layer.borderWidth = 1
        textview_detail.layer.borderColor = gb.color_border.cgColor
        collection_upload.layer.cornerRadius = 5
        collection_upload.layer.borderWidth = 1
        collection_upload.layer.borderColor = gb.color_border.cgColor
        collection_item.layer.shadowOffset = CGSize(width: 0, height: 2)
        collection_item.layer.shadowRadius = 3
        collection_item.layer.shadowOpacity = 1
        collection_item.layer.shadowColor = UIColor.lightGray.cgColor
        collection_item.clipsToBounds = false
        collection_item.layer.masksToBounds = false
        apply_button.layer.cornerRadius = 4
        apply_button.layer.borderWidth = 1
        apply_button.layer.borderColor = UIColor.systemRed.cgColor
        apply_button.clipsToBounds = true
        
        label_type.text = "need_type".localized(gb.lang_now)
        label_detail.text = "detail".localized(gb.lang_now)
        label_price.text = "price".localized(gb.lang_now)
        label_quantity.text = "quantity".localized(gb.lang_now)
        label_unit.text = "unit".localized(gb.lang_now)
        label_budget.text = "total_budget".localized(gb.lang_now)
        label_photo.text =  "add_photo".localized(gb.lang_now)
        
        picker_type.placeholder = "need_type".localized(gb.lang_now)
        picker_unit.placeholder = "unit".localized(gb.lang_now)
        textfield_unit.placeholder = "quantity".localized(gb.lang_now)
        textfield_total.placeholder = "total_budget".localized(gb.lang_now)
        textfield_price.placeholder = "price".localized(gb.lang_now)
        
        picker_type.addTarget(self, action: #selector(Add_Need_Page2_VC.auto(_:)),
        for: .editingChanged)
        picker_unit.addTarget(self, action: #selector(Add_Need_Page2_VC.auto(_:)),
        for: .editingChanged)
        textfield_unit.addTarget(self, action: #selector(Add_Need_Page2_VC.auto(_:)),
        for: .editingChanged)
        textfield_total.addTarget(self, action: #selector(Add_Need_Page2_VC.auto(_:)),
        for: .editingChanged)
        textfield_price.addTarget(self, action: #selector(Add_Need_Page2_VC.auto(_:)),
        for: .editingChanged)
        
        getUnitList()
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = UIColor.white
        let cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        cancelButton.tintColor = UIColor.systemOrange
        doneButton.tintColor = UIColor.systemOrange
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        pickerView_type.delegate = self
        pickerView_unit.delegate = self
        picker_type.inputView = pickerView_type
        picker_unit.inputView = pickerView_unit
        picker_type.inputAccessoryView = toolBar
        picker_unit.inputAccessoryView = toolBar
        textfield_price.inputAccessoryView = toolBar
        textfield_unit.inputAccessoryView = toolBar
        textview_detail.inputAccessoryView = toolBar
        
        apply_button.setTitle("delete".localized(gb.lang_now), for: .normal)
        if sended_type == "add" {
            addBlank()
        }
        else {
            getItemDetail()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if gb.image_del {
            gb.image_del = false
            delete_image_preview()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if picker_unit.isFirstResponder {
                if picker_unit.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if textfield_unit.isFirstResponder {
                if textfield_unit.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if textfield_price.isFirstResponder {
                if textfield_price.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if textview_detail.isFirstResponder {
                if textview_detail.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if textfield_total.isFirstResponder {
                if textfield_total.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getUnitList(){
        let postString = "idComp=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_DETAILS)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.needDetailLists = try JSONDecoder().decode(NeedDetailLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if (self.needDetailLists?.unit != nil ) {
                        for item in (self.needDetailLists?.unit)! {
                            self.array_unit.append(item.uom_code!)
                        }
                    }
                    if (self.needDetailLists?.type != nil ) {
                        for item in (self.needDetailLists?.type)! {
                            self.array_type.append(item.mny_item_name!)
                            self.array_type_id.append(item.mny_item_id!)
                        }
                    }
                    self.picker_unit.text = self.array_unit[0]
                    self.selected_unit = self.array_unit[0]
                }
            }
        }
        task.resume()
    }
    
    func sendNeedRequest(){
        var sum_total : Double = 0
        if self.all_needItem.count != 0 {
            for item in self.all_needItem {
                sum_total += Double(item.total)!
            }
        }
        let postString = "compID=\(String((gb.user?.comp_id)!))&doc_for_emp=\(String((gb.user?.emp_id)!))&doc_type=\(String(typerq_id!))&department_select=\(String(dept_id!))&document_type=\(String(type_id!))&dateofdoc=\(String(need_date!))&doc_location=\(String(need_topic!))&documnt_note=\(String(need_reason!))&total=\(String(sum_total))&pass=\(String(project_id!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_NEED)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.request_Id = try JSONDecoder().decode(Request_Id.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.request_id = self.request_Id?.request_id
                    if self.all_needItem.count != 0 {
                        for item in self.all_needItem {
                            self.sendNeedItem(nd_id: item.type_id, nd_price: item.price, nd_amount: item.amount, nd_unit: item.unit, nd_total: item.total, nd_detail: item.detail, nd_image: item.image)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    //For add
    func sendNeedItem(nd_id: String, nd_price: String, nd_amount: String, nd_unit: String, nd_total: String, nd_detail: String, nd_image: [UIImage]){
        let postString = "requestid=\(String(request_id!))&pdSel=\(String(nd_id))&pdPrice=\(String(nd_price))&pdQuantity=\(String(nd_amount))&pdUnit=\(String(nd_unit))&pdAmount=\(String(nd_total))&pdNote=\(String(nd_detail))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_NEED_ITEM)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.item_Id = try JSONDecoder().decode(Item_Id.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    var seq = 1
                    self.item_id = self.item_Id?.ins_item_id
                    if nd_image.count != 0 {
                        for img in nd_image {
                            self.sendNeedItemImage_ADD(up_image: img , nd_type_id: nd_id , nd_item_id: self.item_id! , sequence: seq)
                            seq += 1
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    //For add
    func sendNeedItemImage_ADD(up_image: UIImage , nd_type_id: String , nd_item_id: Int , sequence: Int){
        let sequence = String(sequence)
        let image_name = "\(Date().millisecondsSince1970).jpeg"
        var image_base64 = ""
        let image_data = up_image.jpegData(compressionQuality: 1)
        image_base64 = image_data!.base64EncodedString()
        image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
        
        let postString = "requestid=\(String(request_id!))&pdSel=\(String(nd_type_id))&ins_item_id=\(String(nd_item_id))&index_item=\(String(sequence))&imgName=\(String(image_name))&base64=\(String(image_base64))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_NEED_ITEM_IMAGE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do{
                   
                }
            }
        }
        task.resume()
    }
    
    //For update
    func sendNeedItemImage(up_image: UIImage , nd_type_id: String , nd_item_id: Int , sequence: Int){
        let sequence = String(sequence)
        let image_name = "\(Date().millisecondsSince1970).jpeg"
        var image_base64 = ""
        let image_data = up_image.jpegData(compressionQuality: 1)
        image_base64 = image_data!.base64EncodedString()
        image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
        
        let postString = "requestid=\(String((sended_data?.id!)!))&pdSel=\(String(nd_type_id))&ins_item_id=\(String(nd_item_id))&index_item=\(String(sequence))&imgName=\(String(image_name))&base64=\(String(image_base64))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_NEED_ITEM_IMAGE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do{
                   
                }
            }
        }
        task.resume()
    }
    
    //For delete image when update
    func deleteItemImage(nd_item_id: Int, image: [UIImage], type_id: String){
        let postString = "item_id=\(String(nd_item_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_ITEM_IMAGE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do{
                   var seq = 1
                   if image.count != 0 {
                       for img in image {
                        self.sendNeedItemImage(up_image: img , nd_type_id: type_id , nd_item_id: nd_item_id , sequence: seq)
                           seq += 1
                       }
                   }
                }
            }
        }
        task.resume()
    }
    
    func getItemDetail(){
        let request_id = sended_data?.id
        let postString = "requestid=\(String(request_id!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_ITEM_DETAIL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.needItemDetail = try JSONDecoder().decode(NeedItemDetail.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    for item in self.needItemDetail!.data! {
                        var tmp_image : [UIImage] = []
                        let tmp_new_image : [UIImage] = []
                        if item.listImg != nil {
                            for img in item.listImg! {
                                if img != "" {
                                    var imageString = "\(Const_Var.BASE_URL)\(String(((img.replacingOccurrences(of: "\\", with: "")))))"
                                    imageString = "\(String(imageString.replacingOccurrences(of: "..", with: "")))"
                                    let url = URL(string: imageString)
                                    if url != nil {
                                        do{
                                            let data = try Data(contentsOf: url!)
                                            tmp_image.append(UIImage(data: data) ?? UIImage(named:"dummy_pdf")!)
                                        }
                                        catch{
                                            tmp_image.append(UIImage(named:"dummy_pdf")!)
                                        }
                                    }
                                    else {
                                        tmp_image.append(UIImage(named:"dummy_pdf")!)
                                    }
                                }
                                else {
                                    tmp_image.append(UIImage(named:"dummy_pdf")!)
                                }
                            }
                        }
                        
                        let new_need_item = NeedItem(
                            item_id : item.mny_item_sort_no!,
                            type    : item.item_name!,
                            type_id : item.mny_item_id!,
                            detail  : item.mny_request_item_note!,
                            price   : item.mny_request_item_price!,
                            amount  : item.mny_request_item_quantity!,
                            unit    : item.unit!,
                            total   : item.mny_request_total!,
                            image   : tmp_image,
                            new_image: tmp_new_image)
                        self.needItem.append(new_need_item)
                        self.collection_item.reloadData()
                        self.collection_upload.reloadData()
                    }
                    self.all_needItem = self.needItem
                    self.selectedItem = self.needItem[0]
                    self.need_type_id = self.selectedItem?.type_id
                    self.picker_type.text = self.selectedItem?.type
                    self.picker_unit.text = self.selectedItem!.unit
                    self.array_image = self.selectedItem!.image
                    self.collection_upload.reloadData()
                    self.textview_detail.text = self.selectedItem?.detail
                    
                    let p = Int(Double(String(self.selectedItem!.price))!)
                    self.textfield_price.text = "\(String(p))"
                    
                    let u = Int(Double(String(self.selectedItem!.amount))!)
                    self.textfield_unit.text = "\(String(u))"
                    
                    let t = Int(Double(String(self.selectedItem!.total))!)
                    self.textfield_total.text = "\(String(t))"
                    
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func sendUpdateNeedRequest(){
        var sum_total : Double = 0
        if self.needItem.count != 0 {
            for item in self.needItem {
                sum_total += Double(item.total)!
            }
            
            if have_new_update {
                for item in new_needItem {
                    sum_total += Double(item.total)!
                }
            }
        }
        let postString = "doc_type=\(String(typerq_id!))&department_select=\(String(dept_id!))&document_type=\(String(type_id!))&dateofdoc=\(String(need_date!))&doc_location=\(String(need_topic!))&doc_note=\(String(need_reason!))&total=\(String(sum_total))&requestId=\(String(sended_data!.id!))&projectId=\(String(project_id!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.UPDATE_NEED)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.updateNeed = try JSONDecoder().decode(UpdateNeed.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    for item in self.needItem {
                        if item.item_id != "" {
                            self.sendUpdateNeedItem(request_id: self.sended_data!.id!, item_id: item.item_id, type_id: item.type_id, price: item.price, quantity: item.amount, unit: item.unit, amount: item.total, detail: item.detail, image: item.image, new_image: item.new_image)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func sendUpdateNeedItem(request_id: String, item_id: String, type_id: String, price: String, quantity: String, unit: String, amount: String, detail: String, image: [UIImage], new_image: [UIImage]){
        
        var extend_delete = ""
        if delete_item != ""{
            delete_item = String(delete_item.dropLast())
            extend_delete = "&delItem=\(String(delete_item))"
        }
        let postString = "requestId=\(String(request_id))&item_no=\(String(item_id))&pdSel=\(String(type_id))&pdPrice=\(String(price))&pdQuantity=\(String(quantity))&pdUnit=\(String(unit))&pdAmount=\(String(amount))&pdNote=\(String(detail))\(String(extend_delete))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.UPDATE_NEED_ITEM)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.updateNeed = try JSONDecoder().decode(UpdateNeed.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.deleteItemImage(nd_item_id: Int(item_id)!, image: image, type_id: type_id)
                }
            }
        }
        task.resume()
    }
    
    func sendAddNeedItem(nd_id: String, nd_price: String, nd_amount: String, nd_unit: String, nd_total: String, nd_detail: String, nd_image: [UIImage]){
        let postString = "requestid=\(String((sended_data?.id!)!))&pdSel=\(String(nd_id))&pdPrice=\(String(nd_price))&pdQuantity=\(String(nd_amount))&pdUnit=\(String(nd_unit))&pdAmount=\(String(nd_total))&pdNote=\(String(nd_detail))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_NEED_ITEM)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.item_Id = try JSONDecoder().decode(Item_Id.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    var seq = 1
                    self.item_id = self.item_Id?.ins_item_id
                    if nd_image.count != 0 {
                        for img in nd_image {
                            self.sendNeedItemImage(up_image: img , nd_type_id: nd_id , nd_item_id: self.item_id! , sequence: seq)
                            seq += 1
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func tapApply(_ sender: Any) {
        if all_needItem.count > 1 {
            if all_needItem[item_index].item_id != ""{
                if delete_item == "" {
                    delete_item = "\(String(all_needItem[item_index].item_id)),"
                }
                else {
                    delete_item = "\(delete_item)\(String(all_needItem[item_index].item_id)),"
                }
            }
            
            all_needItem.remove(at: item_index)
            needItem.remove(at: item_index)
            
            if let index = newItem_index.firstIndex(of: item_index) {
                newItem_index.remove(at: index)
                for (i, element) in newItem_index.enumerated() {
                    if element > item_index {
                        newItem_index[i] -= 1
                    }
                }
            }
            
            item_index = all_needItem.count - 1
            collection_item.reloadData()
                
            let indexPath = IndexPath(item: all_needItem.count, section: 0)
            collection_item.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            self.collectionView(collection_item, didSelectItemAt: indexPath)
        }
        else {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "delete_first_item".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
    }
    
    func autoSave(){
        if need_type_id == nil {
            need_type_id = ""
        }
        calTotal()
        needItem[item_index].type = picker_type.text!
        needItem[item_index].type_id = need_type_id!
        needItem[item_index].detail = textview_detail.text!
        needItem[item_index].price = textfield_price.text!
        needItem[item_index].amount = textfield_unit.text!
        needItem[item_index].unit = picker_unit.text!
        needItem[item_index].total = textfield_total.text!
        needItem[item_index].image = array_image
        all_needItem = needItem
    }
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        var pass = true
        if sended_type == "add" {
            if all_needItem[item_index].type_id != "" {
                sendNeedRequest()
            }
            else {
                SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                pass = false
            }
        }
        else{
            if all_needItem[item_index].type_id != "" {
                sendUpdateNeedRequest()
                if have_new_update {
                    if newItem_index.count != 0 {
                        for index in newItem_index {
                            let item = all_needItem[index]
                            sendAddNeedItem(nd_id: item.type_id, nd_price: item.price, nd_amount: item.amount, nd_unit: item.unit, nd_total: item.total, nd_detail: item.detail, nd_image: item.image)
                        }
                    }
                }
            }
            else {
                SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                pass = false
            }
        }
        
        if pass {
            var alert_txt = ""
             if self.sended_type == "add" {
                alert_txt = "Add need success!"
             }
             else {
                alert_txt = "Update need success!"
             }
            
             let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
             let alert = SCLAlertView(appearance: appearance)
             alert.addButton("Close") {
                alert.hideView()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "need") as? Need_VC
                self.navigationController?.pushViewController(vc!, animated: true)
             }
             alert.showSuccess("Success", subTitle: alert_txt, animationStyle: .noAnimation)
        }
    }
    
    @IBAction func tapChooseImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let choose = UIAlertAction(title: "Choose a Photo", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let take = UIAlertAction(title: "Take a New Photo", style: .default) { action in
//            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//                self.imagePicker.sourceType = .camera
//                self.imagePicker.allowsEditing = true
//                self.present(self.imagePicker, animated: true, completion: nil)
//            }
        
            let scannerViewController = ImageScannerController()
            scannerViewController.imageScannerDelegate = self
            scannerViewController.modalPresentationStyle = .fullScreen
            self.present(scannerViewController, animated: true)
        }
    
        actionSheet.addAction(choose)
        actionSheet.addAction(take)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func auto(_ textField: UITextField) {
        autoSave()
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        switch (textView) {
            case textview_detail:
                autoSave()
            default: break
        }
    }
    
    @objc func totalCalDidChange(_ textField: UITextField) {
        calTotal()
    }
    
    func calTotal(){
        var price = Double(textfield_price.text!)
        var unit  = Double(textfield_unit.text!)
        if price == nil {
            price = 0
        }
        if unit == nil {
            unit = 0
        }
        let total = String(Int(price! * unit!))
        textfield_total.text = String(total)
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if picker_type.isFirstResponder{
            if selected_type == "" || need_type_id == ""{
                selected_type = array_type[0]
                need_type_id = array_type_id[0]
            }
            picker_type.text = selected_type
            picker_type.resignFirstResponder()
            autoSave()
        }
        else if textfield_price.isFirstResponder{
            if textfield_price.text == ""{
                textfield_price.text = "0"
            }
            var i = Int(textfield_price.text!)!
            textfield_price.text = String(i)
            
            textfield_price.resignFirstResponder()
        }
        else if textfield_unit.isFirstResponder{
            textfield_unit.resignFirstResponder()
        }
        else if textview_detail.isFirstResponder{
            textview_detail.resignFirstResponder()
        }
        else {
            if selected_unit == "" {
                selected_unit = array_unit[0]
            }
            picker_unit.text = selected_unit
            picker_unit.resignFirstResponder()
            autoSave()
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if picker_type.isFirstResponder{
            picker_type.resignFirstResponder()
        }
        else if textfield_price.isFirstResponder{
            textfield_price.resignFirstResponder()
        }
        else if textfield_unit.isFirstResponder{
            textfield_unit.resignFirstResponder()
        }
        else if textview_detail.isFirstResponder{
            textview_detail.resignFirstResponder()
        }
        else {
            picker_unit.resignFirstResponder()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            array_image.append(image)
            collection_upload.reloadData()
            if sended_type == "edit" {
                array_new_image.append(image)
                needItem[item_index].new_image = array_new_image
                newImg_index.append(array_image.count - 1)
            }
            autoSave()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var row = 0
        if collectionView == collection_item {
            if sended_type == "add"{
                row = (all_needItem.count + 1)
            }
            else {
                row = (all_needItem.count + 1)
            }
        }
        else {
            row = array_image.count
        }
        return row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection_item {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NeedItemCollectionViewCell
            
            if indexPath.row == 0 {
                let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 90, weight: .thin, scale: .large)
                let homeImage = UIImage(systemName: "plus.circle", withConfiguration: homeSymbolConfiguration)
                cell.image_item.image = homeImage
                cell.image_item.backgroundColor = UIColor.clear
                cell.label_item.text = ""
            }
            else {
                if indexPath.row == (item_index + 1){
                    let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 90, weight: .thin, scale: .large)
                    let homeImage = UIImage(systemName: "circle.fill", withConfiguration: homeSymbolConfiguration)
                    cell.image_item.image = homeImage
                    cell.label_item.text = String(indexPath.row)
                    cell.label_item.textColor = UIColor.white
                    cell.image_item.backgroundColor = UIColor.clear
                }
                else {
                    let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 90, weight: .thin, scale: .large)
                    let homeImage = UIImage(systemName: "circle", withConfiguration: homeSymbolConfiguration)
                    cell.image_item.image = homeImage
                    cell.label_item.text = String(indexPath.row)
                    cell.label_item.textColor = UIColor.systemOrange
                    cell.image_item.backgroundColor = UIColor.clear
                }
            }
            return cell
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_2", for: indexPath) as! NeedUploadCollectionViewCell
            cell2.image_upload.image = array_image[indexPath.row]
            
            return cell2
        }
    }
    
    func delete_image_preview() {
        array_image.remove(at: selected_image_index)
        if sended_type == "edit" {
            if let index = newImg_index.firstIndex(of: selected_image_index) {
                newImg_index.remove(at: index)
                for (i, element) in newImg_index.enumerated() {
                    if element > selected_image_index {
                        newImg_index[i] -= 1
                    }
                }
            }
            else {
                if newImg_index.count > 0 {
                    for (i, _) in newImg_index.enumerated() {
                        newImg_index[i] -= 1
                    }
                }
            }
            needItem[item_index].new_image = array_new_image
            all_needItem = needItem
        }
        autoSave()
        collection_upload.reloadData()
    }
    
    @objc func tap_close_preview(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.2,
                             delay: 0,
                             options: UIView.AnimationOptions.curveLinear,
        animations: { () -> Void in
            self.preview_view.frame  = CGRect(x: 0, y: self.screen.height, width: self.screen.width, height: self.screen.height - 20)
        }, completion: { (finished) -> Void in
//            self.preview_view.isHidden = true
//            self.preview_image.isHidden = true
            self.preview_close.isHidden = true
        })
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.cellForItem(at: indexPath)
        if collectionView == collection_item {
            if indexPath.row == 0 {
                if sended_type == "add" {
                    if all_needItem[item_index].type_id != "" {
                        addBlank()
                        clearInput()
                    }
                    else {
                        SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                }
                else {
                    if have_new_update {
                        if all_needItem[item_index].type_id != "" {
                            addBlank()
                            clearInput()
                        }
                        else {
                            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                        }
                    }
                    else {
                        edit_add = true
                        have_new_update = true
                        addBlank()
                        clearInput()
                    }
                    
                }
            }
            else{
                if all_needItem[item_index].type_id != "" || (item_index + 1) == indexPath.row {
                    item_index = indexPath.row - 1
                    edit_add = false
                    let need = all_needItem[item_index]
                    selectedItem = need
                    need_type_id = need.type_id
                    picker_type.text = need.type
                    picker_unit.text = need.unit
                    array_image = need.image
                    collection_upload.reloadData()
                    textview_detail.text = need.detail
//                    textfield_price.text = need.price
//                    textfield_unit.text = need.amount
//                    textfield_total.text = need.total
                    
                    let p = Int(Double(String(need.price))!)
                    self.textfield_price.text = "\(String(p))"
                    
                    let u = Int(Double(String(need.amount))!)
                    self.textfield_unit.text = "\(String(u))"
                    
                    let t = Int(Double(String(need.total))!)
                    self.textfield_total.text = "\(String(t))"
                    
                    collection_item.reloadData()
                }
                else {
                    SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                }
                
            }
        }
        else {
            selected_image = array_image[indexPath.row]
            selected_image_index = indexPath.row
            button_preview.sendActions(for: .touchUpInside)
        }
    }
    
    func addBlank(){
        let tmp_new_image : [UIImage] = []
        let new_need_item = NeedItem(
            item_id : "",
            type    : "",
            type_id : "",
            detail  : "",
            price   : "0",
            amount  : "1",
            unit    : "",
            total   : "0",
            image   : tmp_new_image,
            new_image: tmp_new_image)
        needItem.append(new_need_item)
        all_needItem = needItem
        item_index = all_needItem.count - 1
        if sended_type == "edit" {
            newItem_index.append(item_index)
        }
        collection_item.reloadData()
        textfield_unit.text = "1"
        textfield_price.text = "0"
        textfield_total.text = "0"
    }
    
    func clearInput(){
        need_type_id = ""
        picker_type.text = ""
        picker_unit.text = array_unit[0]
        array_image = []
        collection_upload.reloadData()
        textview_detail.text = ""
        textfield_price.text = "0"
        textfield_unit.text = "1"
        textfield_total.text = "0"
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView_type {
            return array_type.count
        }
        else {
            return array_unit.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView_type {
            return array_type[row]
        }
        else {
            return array_unit[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView_type {
            selected_type = array_type[row]
            need_type_id = array_type_id[row]
        }
        else {
            selected_unit = array_unit[row]
        }
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
    }

    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        let image:UIImage = results.croppedScan.image
        array_image.append(image)
        collection_upload.reloadData()
        if sended_type == "edit" {
            array_new_image.append(image)
            needItem[item_index].new_image = array_new_image
            newImg_index.append(array_image.count - 1)
        }
        autoSave()
        scanner.dismiss(animated: true)
    }

    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sb = segue.destination as! Preview_Image_VC
        sb.sd_image = selected_image
    }
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
