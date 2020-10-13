//
//  FieldAccount_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 30/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import PhoneNumberKit

class FieldAccount_VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var txt_fax: UITextField!
    @IBOutlet weak var txt_type: UITextField!
    @IBOutlet weak var txt_comp_size: UITextField!
    @IBOutlet weak var txt_regist: UITextField!
    @IBOutlet weak var txt_regist_cap: UITextField!
    @IBOutlet weak var txt_num_staff: UITextField!
    @IBOutlet weak var txt_pay_term: UITextField!
    @IBOutlet weak var txt_tax_id: UITextField!
    @IBOutlet weak var txt_old_code: UITextField!
    @IBOutlet weak var txt_descript: UITextField!
    @IBOutlet weak var txt_map_location: UITextField!
    @IBOutlet weak var txt_ship: UITextField!
    @IBOutlet weak var txt_doc_address: UITextField!
    @IBOutlet weak var txt_file: UITextField!
    @IBOutlet weak var btn_send_data: UIButton!
    @IBOutlet weak var btn_go_location: UIButton!
    @IBOutlet weak var view_choose_image: UIView!
    @IBOutlet weak var label_choose_image: UILabel!
    @IBOutlet weak var image_choose_image: UIImageView!
    @IBOutlet weak var type_fax: UITextField!
    @IBOutlet weak var ship_address: UITextView!
    @IBOutlet weak var doc_address: UITextView!
    @IBOutlet weak var ship_icon: UIButton!
    @IBOutlet weak var doc_icon: UIButton!
    
    
    var typeLists:[StatusLists]? = nil
    var registLists:[TypeLists]? = nil
    var payment:[Payment]? = nil
    var accountList:AccountList? = nil
    var accountAdd:AccountList? = nil
    var numberType:[NumberType]? = nil
    var txts : [UITextField] = []
    var txtv : [UITextView] = []
    var txts_phd : [String] = []
    var txtv_phd : [String] = []
    let pickerView_type = UIPickerView()
    let pickerView_regist = UIPickerView()
    let pickerView_payment = UIPickerView()
    let pickerView_compsize = UIPickerView()
    let pickerView_type_fax = UIPickerView()
    var imagePicker = UIImagePickerController()
    var selected_type_name = ""
    var selected_type_id   = ""
    var selected_regist_name = ""
    var selected_regist_id   = ""
    var selected_payment_name = ""
    var selected_payment_id   = ""
    var selected_compsize = ""
    var selected_shipAddress = ""
    var selected_shipLocation = ""
    var selected_shipLng = "0.0"
    var selected_shipLat = "0.0"
    var selected_docAddress = ""
    var selected_docLocation = ""
    var selected_docLng = "0.0"
    var selected_docLat = "0.0"
    var type_page = ""
    var Comp_Size = ["Enterprise/ใหญ่","Medium/กลาง","Small/เล็ก"]
    var send_from = ""
    var selected_location_name = ""
    var selected_location_image = UIImage()
    var toolBar : UIToolbar = UIToolbar()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    var doneButton = UIBarButtonItem()
    var slt_fax_type = ""
    var slt_fax_dial = ""
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        self.title = "more_info".localized(gb.lang_now)
        label_choose_image.text = "choose_map_image".localized(gb.lang_now)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        
        navigationController?.delegate = self
        
        imagePicker.delegate = self

        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        pickerView_type.delegate = self
        txt_type.inputView = pickerView_type
        txt_type.inputAccessoryView = toolBar
        
        pickerView_regist.delegate = self
        txt_regist.inputView = pickerView_regist
        txt_regist.inputAccessoryView = toolBar
        
        pickerView_payment.delegate = self
        txt_pay_term.inputView = pickerView_payment
        txt_pay_term.inputAccessoryView = toolBar
        
        pickerView_compsize.delegate = self
        txt_comp_size.inputView = pickerView_compsize
        txt_comp_size.inputAccessoryView = toolBar
        
        pickerView_type_fax.delegate = self
        type_fax.inputView = pickerView_type_fax
        type_fax.inputAccessoryView = toolBar
    
        
        txtv = [ship_address,doc_address]
        txts = [txt_fax, txt_type,txt_comp_size,txt_regist,txt_regist_cap,txt_num_staff,txt_pay_term,txt_tax_id,txt_old_code,txt_descript,txt_map_location,txt_ship,txt_doc_address,txt_file,type_fax]
        txtv_phd = ["ship_to".localized(gb.lang_now),"doc_address".localized(gb.lang_now)]
        txts_phd = ["fax".localized(gb.lang_now), "type".localized(gb.lang_now),"com_size".localized(gb.lang_now),"regist".localized(gb.lang_now),"regist_cap".localized(gb.lang_now),"number_staff".localized(gb.lang_now),"payment_term".localized(gb.lang_now),"tax_id".localized(gb.lang_now),"old_code".localized(gb.lang_now),"description".localized(gb.lang_now),"Map location (image)","search_ship".localized(gb.lang_now),"search_doc".localized(gb.lang_now),"Attach file","+66"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let tap_choose_image: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choose_image))
        view_choose_image.addGestureRecognizer(tap_choose_image)
        
        for txtv_item in txtv {
            setKeyborad2(txt_view: txtv_item)
            setTextView(txt_view: txtv_item)
        }
        
        if type_page == "edit" {
            let ac = accountList
            txt_regist_cap.text = ac?.cus_cost_register
            txt_num_staff.text  = ac?.cus_all_staff
            txt_tax_id.text     = ac?.cus_tax_no
            txt_old_code.text   = ac?.cus_code_old
            txt_descript.text   = ac?.cus_description
            txt_type.text       = ac?.cus_type_name
            txt_comp_size.text  = ac?.cus_size
            txt_regist.text     = ac?.cus_status_name
            txt_pay_term.text   = ac?.cus_type_doc_name
            txt_ship.text       = ac?.ship_location_name
            txt_doc_address.text = ac?.doc_location_name
            ship_address.text   = ac?.ship_address ?? ""
            doc_address.text    = ac?.doc_address ?? ""
            
            if ship_address.text != "" && ship_address.text != "ship_to".localized(gb.lang_now){
                ship_address.textColor = gb.color_darkgrey
            }
            else {
                let index = txtv.firstIndex(of: ship_address)
                ship_address.text = txtv_phd[index!]
                ship_address.textColor = UIColor.lightGray
            }
            
            if doc_address.text != "" && doc_address.text != "doc_address".localized(gb.lang_now){
                doc_address.textColor = gb.color_darkgrey
            }
            else {
                let index = txtv.firstIndex(of: doc_address)
                doc_address.text = txtv_phd[index!]
                doc_address.textColor = UIColor.lightGray
            }
            slt_fax_dial    = ac?.fax_dial ?? ""
            let str_fax     = ac?.cus_fax_no ?? ""
            do {
                let str_fax_   = try phoneNumberKit.parse(String(str_fax))
                type_fax.text  = "+\(String(str_fax_.countryCode))"
                txt_fax.text   = String(str_fax_.nationalNumber)
            }
            catch {
                if slt_fax_dial != "" {
                    type_fax.text  = slt_fax_dial
                    txt_fax.text   = str_fax.replacingOccurrences(of: "\(slt_fax_dial)", with: "")
                }
                else {
                    txt_fax.text   = str_fax.replacingOccurrences(of: "+66", with: "")
                }
            }
            
   

            var s_lat = ac?.ship_latitude   ?? "0.0"
            var s_lng = ac?.ship_longtitude ?? "0.0"
            var d_lat = ac?.doc_latitude    ?? "0.0"
            var d_lng = ac?.doc_longtitude  ?? "0.0"
            if s_lat == "" || s_lat == "-"{
                s_lat = "0.0"
            }
            if s_lng == "" || s_lng == "-"{
                s_lng = "0.0"
            }
            if d_lat == "" || d_lat == "-" {
                d_lat = "0.0"
            }
            if d_lng == "" || d_lng == "-" {
                d_lng = "0.0"
            }
            selected_shipLocation  = (ac?.ship_location_name ?? "-")
            selected_shipLat       = s_lat
            selected_shipLng       = s_lng
            selected_docLocation   = (ac?.doc_location_name ?? "-")
            selected_docLat        = d_lat
            selected_docLng        = d_lng
            
            selected_type_name      = ac?.cus_status_name   ?? "-"
            selected_type_id        = ac?.cus_status_id     ?? "-"
            selected_regist_name    = ac?.cus_type_name     ?? "-"
            selected_regist_id      = ac?.cus_type_id       ?? "-"
            selected_payment_name   = ac?.cus_type_doc_name ?? "-"
            selected_payment_id     = ac?.cus_type_doc_id   ?? "-"
            selected_compsize       = ac?.cus_size          ?? "-"
            image_choose_image.image = selected_location_image
        }
        else {
            type_fax.text = gb.newAccount.fax_dial
            let str_fax = gb.newAccount.fax
            let split_fax = str_fax.components(separatedBy: " ")
            if split_fax.count == 1 {
                txt_fax.text        = str_fax
            }
            else if split_fax.count == 2 {
                type_fax.text       = split_fax[0]
                txt_fax.text        = split_fax[1]
            }
            else {
                type_fax.text       = "\(split_fax[0])\(split_fax[1])"
                txt_fax.text        = split_fax[2]
            }
            txt_regist_cap.text = gb.newAccount.regist_capital
            txt_num_staff.text  = gb.newAccount.number_staff
            txt_tax_id.text     = gb.newAccount.tax_id
            txt_old_code.text   = gb.newAccount.old_code
            txt_descript.text   = gb.newAccount.description
            txt_comp_size.text  = gb.newAccount.comp_size
            txt_pay_term.text   = gb.newAccount.payterm_name
            txt_regist.text     = gb.newAccount.regist_name
            txt_type.text       = gb.newAccount.status
            ship_address.text   = gb.newAccount.shipAddress
            doc_address.text    = gb.newAccount.docAddress
            selected_payment_id = gb.newAccount.payterm
            selected_type_id    = gb.newAccount.group_id
            selected_regist_id  = gb.newAccount.regist
            selected_location_image = gb.account_map_location
            image_choose_image.image = selected_location_image
            if ship_address.text != "" && ship_address.text != "ship_to".localized(gb.lang_now){
                ship_address.textColor = gb.color_darkgrey
            }
            else {
                let index = txtv.firstIndex(of: ship_address)
                ship_address.text = txtv_phd[index!]
                ship_address.textColor = UIColor.lightGray
            }
            
            if doc_address.text != "" && doc_address.text != "doc_address".localized(gb.lang_now){
                doc_address.textColor = gb.color_darkgrey
            }
            else {
                let index = txtv.firstIndex(of: doc_address)
                doc_address.text = txtv_phd[index!]
                doc_address.textColor = UIColor.lightGray
            }
        }
        
        txt_descript.delegate = self
        txt_ship.delegate = self
        txt_doc_address.delegate = self
        
        ship_icon.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: 30, height: 30)), for: .normal)
        doc_icon.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: 30, height: 30)), for: .normal)
        closeLoad()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_ship {

        }
        if textField == txt_doc_address {

        }
    }
    
    @IBAction func tapShip(_ sender: Any) {
        send_from = "field_ship"
        selected_location_name = txt_ship.text!
        btn_go_location.sendActions(for: .touchUpInside)
    }
    
    @IBAction func tapDoc(_ sender: Any) {
        send_from = "field_doc"
        selected_location_name = txt_doc_address.text!
        btn_go_location.sendActions(for: .touchUpInside)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    @objc func choose_image() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
        
        let choose = UIAlertAction(title: "choose_photo".localized(gb.lang_now), style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let take = UIAlertAction(title: "new_photo".localized(gb.lang_now), style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(choose)
        actionSheet.addAction(take)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image_choose_image.image = image
            selected_location_image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func someAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if gb.ship_change {
            txt_ship.text           = gb.selected_shipLocation
            selected_shipLocation   = gb.selected_shipLocation
            selected_shipLat        = gb.selected_shipLat
            selected_shipLng        = gb.selected_shipLng
        }
        if gb.doc_change {
            txt_doc_address.text = gb.selected_docLocation
            selected_docLocation = gb.selected_docLocation
            selected_docLat      = gb.selected_docLat
            selected_docLng      = gb.selected_docLng
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        for txt_item in txts {
            setKeyborad(txt_field: txt_item)
            setTextField(txt_field: txt_item)
            setPlaceHolder(txt_field: txt_item)
        }
        closeLoad()
    }
    
    func setTextField(txt_field : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txt_field.frame.height - 1.5, width: txt_field.frame.width, height: 1.5)
        bottomLine.backgroundColor = gb.color_lightgrey.cgColor
        txt_field.borderStyle = UITextField.BorderStyle.none
        txt_field.textColor = gb.color_darkgrey
        txt_field.layer.addSublayer(bottomLine)
    }
    
    func setTextView(txt_view : UITextView) {
        txt_view.layer.cornerRadius = 3
        txt_view.layer.borderWidth = 1
        txt_view.textColor = UIColor.lightGray
        txt_view.backgroundColor = UIColor.white
        txt_view.layer.borderColor = gb.color_lightgrey.cgColor
        txt_view.delegate = self
        
        if (txt_view.textColor == UIColor.lightGray) || txt_view.text == ""{
            let index = txtv.firstIndex(of: txt_view)
            txt_view.text = txtv_phd[index!]
        }
    }
    
    func setPlaceHolder(txt_field : UITextField) {
        let index = txts.firstIndex(of: txt_field)
        txt_field.placeholder = txts_phd[index!]
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = gb.color_darkgrey
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            let index = txtv.firstIndex(of: textView)
            textView.text = txtv_phd[index!]
            textView.textColor = UIColor.lightGray
        }
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txt_type.isFirstResponder{
            txt_type.text = selected_type_name
            txt_type.resignFirstResponder()
        }
        else if (txt_regist.isFirstResponder) {
            txt_regist.text = selected_regist_name
            txt_regist.resignFirstResponder()
        }
        else if (txt_pay_term.isFirstResponder) {
            txt_pay_term.text = selected_payment_name
            txt_pay_term.resignFirstResponder()
        }
        else if (txt_comp_size.isFirstResponder) {
            txt_comp_size.text = selected_compsize
            txt_comp_size.resignFirstResponder()
        }
        else if (txt_fax.isFirstResponder) {
            txt_fax.resignFirstResponder()
        }
        else if (txt_regist_cap.isFirstResponder) {
            txt_regist_cap.resignFirstResponder()
        }
        else if (txt_num_staff.isFirstResponder) {
            txt_num_staff.resignFirstResponder()
        }
        else if (txt_tax_id.isFirstResponder) {
            txt_tax_id.resignFirstResponder()
        }
        else if (txt_old_code.isFirstResponder) {
            txt_old_code.resignFirstResponder()
        }
        else if (txt_descript.isFirstResponder) {
            txt_descript.resignFirstResponder()
        }
        else if type_fax.isFirstResponder{
            type_fax.text = slt_fax_type
            type_fax.resignFirstResponder()
        }
        else if ship_address.isFirstResponder{
            ship_address.resignFirstResponder()
        }
        else if doc_address.isFirstResponder{
            doc_address.resignFirstResponder()
        }
        else if txt_ship.isFirstResponder{
            txt_ship.resignFirstResponder()
        }
        else if txt_doc_address.isFirstResponder{
            txt_doc_address.resignFirstResponder()
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if txt_type.isFirstResponder{
            txt_type.resignFirstResponder()
        }
        else if (txt_regist.isFirstResponder) {
            txt_regist.resignFirstResponder()
        }
        else if (txt_pay_term.isFirstResponder) {
            txt_pay_term.resignFirstResponder()
        }
        else if (txt_comp_size.isFirstResponder) {
            txt_comp_size.resignFirstResponder()
        }
        else if (txt_fax.isFirstResponder) {
            txt_fax.resignFirstResponder()
        }
        else if (txt_regist_cap.isFirstResponder) {
            txt_regist_cap.resignFirstResponder()
        }
        else if (txt_num_staff.isFirstResponder) {
            txt_num_staff.resignFirstResponder()
        }
        else if (txt_tax_id.isFirstResponder) {
            txt_tax_id.resignFirstResponder()
        }
        else if (txt_old_code.isFirstResponder) {
            txt_old_code.resignFirstResponder()
        }
        else if (txt_descript.isFirstResponder) {
            txt_descript.resignFirstResponder()
        }
        else if type_fax.isFirstResponder{
            type_fax.resignFirstResponder()
        }
        else if ship_address.isFirstResponder{
            ship_address.resignFirstResponder()
        }
        else if doc_address.isFirstResponder{
            doc_address.resignFirstResponder()
        }
        else if txt_ship.isFirstResponder{
            txt_ship.resignFirstResponder()
        }
        else if txt_doc_address.isFirstResponder{
            txt_doc_address.resignFirstResponder()
        }
    }

    @IBAction func doneTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var row = 0
        if pickerView == pickerView_type {
            row = typeLists!.count
        }
        else if pickerView == pickerView_regist{
            row = registLists!.count
        }
        else if pickerView == pickerView_payment{
            row = payment!.count
        }
        else if pickerView == pickerView_compsize{
            row = Comp_Size.count
        }
        else if pickerView == pickerView_type_fax{
            row = numberType!.count
        }
        else {
            row = 0
        }
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView_type {
            return typeLists![row].cus_status_name
        }
        else if pickerView == pickerView_regist{
            return registLists![row].cus_type_name
        }
        else if pickerView == pickerView_payment {
            return payment![row].cus_type_doc_name
        }
        else if pickerView == pickerView_compsize {
            return Comp_Size[row]
        }
        else if pickerView == pickerView_type_fax{
            return "\(numberType![row].name ?? "...") \(numberType![row].dial_code ?? "+66")"
        }
        else{
            return "-"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView_type {
            selected_type_name  = typeLists![row].cus_status_name!
            selected_type_id    = typeLists![row].cus_status_id!
        }
        else if pickerView == pickerView_payment {
            selected_payment_id  = payment![row].cus_type_doc_id!
            selected_payment_name = payment![row].cus_type_doc_name!
        }
        else if pickerView == pickerView_compsize {
            selected_compsize  = Comp_Size[row]
        }
        else if pickerView == pickerView_type_fax{
            slt_fax_type = numberType![row].dial_code!
        }
        else{
            selected_regist_name = registLists![row].cus_type_name!
            selected_regist_id   = registLists![row].cus_type_id!
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        gb.newAccount.fax               = "\(txt_fax.text!)"
        gb.newAccount.comp_size         = txt_comp_size.text!
        gb.newAccount.regist_capital    = txt_regist_cap.text!
        gb.newAccount.number_staff      = txt_num_staff.text!
        gb.newAccount.tax_id            = txt_tax_id.text!
        gb.newAccount.old_code          = txt_old_code.text!
        gb.newAccount.description       = txt_descript.text!
        gb.newAccount.payterm_name      = txt_pay_term.text!
        gb.newAccount.regist_name       = txt_regist.text!
        gb.newAccount.status            = txt_type.text!
        gb.newAccount.payterm           = selected_payment_id
        gb.newAccount.group_id          = selected_type_id
        gb.newAccount.regist            = selected_regist_id
        gb.account_map_location         = selected_location_image
        gb.newAccount.shipAddress       = ship_address.text
        gb.newAccount.docAddress        = doc_address.text
        gb.newAccount.fax_dial          = type_fax.text ?? ""
        
        (viewController as? AddAccount_VC)?.slt_fax_type          = type_fax.text ?? ""
        (viewController as? AddAccount_VC)?.selected_fax          = txt_fax.text!
        (viewController as? AddAccount_VC)?.selected_comp_size    = txt_comp_size.text!
        (viewController as? AddAccount_VC)?.selected_regist_name  = txt_regist.text!
        (viewController as? AddAccount_VC)?.selected_regist_id    = selected_regist_id
        (viewController as? AddAccount_VC)?.selected_type_id      = selected_type_id
        (viewController as? AddAccount_VC)?.selected_type_name    = selected_type_name
        (viewController as? AddAccount_VC)?.selected_number_staff = txt_num_staff.text!
        (viewController as? AddAccount_VC)?.selected_payment_term = txt_pay_term.text!
        (viewController as? AddAccount_VC)?.selected_payment_id   = selected_payment_id
        (viewController as? AddAccount_VC)?.selected_taxid        = txt_tax_id.text!
        (viewController as? AddAccount_VC)?.selected_oldcode      = txt_old_code.text!
        (viewController as? AddAccount_VC)?.selected_description  = txt_descript.text!
        (viewController as? AddAccount_VC)?.selected_regist_capital = txt_regist_cap.text!
        (viewController as? AddAccount_VC)?.selected_shipLng      = selected_shipLng
        (viewController as? AddAccount_VC)?.selected_shipLat      = selected_shipLat
        (viewController as? AddAccount_VC)?.selected_docLng       = selected_docLng
        (viewController as? AddAccount_VC)?.selected_docLat       = selected_docLat
        (viewController as? AddAccount_VC)?.selected_location_image = selected_location_image
        (viewController as? AddAccount_VC)?.selected_shipLocation = selected_shipLocation
        (viewController as? AddAccount_VC)?.selected_docLocation  = selected_docLocation
        (viewController as? AddAccount_VC)?.slt_fax_dial          = type_fax.text!
        
        if ship_address.text != "ship_to".localized(gb.lang_now) {
            (viewController as? AddAccount_VC)?.selected_shipAddress  = ship_address.text
        }
        else {
            (viewController as? AddAccount_VC)?.selected_shipAddress = ""
        }
        
        if doc_address.text != "doc_address".localized(gb.lang_now) {
            (viewController as? AddAccount_VC)?.selected_docAddress   = doc_address.text
        }
        else {
            (viewController as? AddAccount_VC)?.selected_docAddress = ""
        }

        (viewController as? AddAccount_VC)?.accountList?.cus_fax_no         = "\(type_fax.text ?? "")\(txt_fax.text!)"
        (viewController as? AddAccount_VC)?.accountList?.cus_size           = txt_comp_size.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_type_name      = txt_type.text
        (viewController as? AddAccount_VC)?.accountList?.cus_type_id        = selected_regist_id
        (viewController as? AddAccount_VC)?.accountList?.cus_status_id      = selected_type_id
        (viewController as? AddAccount_VC)?.accountList?.cus_status_name    = txt_regist.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_all_staff      = txt_num_staff.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_type_doc_name  = txt_pay_term.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_type_doc_id    = selected_payment_id
        (viewController as? AddAccount_VC)?.accountList?.cus_tax_no         = txt_tax_id.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_code_old       = txt_old_code.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_description    = txt_descript.text!
        (viewController as? AddAccount_VC)?.accountList?.cus_cost_register  = txt_regist_cap.text!
        (viewController as? AddAccount_VC)?.accountList?.ship_longtitude    = selected_shipLng
        (viewController as? AddAccount_VC)?.accountList?.ship_latitude      = selected_shipLat
        (viewController as? AddAccount_VC)?.accountList?.doc_longtitude     = selected_docLng
        (viewController as? AddAccount_VC)?.accountList?.doc_latitude       = selected_docLat
        (viewController as? AddAccount_VC)?.accountList?.ship_location_name = selected_shipLocation
        (viewController as? AddAccount_VC)?.accountList?.doc_location_name  = selected_docLocation
        (viewController as? AddAccount_VC)?.accountList?.ship_address       = ship_address.text
        (viewController as? AddAccount_VC)?.accountList?.doc_address        = doc_address.text
        (viewController as? AddAccount_VC)?.accountList?.fax_dial           = type_fax.text
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let sg = segue.destination as? CoordinateMap_VC
            sg!.send_from = send_from
            sg!.location_name = selected_location_name

            if send_from == "field_ship"{
                sg!.viewPostion.latitude    = Double(selected_shipLat)!
                sg!.viewPostion.longitude   = Double(selected_shipLng)!
            }
            else if send_from == "field_doc" {
                sg!.viewPostion.latitude    = Double(selected_docLat)!
                sg!.viewPostion.longitude   = Double(selected_docLng)!
            }
        }
    }
    
    func setKeyborad(txt_field : UITextField){
        txt_field.inputAccessoryView = toolBar
    }
    
    func setKeyborad2(txt_view : UITextView){
        txt_view.inputAccessoryView = toolBar
    }
}
