//
//  AddAccount_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 29/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit
import SCLAlertView
import PhoneNumberKit

class AddAccount_VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var txt_company_en: UITextField!
    @IBOutlet weak var txt_company_th: UITextField!
    @IBOutlet weak var txt_group: UITextField!
    @IBOutlet weak var txt_mobile_num: UITextField!
    @IBOutlet weak var txt_work_num: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_no: UITextField!
    @IBOutlet weak var txt_lane: UITextField!
    @IBOutlet weak var txt_building: UITextField!
    @IBOutlet weak var txt_road: UITextField!
    @IBOutlet weak var txt_district: UITextField!
    @IBOutlet weak var txt_subdistrict: UITextField!
    @IBOutlet weak var txt_province: UITextField!
    @IBOutlet weak var txt_postcode: UITextField!
    @IBOutlet weak var txt_country: UITextField!
    @IBOutlet weak var txt_code: UITextField!
    @IBOutlet weak var image_account: UIImageView!
    @IBOutlet weak var button_delete: UIButton!
    @IBOutlet weak var button_map: UIButton!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var txt_province_2: UITextField!
    @IBOutlet weak var txt_district_2: UITextField!
    @IBOutlet weak var txt_subdistrict_2: UITextField!
    @IBOutlet weak var txt_postcode_2: UITextField!
    @IBOutlet weak var button_add_logo: UIButton!
    @IBOutlet weak var button_more_info: UIButton!
    @IBOutlet weak var view_height: NSLayoutConstraint!
    @IBOutlet weak var view_scroll: UIView!
    @IBOutlet weak var type_mobile: UITextField!
    @IBOutlet weak var type_work: UITextField!
    
    
    var groupLists:[GroupLists]? = nil
    var statusLists:[StatusLists]? = nil
    var typeLists:[TypeLists]? = nil
    var addressComponent:AddressComponent? = nil
    var country:[Country]? = nil
    var province:[Province]? = nil
    var district:[District]? = nil
    var payment:[Payment]? = nil
    var sub_district:[Sub_District]? = nil
    var postcode:[Postcode]? = nil
    var filtered_province:[Province]? = nil
    var filtered_district:[District]? = nil
    var filtered_sub_district:[Sub_District]? = nil
    var filtered_postcode:[Postcode]? = nil
    var accountList:AccountList? = nil
    var accountAdd:AccountList? = nil
    var account_id:Request_Id? = nil
    var selectedAcc:selectedAccount? = nil
    var numberType:[NumberType]? = nil
    var addressTxt:AddressTxt? = nil
    var txts : [UITextField] = []
    var txts_phd : [String] = []
    var imagePicker = UIImagePickerController()
    let pickerView_group = UIPickerView()
    let pickerView_status = UIPickerView()
    let pickerView_type = UIPickerView()
    let pickerView_country = UIPickerView()
    let pickerView_province = UIPickerView()
    let pickerView_district = UIPickerView()
    let pickerView_sub_district = UIPickerView()
    let pickerView_postcode = UIPickerView()
    let pickerView_type_work = UIPickerView()
    let pickerView_type_mobile = UIPickerView()
    var array_group_name : [String] = []
    var array_group_id : [String] = []
    var array_group_gen : [String] = []
    var array_group_code : [String] = []
    var array_status_id : [String] = []
    var array_status_name : [String] = []
    var array_type_id : [String] = []
    var array_type_name : [String] = []
    var selected_location_image = UIImage()
    var selected_location_string = ""
    var selected_group_name = ""
    var selected_group_id = ""
    var selected_group_gen = ""
    var selected_group_code = ""
    var selected_status_id = ""
    var selected_status_name = ""
    var selected_type_id = ""
    var selected_type_name = ""
    var selected_country_id = ""
    var selected_country_name = ""
    var selected_province_id = ""
    var selected_province_name = ""
    var selected_district_id = ""
    var selected_district_name = ""
    var selected_subdistrict_id = ""
    var selected_subdistrict_name = ""
    var selected_postcode = ""
    var selected_fax = ""
    var selected_comp_size = ""
    var selected_regist = ""
    var selected_regist_capital = ""
    var selected_number_staff = ""
    var selected_payment_term = ""
    var selected_taxid = ""
    var selected_oldcode = ""
    var selected_description = ""
    var type_page = ""
    var selected_cusid = ""
    var selected_regist_name = ""
    var selected_regist_id   = ""
    var selected_payment_name = ""
    var selected_payment_id   = ""
    var selected_compsize = ""
    var selected_cusLocation = ""
    var selected_cusLat = "0.0"
    var selected_cusLng = "0.0"
    var selected_shipAddress = ""
    var selected_shipLocation = ""
    var selected_shipLng = "0.0"
    var selected_shipLat = "0.0"
    var selected_docAddress = ""
    var selected_docLocation = ""
    var selected_docLng = "0.0"
    var selected_docLat = "0.0"
    var slt_work_type = ""
    var slt_mobile_type = ""
    var slt_fax_type = ""
    var slt_work_dial = ""
    var slt_mob_dial = ""
    var slt_fax_dial = ""
    var input_seq = 0
    var toolBar : UIToolbar = UIToolbar()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    var doneButton = UIBarButtonItem()
    var icon = UIImage()
    var heightWithDelete = 1230
    var heightWithoutDelete = 1150
    var check_comp_en = false
    var check_comp_th = false
    var check_work = false
    var check_group = false
    var check_type = false
    var check_regist = false
    var all_verify = false
    var first_group_pick = false
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        gb.setNewAccount()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        let done_save = UIBarButtonItem(title: "done".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        button_add_logo.setTitle("add_logo".localized(gb.lang_now), for: .normal)
        button_more_info.setTitle("more_info".localized(gb.lang_now), for: .normal)
        button_delete.setTitle("delete".localized(gb.lang_now), for: .normal)

        gb.selected_shipLocation = ""
        gb.selected_shipLng = "0.0"
        gb.selected_shipLat = "0.0"
        gb.selected_docLocation = ""
        gb.selected_docLng = "0.0"
        gb.selected_docLat = "0.0"
        gb.selected_cusLocation = ""
        gb.selected_cusLng = "0.0"
        gb.selected_cusLat = "0.0"
        gb.ship_change = false
        gb.doc_change = false
        gb.cus_change = false
        gb.account_map_location = UIImage()
        gb.newAccount.fax_dial = "+66"
        
        type_work.text = "+66"
        type_mobile.text = "+66"
        slt_work_type = "+66"
        slt_mobile_type = "+66"
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .thin, scale: .medium)
        icon = UIImage(systemName: "person.circle.fill", withConfiguration: iconConfig)!
        
        button_delete.layer.cornerRadius = 4
        button_delete.layer.borderWidth = 1
        button_delete.layer.borderColor = UIColor.systemRed.cgColor
        button_delete.clipsToBounds = true
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        imagePicker.delegate = self
        pickerView_group.delegate = self
        pickerView_type_work.delegate = self
        pickerView_type_mobile.delegate = self
        txt_group.inputView = pickerView_group
        txt_group.inputAccessoryView = toolBar
        txt_group.delegate = self
        txt_mobile_num.delegate = self
        txt_work_num.delegate = self
        type_work.inputView = pickerView_type_work
        type_work.inputAccessoryView = toolBar
        type_mobile.inputView = pickerView_type_mobile
        type_mobile.inputAccessoryView = toolBar

        pickerView_country.delegate = self
        txt_country.delegate = self
        
        pickerView_province.delegate = self
        txt_province.delegate = self
        
        pickerView_district.delegate = self
        txt_district.delegate = self
        
        pickerView_sub_district.delegate = self
        txt_subdistrict.delegate = self
        
        pickerView_postcode.delegate = self
        txt_postcode.delegate = self
    
        
        image_account.layer.borderWidth = 2.0
        image_account.layer.masksToBounds = false
        image_account.layer.borderColor = UIColor.lightGray.cgColor
        image_account.layer.cornerRadius = image_account.frame.size.width / 2
        image_account.clipsToBounds = true
        
        let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCountry))
        txt_country.addGestureRecognizer(tap1)
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapProvince))
        txt_province.addGestureRecognizer(tap2)
        let tap3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDistrict))
        txt_district.addGestureRecognizer(tap3)
        let tap4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapSubdistrict))
        txt_subdistrict.addGestureRecognizer(tap4)
        let tap5: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPostcode))
        txt_postcode.addGestureRecognizer(tap5)
        
        getGroupList()
        getAddressComponent(type: "country", para_id: "")
    }
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        let all_verify = verifyInput()
        if all_verify {
            if type_page == "add"{
                postAccount()
            }
            else {
                updateAccount()
            }
        }
        else{
           SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: verifyString(), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
    }
    
    @objc func tapCountry() {
        view.endEditing(true)
        let vc = SelectAddress_TVC()
        txt_country.resignFirstResponder()
        vc.country = country
        vc.type = "country"
        vc.selected_country_id = selected_country_id
        vc.selected_country_name = selected_country_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapProvince() {
        view.endEditing(true)
        let vc = SelectAddress_TVC()
        txt_province.resignFirstResponder()
        vc.province = province
        vc.type = "province"
        vc.selected_province_id = selected_province_id
        vc.selected_province_name = selected_province_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapDistrict() {
        view.endEditing(true)
        let vc = SelectAddress_TVC()
        txt_district.resignFirstResponder()
        vc.district = district
        vc.type = "distict"
        vc.selected_distict_id = selected_district_id
        vc.selected_distict_name = selected_district_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapSubdistrict() {
        view.endEditing(true)
        let vc = SelectAddress_TVC()
        txt_subdistrict.resignFirstResponder()
        vc.sub_district = sub_district
        vc.type = "sub_distict"
        vc.selected_sub_distict_id = selected_subdistrict_id
        vc.selected_sub_distict_name = selected_subdistrict_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapPostcode() {
        view.endEditing(true)
        let vc = SelectAddress_TVC()
        txt_postcode.resignFirstResponder()
        vc.postcode = postcode
        vc.type = "postcode"
        vc.selected_postcode_id = selected_postcode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setSeq(seq:Int){
        if seq == 4 {txt_postcode.isEnabled = true}
        if seq >= 3 {txt_subdistrict.isEnabled = true}
        if seq >= 2 {txt_district.isEnabled = true}
        if seq >= 1 {txt_province.isEnabled = true}
    }
    
    func setThailand(country_id : String){
        selected_province_name = ""
        selected_province_id = ""
        selected_district_name = ""
        selected_district_id = ""
        selected_subdistrict_name = ""
        selected_subdistrict_id = ""
        selected_postcode = ""
        
        txt_district.isEnabled = false
        txt_subdistrict.isEnabled = false
        txt_postcode.isEnabled = false
        
        if country_id == "1"{
            toggleThailand(isThai:true)
            txt_province.text = ""
            txt_district.text = ""
            txt_subdistrict.text = ""
            txt_postcode.text = ""
        }
        else {
            toggleThailand(isThai:false)
            txt_province_2.text = ""
            txt_district_2.text = ""
            txt_subdistrict_2.text = ""
            txt_postcode_2.text = ""
        }
    }
    
    func toggleThailand(isThai:Bool){
        if isThai {
           txt_province.isHidden = false
           txt_district.isHidden = false
           txt_subdistrict.isHidden = false
           txt_postcode.isHidden = false
           txt_province_2.isHidden = true
           txt_district_2.isHidden = true
           txt_subdistrict_2.isHidden = true
           txt_postcode_2.isHidden = true
        }
        else{
            txt_province.isHidden = true
            txt_district.isHidden = true
            txt_subdistrict.isHidden = true
            txt_postcode.isHidden = true
            txt_province_2.isHidden = false
            txt_district_2.isHidden = false
            txt_subdistrict_2.isHidden = false
            txt_postcode_2.isHidden = false
        }
    }
    
    func setLabelData(){
        let ac = accountList
        
        var a_lat = ac?.cus_latitude ?? "0.0"
        var a_lng = ac?.cus_longtitude ?? "0.0"
        if a_lat == "" {a_lat = "0.0"}
        if a_lng == "" {a_lng = "0.0"}
        if a_lat == "0.0" && a_lng == "0.0" {
            button_map.setTitle("add_map".localized(gb.lang_now), for: .normal)
        }
        else {
            button_map.setTitle("edit_map".localized(gb.lang_now), for: .normal)
        }
        selected_cusLat         = a_lat
        selected_cusLng         = a_lng
        selected_cusLocation    = String(ac?.cus_location_name ?? "")
        
        selected_cusid          = (ac?.cus_id)!
        selected_status_id      = (ac?.cus_status_id)!
        selected_status_name    = ac?.cus_status_name   ?? ""
        selected_group_id       = ac?.cus_group_id      ?? ""
        selected_group_name     = ac?.cus_group_name    ?? ""
        selected_district_id    = ac?.district_id       ?? ""
        selected_district_name  = ac?.district_txt      ?? ""
        selected_subdistrict_id = ac?.sub_district_id  ?? ""
        selected_subdistrict_name  = ac?.sub_district_txt ?? ""
        selected_province_id    = ac?.province_id       ?? ""
        selected_province_name  = ac?.province_txt      ?? ""
        selected_postcode       = ac?.post_id           ?? ""
        selected_country_id     = ac?.country_id        ?? ""
        
        selected_fax          = ac?.cus_fax_no          ?? ""
        selected_comp_size    = ac?.cus_size            ?? ""
        selected_regist_name  = ac?.cus_type_name       ?? ""
        selected_regist_id    = ac?.cus_type_id         ?? ""
        selected_type_id      = ac?.cus_status_id       ?? ""
        selected_type_name    = ac?.cus_status_name     ?? ""
        selected_number_staff = ac?.cus_all_staff       ?? ""
        selected_payment_term = ac?.cus_type_doc_name   ?? ""
        selected_payment_id   = ac?.cus_type_doc_id     ?? ""
        selected_taxid        = ac?.cus_tax_no          ?? ""
        selected_oldcode      = ac?.cus_code_old        ?? ""
        selected_description  = ac?.cus_description     ?? ""
        selected_regist_capital = ac?.cus_cost_register ?? ""
        selected_shipLocation = ac?.ship_location_name  ?? ""
        selected_shipLng      = ac?.ship_longtitude     ?? ""
        selected_shipLat      = ac?.ship_latitude       ?? ""
        selected_docLocation  = ac?.doc_location_name   ?? ""
        selected_docLng       = ac?.doc_longtitude      ?? ""
        selected_docLat       = ac?.doc_latitude        ?? ""
        selected_shipAddress  = ac?.ship_address        ?? ""
        selected_docAddress   = ac?.doc_address         ?? ""
        slt_work_dial         = ac?.work_dial           ?? ""
        slt_mob_dial          = ac?.mob_dial            ?? ""
        slt_fax_dial          = ac?.fax_dial            ?? ""
        
        let str_work = ac?.cus_tel_no ?? ""
        let str_mobile = ac?.cus_mob_no ?? ""
        
        do {
            let str_work_   = try phoneNumberKit.parse(String(str_work))
            type_work.text      = "+\(String(str_work_.countryCode))"
            txt_work_num.text   = String(str_work_.nationalNumber)
        }
        catch {
            print("Work number error")
            if slt_work_dial != "" {
                type_work.text      = slt_work_dial
                txt_work_num.text   = str_work.replacingOccurrences(of: "\(slt_work_dial)", with: "")
            }
            else {
                txt_work_num.text   = str_work.replacingOccurrences(of: "+66", with: "")
            }
        }
        
        do {
            let str_mobile_ = try phoneNumberKit.parse(String(str_mobile))
            type_mobile.text    = "+\(String(str_mobile_.countryCode))"
            txt_mobile_num.text = String(str_mobile_.nationalNumber)
        }
        catch {
            print("Mobile number error")
            if slt_mob_dial != "" {
                type_mobile.text      = slt_mob_dial
                txt_mobile_num.text   = str_mobile.replacingOccurrences(of: "\(slt_mob_dial)", with: "")
            }
            else {
                txt_mobile_num.text   = str_mobile.replacingOccurrences(of: "+66", with: "")
            }
        }
        
        getAddressTxt(country_id: selected_country_id, province_id: selected_province_id, district: selected_district_id, subdistrict: selected_subdistrict_id)
        txt_company_en.text     = ac?.cus_name_en       ?? ""
        txt_company_th.text     = ac?.cus_name_th       ?? ""
        txt_email.text          = ac?.cus_email         ?? ""
        txt_no.text             = ac?.cus_address_th    ?? ""
        txt_lane.text           = ac?.cus_txtsoi        ?? ""
        txt_building.text       = ac?.cus_txtbuilding   ?? ""
        txt_road.text           = ac?.cus_txtroad       ?? ""
        txt_postcode.text       = ac?.post_id           ?? ""
        txt_code.text           = ac?.cus_code          ?? ""
        txt_group.text          = ac?.cus_group_name    ?? ""
        label_location.text     = ac?.cus_location_name ?? ""
        
        print("Loc setlabel : \(ac?.cus_location_name ?? "")")
        
        var image_account_str = ""
        if ac?.cus_logo == nil {
            image_account.backgroundColor = UIColor.white
        }
        else{
            image_account_str = "\(Const_Var.BASE_URL)crm/\(String(((ac?.cus_logo!.replacingOccurrences(of: "\\", with: ""))!)))"
            image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
            image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
            image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            do{
               let url = URL(string: image_account_str)
               let data = try Data(contentsOf: url!)
               let im = UIImage(data: data) ?? UIImage()
               image_account.image = im
           }
           catch{
               print(error)
           }
        }
        
        var image_map_str = ""
        if ac?.cus_map == nil {
            image_account.backgroundColor = UIColor.white
        }
        else{
            image_map_str = "\(Const_Var.BASE_URL)crm/\(String(((ac?.cus_map!.replacingOccurrences(of: "\\", with: ""))!)))"
            image_map_str = image_map_str.replacingOccurrences(of: " ", with: "%20")
            image_map_str = image_map_str.replacingOccurrences(of: "+", with: "%2B")
            image_map_str = image_map_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            do{
                let url = URL(string: image_map_str)
                let data = try Data(contentsOf: url!)
                let im = UIImage(data: data) ?? UIImage()
                selected_location_image = im
            }
            catch{
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if gb.ship_change {
            accountList?.ship_location_name     = gb.selected_shipLocation
            accountList?.ship_latitude          = gb.selected_shipLat
            accountList?.ship_longtitude        = gb.selected_shipLng
            selected_shipLocation               = gb.selected_shipLocation
            selected_shipLat                    = gb.selected_shipLat
            selected_shipLng                    = gb.selected_shipLng
        }
        
        if gb.doc_change {
            accountList?.doc_location_name      = gb.selected_docLocation
            accountList?.doc_latitude           = gb.selected_docLat
            accountList?.doc_longtitude         = gb.selected_docLng
            selected_docLocation                = gb.selected_docLocation
            selected_docLat                     = gb.selected_docLat
            selected_docLng                     = gb.selected_docLng
        }
        
        if gb.cus_change {
            accountList?.cus_location_name      = gb.selected_cusLocation
            accountList?.cus_latitude           = gb.selected_cusLat
            accountList?.cus_longtitude         = gb.selected_cusLng
            selected_cusLocation                = gb.selected_cusLocation
            selected_cusLat                     = gb.selected_cusLat
            selected_cusLng                     = gb.selected_cusLng
            label_location.text                 = gb.selected_cusLocation
            print("Cus Loac will : \(gb.selected_cusLocation)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        txts = [txt_company_en, txt_company_th,txt_group,txt_code,txt_mobile_num,txt_work_num,txt_email,txt_no,txt_lane,txt_building,txt_road,txt_district,txt_subdistrict,txt_province,txt_postcode,txt_country,txt_province_2,txt_district_2,txt_subdistrict_2,txt_postcode_2,type_work,type_mobile]
        txts_phd = ["PHcom_en".localized(gb.lang_now), "PHcom_th".localized(gb.lang_now),"PHgroup".localized(gb.lang_now),"PHcode".localized(gb.lang_now),"PHmobile".localized(gb.lang_now),"PHwork".localized(gb.lang_now),"PHemail".localized(gb.lang_now),"PHno".localized(gb.lang_now),"PHlane".localized(gb.lang_now),"PHbuilding".localized(gb.lang_now),"PHroad".localized(gb.lang_now),"PHdistrict".localized(gb.lang_now),"PHsubdistrict".localized(gb.lang_now),"PHprovince".localized(gb.lang_now),"PHpost_code".localized(gb.lang_now),"PHcountry".localized(gb.lang_now),"PHprovince".localized(gb.lang_now),"PHdistrict".localized(gb.lang_now),"PHsubdistrict".localized(gb.lang_now),"PHpost_code".localized(gb.lang_now),"+66","+66"]
         
        for txt_item in txts {
            setKeyborad(txt_field: txt_item)
            setTextField(txt_field: txt_item)
            setPlaceHolder(txt_field: txt_item)
        }
    }
    
    func getAddressTxt(country_id:String,province_id:String,district:String,subdistrict:String){
            let postString = "country=\(String(country_id))&province=\(String(province_id))&district=\(String(district))&subdistrict=\(String(subdistrict))"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ADDRESS_TXT)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                do{
                    self.addressTxt = try JSONDecoder().decode(AddressTxt.self, from: data!)
                }catch let err{
                    print("Error : ",err)
                }
                
                DispatchQueue.main.async {
                    if self.addressTxt?.country != nil {
                        self.txt_country.text    = self.addressTxt?.country?.first?.name
                    }
                    if self.addressTxt?.province != nil {
                        self.txt_province.text = self.addressTxt?.province?.first?.name
                        self.selected_province_name = self.addressTxt?.province?.first?.name ?? ""
                    }
                    if self.addressTxt?.district != nil {
                        self.txt_district.text = self.addressTxt?.district?.first?.name
                        self.selected_district_name = self.addressTxt?.district?.first?.name ?? ""
                    }
                    if self.addressTxt?.sub_district != nil {
                        self.txt_subdistrict.text = self.addressTxt?.sub_district?.first?.name
                        self.selected_subdistrict_name = self.addressTxt?.sub_district?.first?.name ?? ""
                    }
                }
            }
            task.resume()
        }
    
    func getGroupList(){
        let postString = "compId=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_GROUP)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.groupLists = try JSONDecoder().decode([GroupLists].self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.groupLists != nil {
                    for item in self.groupLists! {
                        self.array_group_name.append(item.cus_group_name!)
                        self.array_group_id.append(item.cus_group_id!)
                        self.array_group_gen.append(item.cus_group_gen!)
                        self.array_group_code.append(item.cus_group_shcode!)
                    }
//                    self.selected_group_name = self.array_group_name[0]
//                    self.selected_group_id = self.array_group_id[0]
//                    self.selected_group_gen = self.array_group_gen[0]
//                    self.selected_group_code = self.array_group_code[0]
                }
                self.getStatusList()
            }
        }
        task.resume()
    }
    
    func getStatusList(){
        let postString = "compId=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_STATUS)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.statusLists = try JSONDecoder().decode([StatusLists].self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.statusLists != nil {
                    for item in self.statusLists! {
                        self.array_status_id.append(item.cus_status_id!)
                        self.array_status_name.append(item.cus_status_name!)
                    }
//                    self.selected_type_id = self.array_status_id[0]
//                    self.selected_type_name = self.array_status_name[0]
                }
                self.getTypeList()
            }
        }
        task.resume()
    }
    
    func getTypeList(){
        let postString = "compId=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_TYPE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.typeLists = try JSONDecoder().decode([TypeLists].self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.typeLists != nil {
                    for item in self.typeLists! {
                        self.array_type_id.append(item.cus_type_id!)
                        self.array_type_name.append(item.cus_type_name!)
                    }
//                    self.selected_status_id = self.array_type_id[0]
//                    self.selected_status_name = self.array_type_name[0]
                }
                self.paymentList()
            }
        }
        task.resume()
    }
    
    func paymentList(){
        let postString = "comp_id=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_PAYMENT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.payment = try JSONDecoder().decode([Payment].self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.continueProgram()
            }
        }
        task.resume()
    }
    
    func filterProvince(country_id : String){
        getAddressComponent(type: "province", para_id: "&country_id=\(country_id)")
    }
    
    func filterDistict(province_id : String){
        getAddressComponent(type: "district", para_id: "&province_id=\(province_id)")
    }
    
    func filterSubDistict(distict_id : String){
        getAddressComponent(type: "sub_district", para_id: "&district_id=\(distict_id)")
    }
    
    func filterPost(distict_id : String){
        getAddressComponent(type: "postcode", para_id: "&district_id=\(distict_id)")
    }
    
    func continueProgram(){
        if accountList != nil {
            type_page = "edit"
            self.title = "edit_account".localized(gb.lang_now)
            button_delete.isHidden = false
            setLabelData()
            
            if accountList?.country_id == "1"{
                toggleThailand(isThai:true)
                txt_province.isEnabled = false
                txt_district.isEnabled = false
                txt_subdistrict.isEnabled = false
                txt_postcode.isEnabled = false
                setSeq(seq:1)
            }
            else {
                toggleThailand(isThai:false)
            }
            closeLoad()
        }
        else {
            self.title = "new_account".localized(gb.lang_now)
            button_map.setTitle("add_map".localized(gb.lang_now), for: .normal)
            type_page = "add"
            button_delete.isHidden = true
            
            txt_province.isEnabled = false
            txt_district.isEnabled = false
            txt_subdistrict.isEnabled = false
            txt_postcode.isEnabled = false
            toggleThailand(isThai:true)
            closeLoad()
        }
    }
    
    func getAddressComponent(type:String, para_id:String){
        let postString = "type=\(type)\(para_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ADDRESS_COMPN)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.addressComponent = try JSONDecoder().decode(AddressComponent.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if type == "country"{
                    self.country = self.addressComponent?.country
                }
                else if type == "province" {
                    self.province = self.addressComponent?.province
                }
                else if type == "district" {
                     self.district = self.addressComponent?.district
                }
                else if type == "sub_district" {
                    self.sub_district = self.addressComponent?.sub_district
                }
                else if type == "postcode" {
                    self.postcode = self.addressComponent?.postcode
                }
                
                if self.selected_subdistrict_id != "" && self.sub_district != nil{
                    for item in self.sub_district! {
                        if item.sub_district_id == self.selected_subdistrict_id {
                            self.selected_subdistrict_name = item.sub_district_name!
                            self.txt_subdistrict.text = self.selected_subdistrict_name
                        }
                    }
                }
                
                if self.selected_district_id != "" && self.district != nil{
                    for item in self.district! {
                        if item.district_id == self.selected_district_id {
                            self.selected_district_name = item.district_name!
                            self.txt_district.text = self.selected_district_name
                        }
                    }
                }
                
                if self.selected_province_id != ""  && self.province != nil{
                    for item in self.province! {
                        if item.province_id == self.selected_province_id {
                            self.selected_province_name = item.province_name!
                            self.txt_province.text = self.selected_province_name
                        }
                    }
                }
                
                if self.selected_country_id != ""  && self.country != nil{
                    for item in self.country! {
                        if item.country_id == self.selected_country_id {
                            self.selected_country_name = item.country_name!
                            self.txt_country.text = self.selected_country_name
                        }
                    }
                }
                self.getNumberType()
            }
        }
        task.resume()
    }
    
    func postAccount(){
        showLoad()
        let sl_ac = addObjectData()
        let postString = "empId=\(String((gb.user?.emp_id)!))&compId=\(String((gb.user?.comp_id)!))&acGroupId=\(String(sl_ac.group_id))&acGroupGen=\(String(sl_ac.group_gen))&acTypeId=\(String(sl_ac.regist))&acStatus=\(String(sl_ac.group_type_id))&acCode=\(String(sl_ac.code))&acCompanyTh=\(String(sl_ac.comp_th))&acCompanyEn=\(String(sl_ac.comp_en))&mobile=\(String(sl_ac.mobile_tel))&acTel=\(String(sl_ac.work_tel))&acFax=\(String(sl_ac.fax))&acEmail=\(String(sl_ac.email))&acWebsite=\(String(sl_ac.website))&acFacebook=\(String(sl_ac.facebook))&codeContact=\(String(sl_ac.contact))&no=\(String(sl_ac.no))&lane=\(String(sl_ac.lane))&building=\(String(sl_ac.building))&road=\(String(sl_ac.road))&distict=\(String(sl_ac.distict))&sub_distict=\(String(sl_ac.sub_distict))&provice=\(String(sl_ac.provice))&post_code=\(String(sl_ac.post_code))&distict_txt=\(String(sl_ac.distict_txt))&sub_distict_txt=\(String(sl_ac.sub_distict_txt))&provice_txt=\(String(sl_ac.provice_txt))&country=\(String(sl_ac.country))&country_txt=\(String(sl_ac.country_txt))&comp_size=\(String(sl_ac.comp_size))&regist=\(String(sl_ac.regist))&regist_capital=\(String(sl_ac.regist_capital))&number_staff=\(String(sl_ac.number_staff))&payterm=\(String(sl_ac.payterm))&tax_id=\(String(sl_ac.tax_id))&old_code=\(String(sl_ac.old_code))&description=\(String(sl_ac.description))&cusLocation=\(String(sl_ac.cusLocation))&cusLng=\(String(sl_ac.cusLng))&cusLat=\(String(sl_ac.cusLat))&shipLocation=\(String(sl_ac.shipLocation))&shipLng=\(String(sl_ac.shipLng))&shipLat=\(String(sl_ac.shipLat))&docLocation=\(String(sl_ac.docLocation))&docLng=\(String(sl_ac.docLng))&docLat=\(String(sl_ac.docLat))&shipAddress=\(String(sl_ac.ship_address))&docAddress=\(String(sl_ac.doc_address))&workDial=\(String(sl_ac.work_dial))&mobDial=\(String(sl_ac.mob_dial))&faxDial=\(String(sl_ac.fax_dial))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACCOUNT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.account_id = try JSONDecoder().decode(Request_Id.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{
                    let acc_id = self.account_id?.request_id
                    self.uploadLogo(c_id: acc_id!)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func updateAccount(){
        let sl_ac = addObjectData()
        print("Update acc : \(sl_ac.cusLocation) ")
        let postString = "cusid=\(String(sl_ac.cus_id))&groupId=\(String(sl_ac.group_id))&acGroupGen=\(String(sl_ac.group_gen))&typeId=\(String(sl_ac.regist))&stateId=\(String(sl_ac.group_type_id))&acCode=\(String(sl_ac.code))&nameTh=\(String(sl_ac.comp_th))&nameEng=\(String(sl_ac.comp_en))&mobile=\(String(sl_ac.mobile_tel))&tel=\(String(sl_ac.work_tel))&fax=\(String(sl_ac.fax))&email=\(String(sl_ac.email))&website=\(String(sl_ac.website))&facebook=\(String(sl_ac.facebook))&codeContact=\(String(sl_ac.contact))&no=\(String(sl_ac.no))&lane=\(String(sl_ac.lane))&building=\(String(sl_ac.building))&road=\(String(sl_ac.road))&distict=\(String(sl_ac.distict))&sub_distict=\(String(sl_ac.sub_distict))&provice=\(String(sl_ac.provice))&post_code=\(String(sl_ac.post_code))&distict_txt=\(String(sl_ac.distict_txt))&sub_distict_txt=\(String(sl_ac.sub_distict_txt))&provice_txt=\(String(sl_ac.provice_txt))&country=\(String(sl_ac.country))&country_txt=\(String(sl_ac.country_txt))&comp_size=\(String(sl_ac.comp_size))&regist=\(String(sl_ac.regist))&regist_capital=\(String(sl_ac.regist_capital))&number_staff=\(String(sl_ac.number_staff))&payterm=\(String(sl_ac.payterm))&tax_id=\(String(sl_ac.tax_id))&old_code=\(String(sl_ac.old_code))&description=\(String(sl_ac.description))&cusLocation=\(String(sl_ac.cusLocation))&cusLng=\(String(sl_ac.cusLng))&cusLat=\(String(sl_ac.cusLat))&shipLocation=\(String(sl_ac.shipLocation))&shipLng=\(String(sl_ac.shipLng))&shipLat=\(String(sl_ac.shipLat))&docLocation=\(String(sl_ac.docLocation))&docLng=\(String(sl_ac.docLng))&docLat=\(String(sl_ac.docLat))&shipAddress=\(String(sl_ac.ship_address))&docAddress=\(String(sl_ac.doc_address))&workDial=\(String(sl_ac.work_dial))&mobDial=\(String(sl_ac.mob_dial))&faxDial=\(String(sl_ac.fax_dial))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.UPDATE_ACCOUNT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
//                self.requestOTLists = try JSONDecoder().decode(RequestOTLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{
                    self.uploadLogo(c_id: Int(sl_ac.cus_id)!)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func deleteAccount(){
        showLoad()
        let postString = "cusId=\(String(selected_cusid))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_ACCOUNT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
//                self.requestOTLists = try JSONDecoder().decode(RequestOTLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                    let alert = SCLAlertView(appearance: appearance)
                    alert.addButton("close".localized(gb.lang_now)) {
                       alert.hideView()
                       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "account") as? Account_VC
                       self.navigationController?.pushViewController(vc!, animated: true)
                    }
                    self.closeLoad()
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "delete_account_success".localized(gb.lang_now), animationStyle: .noAnimation)
                    gb.refresh = true
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func uploadLogo(c_id : Int){
        let image_name = "\(Date().millisecondsSince1970).jpeg"
        var image_base64 = ""
        let image_data = image_account.image?.jpegData(compressionQuality: 1)
        if image_data != nil {
            image_base64 = image_data!.base64EncodedString()
            image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
            
            let postString = "cusid=\(String(c_id))&imagetype=\(String("logo"))&ImageName=\(String(image_name))&base64=\(String(image_base64))"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACCOUNT_IMAGE)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                _ = String(data: data!, encoding: .utf8)
                do{
                    
                }catch let err{
                    print("Error : ",err)
                }
                
                DispatchQueue.main.async {
                    do{

                    }
                    catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
        uploadMapLocation(c_id : c_id)
    }
    
    func uploadMapLocation(c_id : Int){
        let image_data = selected_location_image.jpegData(compressionQuality: 1)
        if image_data != nil {
            let image_name = "\(Date().millisecondsSince1970).jpeg"
            var image_base64 = ""
            image_base64 = image_data!.base64EncodedString()
            image_base64 = image_base64.replacingOccurrences(of: "+", with: "%2B")
        
            let postString = "cusid=\(String(c_id))&imagetype=\(String("map"))&ImageName=\(String(image_name))&base64=\(String(image_base64))"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACCOUNT_IMAGE)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)
    
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                _ = String(data: data!, encoding: .utf8)
                do{
    
                }catch let err{
                    print("Error : ",err)
                }
    
                DispatchQueue.main.async {
                    do{
                        
                    }
                    catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
        closeLoad()
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("close".localized(gb.lang_now)) {
           alert.hideView()
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "account") as? Account_VC
           self.navigationController?.pushViewController(vc!, animated: true)
        }
        if type_page == "add"{
            alert.showSuccess("success".localized(gb.lang_now), subTitle: "add_account_success".localized(gb.lang_now), animationStyle: .noAnimation)
        }
        else {
            alert.showSuccess("success".localized(gb.lang_now), subTitle: "update_account_success".localized(gb.lang_now), animationStyle: .noAnimation)
        }
        gb.refresh = true
        
    }
    
    func getNumberType(){
        let postString = ""
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NUMBER_TYPE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.numberType = try JSONDecoder().decode([NumberType].self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{

                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func addObjectData() -> selectedAccount{
        if selected_country_id != "1" {
            selected_province_id = "0"
            selected_province_name = txt_province_2.text!
            selected_district_id = "0"
            selected_district_name = txt_district_2.text!
            selected_subdistrict_id = "0"
            selected_subdistrict_name = txt_subdistrict_2.text!
            selected_postcode = txt_postcode_2.text!
        }
        let str_work_type = type_work.text
        let str_mobile_type = type_mobile.text
        var encode_work = str_work_type!.replacingOccurrences(of: "+", with: "%2B")
        var encode_mobile = str_mobile_type!.replacingOccurrences(of: "+", with: "%2B")
        var real_code = ""
        if type_page == "add"{
            real_code = genCode()
        }
        else {
            real_code = txt_code.text!
        }
        
        if selected_fax == "" {
            slt_fax_type = ""
        }
        if txt_work_num.text == "" {
            encode_work = ""
        }
        if txt_mobile_num.text == "" {
            encode_mobile = ""
        }
        
        let data = selectedAccount.init(
            cus_id          : selected_cusid,
            group_id        : selected_group_id,
            group_gen       : selected_group_gen,
            group_type_id   : selected_type_id,
            status          : selected_regist_id,
            code            : real_code,
            comp_th         : txt_company_th.text ?? " ",
            comp_en         : txt_company_en.text ?? " ",
            work_tel        : "\(encode_work)\(txt_work_num.text ?? "")",
            mobile_tel      : "\(encode_mobile)\(txt_mobile_num.text ?? "")",
            fax             : "\(slt_fax_type.replacingOccurrences(of: "+", with: "%2B"))\(selected_fax.replacingOccurrences(of: "+", with: "%2B"))",
            email           : txt_email.text ?? " ",
            website         : " ",
            facebook        : " ",
            contact         : " ",
            no              : txt_no.text ?? " ",
            lane            : txt_lane.text ?? " ",
            building        : txt_building.text ?? " ",
            road            : txt_road.text ?? " ",
            distict         : selected_district_id,
            sub_distict     : selected_subdistrict_id,
            provice         : selected_province_id,
            post_code       : selected_postcode,
            country         : selected_country_id,
            distict_txt     : selected_district_name,
            sub_distict_txt : selected_subdistrict_name,
            provice_txt     : selected_province_name,
            country_txt     : selected_country_name,
            comp_size       : selected_comp_size,
            regist          : selected_regist_id,
            regist_name     : selected_regist_name,
            regist_capital  : selected_regist_capital,
            number_staff    : selected_number_staff,
            payterm         : selected_payment_id,
            tax_id          : selected_taxid,
            old_code        : selected_oldcode,
            description     : selected_description,
            cusLat          : selected_cusLat,
            cusLng          : selected_cusLng,
            cusLocation     : selected_cusLocation,
            shipLat         : selected_shipLat,
            shipLng         : selected_shipLng,
            shipLocation    : selected_shipLocation,
            docLat          : selected_docLat,
            docLng          : selected_docLng,
            docLocation     : selected_docLocation,
            ship_address    : selected_shipAddress,
            doc_address     : selected_docAddress,
            work_dial       : encode_work,
            mob_dial        : encode_mobile,
            fax_dial        : slt_fax_dial.replacingOccurrences(of: "+", with: "%2B")
        )
        
        print("Cus Loc : \(selected_cusLocation)")
        return data
    }
    
    func genCode() -> String {
        var rt_code = ""
        rt_code = "\(String(selected_group_code))-\(String(format: "%06d", Int(selected_group_gen) ?? 0))"
        return rt_code
    }
    
    @IBAction func tapOpenMap(_ sender: Any) {}
    
    @IBAction func tapDone(_ sender: Any) {
        let all_verify = verifyInput()
        if all_verify {
            if type_page == "add"{
                postAccount()
            }
            else {
                updateAccount()
            }
        }
        else{
           SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "Plese complete input\n1.--\n2.--\n3.--", closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        deleteAccount()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_group {
            first_group_pick = true
        }
        if textField == txt_mobile_num {
            txt_mobile_num.backgroundColor = UIColor.clear
        }
        if textField == txt_work_num {
            txt_work_num.backgroundColor = UIColor.clear
        }
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txt_group.isFirstResponder{
            if first_group_pick {
                selected_group_name = array_group_name[0]
                selected_group_gen  = array_group_gen[0]
                selected_group_code = array_group_code[0]
                selected_group_id   = array_group_id[0]
            }
            txt_group.text = selected_group_name
            txt_code.text = genCode()
            txt_group.resignFirstResponder()
        }
        else if txt_country.isFirstResponder{
            txt_country.text = selected_country_name
            txt_country.resignFirstResponder()
        }
        else if txt_province.isFirstResponder{
            txt_province.text = selected_province_name
            txt_province.resignFirstResponder()
        }
        else if txt_district.isFirstResponder{
            txt_district.text = selected_district_name
            txt_district.resignFirstResponder()
        }
        else if txt_subdistrict.isFirstResponder{
            txt_subdistrict.text = selected_subdistrict_name
            txt_subdistrict.resignFirstResponder()
        }
        else if txt_postcode.isFirstResponder{
            txt_postcode.text = selected_postcode
            txt_postcode.resignFirstResponder()
        }
        else if txt_province_2.isFirstResponder{
            txt_province_2.resignFirstResponder()
        }
        else if txt_district_2.isFirstResponder{
            txt_district_2.resignFirstResponder()
        }
        else if txt_subdistrict_2.isFirstResponder{
            txt_subdistrict_2.resignFirstResponder()
        }
        else if txt_postcode_2.isFirstResponder{
            txt_postcode_2.resignFirstResponder()
        }
        else if txt_company_en.isFirstResponder{
            txt_company_en.resignFirstResponder()
        }
        else if txt_company_th.isFirstResponder{
            txt_company_th.resignFirstResponder()
        }
        else if txt_mobile_num.isFirstResponder{
            txt_mobile_num.resignFirstResponder()
        }
        else if txt_work_num.isFirstResponder{
            txt_work_num.resignFirstResponder()
        }
        else if txt_email.isFirstResponder{
            txt_email.resignFirstResponder()
        }
        else if txt_no.isFirstResponder{
            txt_no.resignFirstResponder()
        }
        else if txt_lane.isFirstResponder{
            txt_lane.resignFirstResponder()
        }
        else if txt_building.isFirstResponder{
            txt_building.resignFirstResponder()
        }
        else if txt_road.isFirstResponder{
            txt_road.resignFirstResponder()
        }
        else if type_work.isFirstResponder{
            type_work.text = slt_work_type
            type_work.resignFirstResponder()
        }
        else if type_mobile.isFirstResponder{
            type_mobile.text = slt_mobile_type
            type_mobile.resignFirstResponder()
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if txt_group.isFirstResponder{
            txt_group.resignFirstResponder()
        }
        else if txt_country.isFirstResponder{
            txt_country.resignFirstResponder()
        }
        else if txt_province.isFirstResponder{
            txt_province.resignFirstResponder()
        }
        else if txt_district.isFirstResponder{
            txt_district.resignFirstResponder()
        }
        else if txt_subdistrict.isFirstResponder{
            txt_subdistrict.resignFirstResponder()
        }
        else if txt_postcode.isFirstResponder{
            txt_postcode.resignFirstResponder()
        }
        else if txt_company_en.isFirstResponder{
            txt_company_en.resignFirstResponder()
        }
        else if txt_company_th.isFirstResponder{
            txt_company_th.resignFirstResponder()
        }
        else if txt_mobile_num.isFirstResponder{
            txt_mobile_num.resignFirstResponder()
        }
        else if txt_work_num.isFirstResponder{
            txt_work_num.resignFirstResponder()
        }
        else if txt_email.isFirstResponder{
            txt_email.resignFirstResponder()
        }
        else if txt_no.isFirstResponder{
            txt_no.resignFirstResponder()
        }
        else if txt_lane.isFirstResponder{
            txt_lane.resignFirstResponder()
        }
        else if txt_building.isFirstResponder{
            txt_building.resignFirstResponder()
        }
        else if txt_road.isFirstResponder{
            txt_road.resignFirstResponder()
        }
        else if txt_province_2.isFirstResponder{
            txt_province_2.resignFirstResponder()
        }
        else if txt_district_2.isFirstResponder{
            txt_district_2.resignFirstResponder()
        }
        else if txt_subdistrict_2.isFirstResponder{
            txt_subdistrict_2.resignFirstResponder()
        }
        else if txt_postcode_2.isFirstResponder{
            txt_postcode_2.resignFirstResponder()
        }
        else if type_work.isFirstResponder{
            type_work.resignFirstResponder()
        }
        else if type_mobile.isFirstResponder{
            type_mobile.resignFirstResponder()
        }
    }
    
    @IBAction func tapAddLogo(_ sender: Any) {
        
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
            image_account.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setKeyborad(txt_field : UITextField){
        txt_field.inputAccessoryView = toolBar
    }
    
    func setTextField(txt_field : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txt_field.frame.height - 1.5, width: txt_field.frame.width, height: 1.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        txt_field.borderStyle = UITextField.BorderStyle.none
        txt_field.textColor = UIColor.darkGray
        txt_field.layer.addSublayer(bottomLine)
        txt_field.tintColor = UIColor.systemOrange
    }
    
    func setPlaceHolder(txt_field : UITextField) {
        let index = txts.firstIndex(of: txt_field)
        txt_field.placeholder = txts_phd[index!]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView_group {
            return array_group_name.count
        }
        else if (pickerView == pickerView_country) {
            return country!.count
        }
        else if (pickerView == pickerView_province) {
            return province!.count
        }
        else if (pickerView == pickerView_district) {
            return district!.count
        }
        else if (pickerView == pickerView_sub_district) {
            return sub_district!.count
        }
        else if (pickerView == pickerView_postcode) {
            return postcode!.count
        }
        else if pickerView == pickerView_type_work {
            if numberType != nil {
                return numberType!.count
            }
            else{
                return 0
            }
        }
        else if pickerView == pickerView_type_mobile {
            if numberType != nil {
                return numberType!.count
            }
            else{
                return 0
            }
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView_group {
            return array_group_name[row]
        }
        else if (pickerView == pickerView_country) {
            return country![row].country_name
        }
        else if (pickerView == pickerView_province) {
            return province![row].province_name
        }
        else if (pickerView == pickerView_district) {
            return district![row].district_name
        }
        else if (pickerView == pickerView_sub_district) {
            return sub_district![row].sub_district_name
        }
        else if (pickerView == pickerView_postcode) {
            return postcode![row].post_code
        }
        else if pickerView == pickerView_type_work {
            return "\(numberType![row].name ?? "...") \(numberType![row].dial_code ?? "+66")"
        }
        else if pickerView == pickerView_type_mobile {
            return "\(numberType![row].name ?? "...") \(numberType![row].dial_code ?? "+66")"
        }
        else {
            return "no selection"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView_group {
            first_group_pick = false
            selected_group_name = array_group_name[row]
            selected_group_id = array_group_id[row]
            selected_group_gen = array_group_gen[row]
            selected_group_code = array_group_code[row]
        }
        else if (pickerView == pickerView_country) {
            selected_country_id = country![row].country_id!
            selected_country_name = country![row].country_name!
        }
        else if (pickerView == pickerView_province) {
            selected_province_id = province![row].province_id!
            selected_province_name = province![row].province_name!
        }
        else if (pickerView == pickerView_district) {
            selected_district_id = district![row].district_id!
            selected_district_name = district![row].district_name!
        }
        else if (pickerView == pickerView_sub_district) {
            selected_subdistrict_id = sub_district![row].sub_district_id!
            selected_subdistrict_name = sub_district![row].sub_district_name!
        }
        else if (pickerView == pickerView_postcode) {
            selected_postcode = postcode![row].post_code!
        }
        else if pickerView == pickerView_type_work {
            if numberType![row].dial_code != nil {
                slt_work_type = numberType![row].dial_code!
            }
            else {
                slt_work_type = "+00"
            }
        }
        else if pickerView == pickerView_type_mobile {
            if numberType![row].dial_code != nil {
                slt_mobile_type = numberType![row].dial_code!
            }
            else {
                slt_mobile_type = "+00"
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let sg = segue.destination as? FieldAccount_VC
            sg?.typeLists     = statusLists
            sg?.registLists   = typeLists
            sg?.payment       = payment
            sg?.type_page     = type_page
            sg?.numberType    = numberType
            
            if type_page == "edit" {
                sg?.accountList   = accountList
                sg?.selected_location_image = selected_location_image
            }
        }
        if segue.identifier == "mapview" {
            let sg = segue.destination as? CoordinateMap_VC
            sg!.send_from = "field_address"
            print("Open map : \(selected_cusLat),\(selected_cusLng)")
            sg!.viewPostion.latitude    = Double(selected_cusLat)!
            sg!.viewPostion.longitude   = Double(selected_cusLng)!
            sg!.location_name           = selected_cusLocation
        }
    }
    
    func verifyInput()->Bool{
        if txt_company_th.text == "" {
            check_comp_th = false
        }
        else {
            check_comp_th = true
        }
        
        if txt_company_en.text == "" {
            check_comp_en = false
        }
        else {
            check_comp_en = true
        }
        
        if txt_work_num.text == "" {
            check_work = false
        }
        else {
            check_work = true
        }
        
        if selected_regist_id == "" {
            check_regist = false
        }
        else {
            check_regist = true
        }
        
        if selected_type_id == "" {
            check_type = false
        }
        else {
            check_type = true
        }
        
        if selected_group_id == "" {
            check_group = false
        }
        else {
            check_group = true
        }
        
        if check_comp_th && check_comp_en && check_work && check_regist && check_type && check_group {
            return true
        }
        else{
            return false
        }
    }
    
    func verifyString()->String{
        var alert_string = ""
        if !check_comp_en {
            alert_string = "\("check_comp_en".localized(gb.lang_now))\n"
        }
        if !check_comp_th {
            let str = "check_comp_th".localized(gb.lang_now)
            alert_string = "\(alert_string)\n\(str)"
        }
        if !check_work {
            let str = "check_work".localized(gb.lang_now)
            alert_string = "\(alert_string)\n\(str)"
        }
        if !check_regist {
            let str = "check_regist".localized(gb.lang_now)
            alert_string = "\(alert_string)\n\(str)"
        }
        if !check_type {
            let str = "check_type".localized(gb.lang_now)
            alert_string = "\(alert_string)\n\(str)"
        }
        if !check_group {
            let str = "check_group".localized(gb.lang_now)
            alert_string = "\(alert_string)\n\(str)"
        }
        return alert_string
    }
}

