//
//  InfoActivity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit
import SCLAlertView
import PhoneNumberKit
import SKCountryPicker
import FontAwesome_swift
import ADCountryPicker

class InfoActivity_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,ADCountryPickerDelegate {

    @IBOutlet weak var collection_photo: UICollectionView!
    @IBOutlet weak var table_contact: UITableView!
    @IBOutlet weak var tab_activity: UIButton!
    @IBOutlet weak var tab_upload: UIButton!
    @IBOutlet weak var tab_time: UIButton!
    @IBOutlet weak var tab_sign: UIButton!
    @IBOutlet weak var view_tab1: UIView!
    @IBOutlet weak var view_tab2: UIView!
    @IBOutlet weak var view_tab3: UIView!
    @IBOutlet weak var image_logo: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_datetime: UILabel!
    @IBOutlet weak var image_logo2: UIImageView!
    @IBOutlet weak var label_name2: UILabel!
    @IBOutlet weak var label_datetime2: UILabel!
    @IBOutlet weak var image_logo3: UIImageView!
    @IBOutlet weak var label_name3: UILabel!
    @IBOutlet weak var image_logo4: UIImageView!
    @IBOutlet weak var label_name4: UILabel!
    @IBOutlet weak var label_datetime3: UILabel!
    @IBOutlet weak var label_activity_status: UILabel!
    @IBOutlet weak var txt_activity_status: UILabel!
    @IBOutlet weak var seperate_status: UILabel!
    @IBOutlet weak var label_subject: UILabel!
    @IBOutlet weak var label_subject_tv: UITextView!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_project: UILabel!
    @IBOutlet weak var label_contact: UILabel!
    @IBOutlet weak var label_account: UILabel!
    @IBOutlet weak var label_place: UILabel!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_priority: UILabel!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var sec_subject: UILabel!
    @IBOutlet weak var sec_description: UILabel!
    @IBOutlet weak var sec_type: UILabel!
    @IBOutlet weak var sec_project: UILabel!
    @IBOutlet weak var sec_contact: UILabel!
    @IBOutlet weak var sec_account: UILabel!
    @IBOutlet weak var sec_place: UILabel!
    @IBOutlet weak var sec_status: UILabel!
    @IBOutlet weak var sec_priority: UILabel!
    @IBOutlet weak var sec_location: UILabel!
    @IBOutlet weak var sec_cost: UILabel!
    @IBOutlet weak var sec_other: UILabel!
    @IBOutlet weak var sec_photo: UILabel!
    @IBOutlet weak var icon_type: UIImageView!
    @IBOutlet weak var icon_project: UIImageView!
    @IBOutlet weak var icon_contact: UIImageView!
    @IBOutlet weak var icon_account: UIImageView!
    @IBOutlet weak var icon_place: UIImageView!
    @IBOutlet weak var icon_location: UIButton!
    @IBOutlet weak var label_description: UITextView!
    @IBOutlet weak var scroll_height: NSLayoutConstraint!
    @IBOutlet weak var table_height: NSLayoutConstraint!
    @IBOutlet weak var edit_data: UIBarButtonItem!
    @IBOutlet weak var data_: UIBarButtonItem!
    @IBOutlet weak var file_: UIBarButtonItem!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var label_activity_name: UILabel!
    @IBOutlet weak var label_account_name: UILabel!
    @IBOutlet weak var label_stamp_in: UILabel!
    @IBOutlet weak var label_stamp_out: UILabel!
    @IBOutlet weak var button_stamp: UIImageView!
    @IBOutlet weak var sec_in: UILabel!
    @IBOutlet weak var sec_out: UILabel!
    @IBOutlet weak var sec_time_subject: UILabel!
    @IBOutlet weak var sec_time_account: UILabel!
    @IBOutlet weak var icon_time_subject: UIImageView!
    @IBOutlet weak var icon_time_account: UIImageView!
    @IBOutlet weak var icon_time_in: UIImageView!
    @IBOutlet weak var icon_time_out: UIImageView!
    @IBOutlet weak var txt_name: UILabel!
    @IBOutlet weak var txt_tel: UILabel!
    @IBOutlet weak var txt_signature: UILabel!
    @IBOutlet weak var txtf_name: UITextField!
    @IBOutlet weak var txtf_tel: UITextField!
    @IBOutlet weak var txtf_dial: UITextField!
    @IBOutlet weak var country_flag: UIImageView!
    @IBOutlet weak var country_dial: UILabel!
    @IBOutlet weak var country_view: UIView!
    @IBOutlet weak var sign_view: UIView!
    @IBOutlet weak var sign_image: UIImageView!
    
    var activityInfo:ActivityInfo? = nil
    var activityFiles:ActivityFiles? = nil
    var standardReturn:StandardReturn? = nil
    var mapLocationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var max_height = CGFloat(1350)
    var array_image = [UIImage]()
    var array_image_id = [String]()
    var active_page = 1
    var icon_size = 35
    var slt_id = ""
    var can_edit = true
    var timer = Timer()
    var sec = 0
    let phoneNumberKit = PhoneNumberKit()
    let picker = ADCountryPicker()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.showCallingCodes = true
        picker.showFlags = true
        picker.pickerTitle = "Select a Country"
        picker.searchBarBackgroundColor = UIColor.white
        
        showLoad()
        initLayout()
        initMap()
        initTab()
        initData()
        tabButton(tab:active_page)
    }
    
    func initData(){
        getActivityInfo()
        getActivityFile()
    }
    
    func initLayout(){
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        image_logo.image = UIImage(named: "phd_user")
        image_logo.layoutIfNeeded()
        image_logo.layer.cornerRadius = 100 / 2
        image_logo.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_logo.layer.borderWidth = 3
        image_logo.clipsToBounds = true
        image_logo2.image = UIImage(named: "phd_user")
        image_logo2.layoutIfNeeded()
        image_logo2.layer.cornerRadius = 100 / 2
        image_logo2.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_logo2.layer.borderWidth = 3
        image_logo2.clipsToBounds = true
        image_logo3.image = UIImage(named: "phd_user")
        image_logo3.layoutIfNeeded()
        image_logo3.layer.cornerRadius = 100 / 2
        image_logo3.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_logo3.layer.borderWidth = 3
        image_logo3.clipsToBounds = true
        image_logo4.image = UIImage(named: "phd_user")
        image_logo4.layoutIfNeeded()
        image_logo4.layer.cornerRadius = 100 / 2
        image_logo4.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_logo4.layer.borderWidth = 3
        image_logo4.clipsToBounds = true
        
        label_name.textColor = gb.color_darkgrey
        label_datetime.textColor = gb.color_main
        image_logo.backgroundColor = UIColor.white
        image_logo2.backgroundColor = UIColor.white
        image_logo3.backgroundColor = UIColor.white
        image_logo4.backgroundColor = UIColor.white
        label_name2.textColor = gb.color_darkgrey
        label_datetime2.textColor = gb.color_main
        label_datetime3.textColor = gb.color_main
        label_name3.textColor = gb.color_darkgrey
        label_name4.textColor = gb.color_darkgrey
        label_time.textColor = gb.color_darkgrey
        label_activity_name.textColor = gb.color_main
        label_account_name.textColor = gb.color_main
        label_stamp_in.textColor = gb.color_darkgrey
        label_stamp_out.textColor = gb.color_darkgrey
        label_activity_status.textColor = gb.color_lightgrey
        seperate_status.textColor = gb.color_lightgrey
        label_subject_tv.textColor = gb.color_main
        label_description.textColor = gb.color_darkgrey
        label_type.textColor = gb.color_main
        label_project.textColor = gb.color_main
        label_contact.textColor = gb.color_main
        label_account.textColor = gb.color_main
        label_place.textColor = gb.color_darkgrey
        label_status.textColor = gb.color_darkgrey
        label_priority.textColor = gb.color_darkgrey
        label_location.textColor = gb.color_darkgrey
        label_cost.textColor = gb.color_darkgrey
        sec_subject.textColor = gb.color_lightgrey
        sec_description.textColor = gb.color_lightgrey
        sec_type.textColor = gb.color_lightgrey
        sec_project.textColor = gb.color_lightgrey
        sec_contact.textColor = gb.color_lightgrey
        sec_account.textColor = gb.color_lightgrey
        sec_place.textColor = gb.color_lightgrey
        sec_status.textColor = gb.color_lightgrey
        sec_priority.textColor = gb.color_lightgrey
        sec_location.textColor = gb.color_lightgrey
        sec_cost.textColor = gb.color_lightgrey
        sec_other.textColor = gb.color_lightgrey
        sec_photo.textColor = gb.color_lightgrey
        sec_in.textColor = gb.color_lightgrey
        sec_out.textColor = gb.color_lightgrey
        sec_time_subject.textColor = gb.color_lightgrey
        sec_time_account.textColor = gb.color_lightgrey
        sec_in.text = "in".localized(gb.lang_now)
        sec_out.text = "out".localized(gb.lang_now)
        sec_subject.text = "Usubject".localized(gb.lang_now)
        sec_description.text = "Udescription".localized(gb.lang_now)
        sec_type.text = "Utype".localized(gb.lang_now)
        sec_project.text = "Uproject".localized(gb.lang_now)
        sec_contact.text = "Ucontact".localized(gb.lang_now)
        sec_account.text = "Uaccount".localized(gb.lang_now)
        sec_place.text = "Uplace".localized(gb.lang_now)
        sec_status.text = "Uactivity_status".localized(gb.lang_now)
        sec_priority.text = "Upriority".localized(gb.lang_now)
        sec_location.text = "Ulocation".localized(gb.lang_now)
        sec_cost.text = "Ucost".localized(gb.lang_now)
        sec_other.text = "Uother_contact".localized(gb.lang_now)
        sec_photo.text = "Uphoto_file".localized(gb.lang_now)
        label_activity_status.text = "status".localized(gb.lang_now)
        txt_name.text = "name".localized(gb.lang_now)
        txt_tel.text = "tel".localized(gb.lang_now)
        txt_signature.text = "signature".localized(gb.lang_now)
        txtf_dial.inputView = UIView()
        txtf_dial.inputAccessoryView = UIView()
        txtf_dial.tintColor = .white
        
        sign_view.layer.borderWidth = 1
        sign_view.layer.borderColor = gb.color_border.cgColor
        sign_view.layer.cornerRadius = 10
        sign_view.layer.backgroundColor = UIColor.white.cgColor
        sign_view.clipsToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.openCountry))
        self.country_view.addGestureRecognizer(gesture)
        
        let openSign = UITapGestureRecognizer(target: self, action:  #selector(self.openSign))
        self.sign_view.addGestureRecognizer(openSign)
        
        icon_type.image = UIImage.fontAwesomeIcon(name: .chartPie, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_project.image = UIImage.fontAwesomeIcon(name: .filePowerpoint, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_contact.image = UIImage.fontAwesomeIcon(name: .userCircle, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_account.image = UIImage.fontAwesomeIcon(name: .building, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_place.image = UIImage.fontAwesomeIcon(name: .signInAlt, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_location.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        collection_photo.backgroundColor = UIColor.clear
        icon_time_account.image = UIImage.fontAwesomeIcon(name: .building, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_time_in.image = UIImage.fontAwesomeIcon(name: .signInAlt, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_time_out.image = UIImage.fontAwesomeIcon(name: .signOutAlt, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_time_subject.tintColor = gb.color_lightgrey
        
        getCurrentTime()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapStamp(tapGestureRecognizer:)))
        button_stamp.isUserInteractionEnabled = true
        button_stamp.addGestureRecognizer(tap)
    }
    
    @objc func openCountry(sender : UITapGestureRecognizer) {
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    @objc func openSign(sender : UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sign_page") as? Signature_VC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func initMap(){
        mapLocationManager.delegate = self
        mapLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse && CLLocationManager.authorizationStatus() != . authorizedAlways {
        mapLocationManager.requestWhenInUseAuthorization()
        }
        mapLocationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        userLocation.latitude = locValue.latitude
        userLocation.longitude = locValue.longitude
    }
    
    @objc func tapStamp(tapGestureRecognizer: UITapGestureRecognizer)
    {
        stampActivity()
    }
    
    func getCurrentTime() {
        let postString = "type=\("stamp_time")"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_STAMP_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.standardReturn?.status == "0" {
                    self.sec = self.convertTimeToSec(time: self.standardReturn?.msg ?? "00:00:00")
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
                }
            }
        }
        task.resume()
    }
    
    @objc func currentTime() {
        let hh = Int(sec / 3600)
        let mm = Int(sec / 60) % 60
        _ = Int(sec % 60)
        var smm = ""
        var shh = ""
        if mm < 10 {
            smm = "0\(mm)"
        }
        else {
            smm = "\(mm)"
        }
        
        if hh < 10 {
            shh = "0\(hh)"
        }
        else {
            shh = "\(hh)"
        }
        let time = "\(shh):\(smm)"
        label_time.text = time
        sec += 1
    }
    
    @objc func edit_page(sender:UIBarButtonItem!) {
        if active_page == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddActivity_VC") as? AddActivity_VC
            vc!.page_type = "edit"
            vc!.activityInfo = activityInfo
            vc!.slt_id = slt_id
            self.navigationController?.pushViewController(vc!, animated: true)
//            _ = data_.target?.perform(data_.action, with: nil)
        }
        else if active_page == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddFileActivity_VC") as? AddFileActivity_VC
            vc!.array_image_id = array_image_id
            vc!.array_image = array_image
            vc!.slt_id = slt_id
            self.navigationController?.pushViewController(vc!, animated: true)
//            _ = file_.target?.perform(file_.action, with: nil)
        }
        else {
            
        }
    }
    
    func initLabelData() {
        let data = activityInfo?.data?.first
        label_name.text         = "\(data?.first_en ?? "") \(data?.last_en ?? "")"
        label_datetime.text     = "\(DateToString(date: data?.start_date ?? "0000-00-00")) \(data?.time_start ?? "") - \(DateToString(date: data?.end_date ?? "0000-00-00")) \(data?.time_end ?? "")"
        label_name2.text        = "\(data?.first_en ?? "") \(data?.last_en ?? "")"
        label_name3.text        = "\(data?.first_en ?? "") \(data?.last_en ?? "")"
        label_name4.text        = "\(data?.first_en ?? "") \(data?.last_en ?? "")"
        label_datetime2.text    = "\(DateToString(date: data?.start_date ?? "0000-00-00")) \(data?.time_start ?? "") - \(DateToString(date: data?.end_date ?? "0000-00-00")) \(data?.time_end ?? "")"
        label_datetime3.text    = "\(DateToString(date: data?.start_date ?? "0000-00-00")) \(data?.time_start ?? "") - \(DateToString(date: data?.end_date ?? "0000-00-00")) \(data?.time_end ?? "")"
        label_subject_tv.text      = data?.activity_name
        label_description.text  = data?.activity_description
        label_type.text         = data?.type_name
        label_project.text      = data?.project_name
        label_contact.text      = "\(data?.contact_first ?? "") \(data?.contact_last ?? "")"
        label_account.text      = "\(data?.account_en ?? "")"
        label_status.text       = data?.status_name
        label_priority.text     = data?.priority_name
        label_location.text     = data?.location
        label_cost.text         = data?.cost
        label_account_name.text  = data?.account_en ?? ""
        label_activity_name.text = data?.activity_name ?? ""
        label_stamp_in.text      = "In    : \(data?.stamp_in ?? "-")"
        label_stamp_out.text     = "Out : \(data?.stamp_out ?? "-")"
        
        txt_activity_status.text = data?.status
        if data?.status == "Plan" {
            txt_activity_status.textColor = gb.ac_plan
        }
        else if data?.status == "Close" {
            txt_activity_status.textColor = gb.ac_close
            can_edit = false
        }
        else if data?.status == "Approve" {
            txt_activity_status.textColor = gb.ac_approve
        }
        else if data?.status == "Not Approve" {
            txt_activity_status.textColor = gb.ac_notapprove
        }
        else if data?.status == "Need Infomation" {
            txt_activity_status.textColor = gb.ac_needinfo
        }
        else if data?.status == "Leave" {
            txt_activity_status.textColor = gb.ac_leave
        }
        else if data?.status == "Create Project" {
            txt_activity_status.textColor = gb.ac_create
        }
        else if data?.status == "Join" {
            txt_activity_status.textColor = gb.ac_join
        }
        else {
            txt_activity_status.textColor = gb.color_main
        }
        
        if can_edit {
            let ic = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(edit_page))
            self.navigationItem.rightBarButtonItem  = ic
        }
        else {
            self.navigationItem.rightBarButtonItem  = nil
        }
        
        if (data?.location_lat != "" && data?.location_lat != nil) && (data?.location_lng != "" && data?.location_lng != nil){
            icon_location.isHidden = false
        }
        else {
            icon_location.isHidden = true
        }
        
        if data?.place == "in" {
            label_place.text = "in_door".localized(gb.lang_now)
            icon_place.image = UIImage.fontAwesomeIcon(name: .signInAlt, style: .solid, textColor: gb.color_darkgrey, size: CGSize(width: icon_size, height: icon_size))
        }
        else if data?.place == "out" {
            label_place.text = "out_door".localized(gb.lang_now)
            icon_place.image = UIImage.fontAwesomeIcon(name: .signOutAlt, style: .solid, textColor: gb.color_darkgrey, size: CGSize(width: icon_size, height: icon_size))
        }
        else {
            label_place.text = ""
        }
        
        if data?.emp_pic != nil && data?.emp_pic != "" {
            var img = ""
            img = "\(Const_Var.BASE_URL)\(String(data?.emp_pic! ?? ""))"
            img = img.replacingOccurrences(of: " ", with: "%20")
            img = img.replacingOccurrences(of: "+", with: "%2B")
            img = img.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            let url = URL(string: img)
            if url != nil {
                do{
                    let data = try Data(contentsOf: url!)
                    let im = UIImage(data: data) ?? UIImage(named:"phd_user")
                    image_logo.image = im
                    image_logo2.image = im
                    image_logo3.image = im
                }
                catch{
                    image_logo.image = UIImage(named:"phd_user")!
                    image_logo2.image = UIImage(named:"phd_user")!
                    image_logo3.image = UIImage(named:"phd_user")!
                }
            }
            else {
                image_logo.image = UIImage(named:"phd_user")!
                image_logo2.image = UIImage(named:"phd_user")!
                image_logo3.image = UIImage(named:"phd_user")!
            }
        }
        else {
            image_logo.image = UIImage(named:"phd_user")!
            image_logo2.image = UIImage(named:"phd_user")!
            image_logo3.image = UIImage(named:"phd_user")!
        }
    }
    
    func stampActivity(){
        var stamp_by_emp = ""
        var stamp_by_comp = ""
        var act_id = ""
        var status = "in"
        if activityInfo != nil {
            let data = activityInfo?.data?.first
            act_id = data?.activity_id ?? ""
            
            if data?.stamp_in == "" || data?.stamp_in == nil{
                status = "in"
            }
            else {
                status = "out"
            }
            
            if data?.emp_id != gb.user?.emp_id {
                stamp_by_emp = data?.emp_id ?? ""
                stamp_by_comp = data?.comp_id ?? ""
            }
        }
        let postString = "type=\("stamp_activity")&emp_id=\(gb.user?.emp_id ?? "")&comp_id=\(gb.user?.comp_id ?? "")&status=\(status)&activity_id=\(act_id)&time_lat=\(String(userLocation.latitude))&time_lng=\(userLocation.longitude)&branch_id=\(gb.user?.branch_id ?? "")&device_type=\("IOS")&stamp_by_emp=\(stamp_by_emp)&stamp_by_comp=\(stamp_by_comp)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_STAMP_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                let alert = SCLAlertView(appearance: appearance)
                alert.addButton("close".localized(gb.lang_now)) {
                   alert.hideView()
                    if self.standardReturn?.status == "0" {
                        self.backOne()
                    }
                }
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func getActivityInfo(){
        let postString = "activity_id=\(slt_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_INFO)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityInfo = try JSONDecoder().decode(ActivityInfo.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.activityInfo?.data != nil {
                    self.initLabelData()
                }
                self.table_contact.reloadData()
            }
        }
        task.resume()
    }
    
    func getActivityFile(){
        let postString = "activity_id=\(slt_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_FILE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityFiles = try JSONDecoder().decode(ActivityFiles.self, from: data!)
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
        array_image = [UIImage]()
        array_image_id = [String]()
        for item in self.activityFiles!.data ?? [] {
            array_image_id.append(item.image_id ?? "")
            if item.image_path != nil && item.image_path != "" {
                var image_str = ""
                image_str = "\(Const_Var.BASE_URL)crm/\(String(item.image_path!))"
                image_str = image_str.replacingOccurrences(of: " ", with: "%20")
                image_str = image_str.replacingOccurrences(of: "+", with: "%2B")
                image_str = image_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                print(image_str)
                let url = URL(string: image_str)
                if url != nil {
                    do{
                        let data = try Data(contentsOf: url!)
                        let im = UIImage(data: data) ?? UIImage()
                        self.array_image.append(im)
                    }
                    catch{
                        self.array_image.append(UIImage())
                    }
                }
                else{
                    self.array_image.append(UIImage())
                }
            }
            else {
                self.array_image.append(UIImage())
            }
        }
        collection_photo.reloadData()
        closeLoad()
    }
    
    func initTab(){
        tab_activity.setTitle("title_activity".localized(gb.lang_now), for: .normal)
        tab_upload.setTitle("upload".localized(gb.lang_now), for: .normal)
        tab_time.setTitle("title_time".localized(gb.lang_now), for: .normal)
        tab_sign.setTitle("signature".localized(gb.lang_now), for: .normal)
        tab_activity.alignVertical()
        tab_upload.alignVertical()
        tab_time.alignVertical()
        tab_sign.alignVertical()
    }
    
    func tabButton(tab:Int){
        tab_activity.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_upload.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_time.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_sign.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_activity.tintColor = gb.color_lightgrey
        tab_upload.tintColor = gb.color_lightgrey
        tab_time.tintColor = gb.color_lightgrey
        tab_sign.tintColor = gb.color_lightgrey
        tab_activity.setImage(UIImage.fontAwesomeIcon(name: .child, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: 35, height: 35)), for: .normal)
        tab_upload.setImage(UIImage.fontAwesomeIcon(name: .images, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: 35, height: 35)), for: .normal)
        tab_time.setImage(UIImage.fontAwesomeIcon(name: .clock, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: 35, height: 35)), for: .normal)
        tab_sign.setImage(UIImage.fontAwesomeIcon(name: .paintBrush, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: 35, height: 35)), for: .normal)
        
        if tab == 1 {
            active_page = 1
            tab_activity.setTitleColor(gb.color_main, for: .normal)
            tab_activity.setImage(UIImage.fontAwesomeIcon(name: .child, style: .solid, textColor: gb.color_main, size: CGSize(width: 35, height: 35)), for: .normal)
            tab_activity.tintColor = gb.color_main
            self.title = "title_activity".localized(gb.lang_now)
            if can_edit {
                let ic = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(edit_page))
                self.navigationItem.rightBarButtonItem  = ic
            }
            else {
                self.navigationItem.rightBarButtonItem  = nil
            }
        }
        else if tab == 2 {
            active_page = 2
            tab_upload.setTitleColor(gb.color_main, for: .normal)
            tab_upload.setImage(UIImage.fontAwesomeIcon(name: .images, style: .solid, textColor: gb.color_main, size: CGSize(width: 35, height: 35)), for: .normal)
            tab_upload.tintColor = gb.color_main
            self.title = "photo".localized(gb.lang_now)
            let ic = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(edit_page))
            self.navigationItem.rightBarButtonItem  = ic
        }
        else if tab == 3 {
            active_page = 3
            tab_time.setTitleColor(gb.color_main, for: .normal)
            tab_time.setImage(UIImage.fontAwesomeIcon(name: .clock, style: .solid, textColor: gb.color_main, size: CGSize(width: 35, height: 35)), for: .normal)
            tab_time.tintColor = gb.color_main
            self.title = "title_time".localized(gb.lang_now)
            self.navigationItem.rightBarButtonItem  = nil
        }
        else {
            active_page = 4
            tab_sign.setTitleColor(gb.color_main, for: .normal)
            tab_sign.setImage(UIImage.fontAwesomeIcon(name: .paintBrush, style: .solid, textColor: gb.color_main, size: CGSize(width: 35, height: 35)), for: .normal)
            tab_sign.tintColor = gb.color_main
            self.title = "signature".localized(gb.lang_now)
            self.navigationItem.rightBarButtonItem  = nil
        }
        initTab()
    }
    
    @IBAction func tap_1(_ sender: Any) {
        tabButton(tab:1)
        tabChange(send_case: 1)
    }
    
    @IBAction func tap_2(_ sender: Any) {
        tabButton(tab:2)
        tabChange(send_case: 2)
    }
    
    @IBAction func tab_3(_ sender: Any) {
        tabButton(tab:3)
        tabChange(send_case: 3)
    }
    
    func tabChange(send_case:Int){
        if send_case == 1 {
            view_tab1.isHidden = false
            view_tab2.isHidden = true
            view_tab3.isHidden = true
        }
        else if send_case == 2 {
            view_tab1.isHidden = true
            view_tab2.isHidden = false
            view_tab3.isHidden = true
        }
        else {
            view_tab1.isHidden = true
            view_tab2.isHidden = true
            view_tab3.isHidden = false
        }
    }
    
    @IBAction func tapTelCode(_ sender: Any) {
        
    }
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        self.dismiss(animated: true)
        var flagImage =  picker.getFlag(countryCode: code)
        if code == "TH" {
            flagImage = UIImage(named: "thai_flag")
        }
        country_flag.image = flagImage
        country_dial.text = dialCode
    }
    
    func DateToString(date : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd"
        date_formatter2.dateFormat = "dd/MM/yyyy"
        if let to_date = date_formatter.date(from: date) {
            let to_string = date_formatter2.string(from: to_date)
            return to_string
        }
        else {
            return "00/00/0000"
        }
    }
    
    func loadImageContact(image_str:String)->UIImage{
        var rt_image = UIImage(named:"phd_user")!
        if image_str != "" {
            var img = ""
            img = "\(Const_Var.BASE_URL)\(image_str)"
            img = img.replacingOccurrences(of: " ", with: "%20")
            img = img.replacingOccurrences(of: "+", with: "%2B")
            img = img.replacingOccurrences(of: "../", with: "")
            img = img.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            let url = URL(string: img)
            if url != nil {
                do{
                    let data = try Data(contentsOf: url!)
                    let im = UIImage(data: data) ?? UIImage(named:"phd_user")
                    rt_image = im ?? UIImage(named:"phd_user")!
                }
                catch{

                }
            }
        }
        return rt_image
    }
    
    func convertTimeToSec(time : String) -> Int{
        var sec = 0
        let times = time.components(separatedBy: ":")
        let sec_h = (Int(times[0]) ?? 0) * 3600
        let sec_m = (Int(times[1]) ?? 0) * 60
        let sec_s = Int(times[2])
        sec = sec_h + sec_m + (sec_s ?? 0)
        return sec
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = activityInfo?.other_contact?.count ?? 0
        if row >= 3 {
            table_height.constant = 210
        }
        else if row >= 2 {
            table_height.constant = 140
        }
        else if row >= 1 {
            table_height.constant = 70
        }
        else if row == 0 {
            table_height.constant = 0
        }
        scroll_height.constant = max_height - (210 - table_height.constant)
        view.layoutIfNeeded()
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = activityInfo?.other_contact?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityContact_TVC
        cell.selectionStyle = .none
        cell.image_contact.image = loadImageContact(image_str: data?.contact_image ?? "")
        cell.label_name.text = "\(data?.contact_first ?? "") \(data?.contact_last ?? "")"
        cell.label_comp.text = data?.account_en
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityFiles?.data?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ActivityPhoto_CVC
        cell.image_photo.image = array_image[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collection_photo.frame.width / 2) - 3, height: (collection_photo.frame.width / 2) - 6)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "previewimage") as? PreviewImage_VC
        vc?.image = array_image[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    
    func backOne() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let sg = segue.destination as? AddActivity_VC
            sg!.page_type = "edit"
            sg!.activityInfo = activityInfo
            sg!.slt_id = slt_id
        }
        else if segue.identifier == "file_segue" {
            let sg = segue.destination as? AddFileActivity_VC
            sg!.array_image_id = array_image_id
            sg!.array_image = array_image
            sg!.slt_id = slt_id
        }
        else if segue.identifier == "segue_preview" {
            let sg = segue.destination as? PreviewLocation_VC
            sg!.lat = activityInfo?.data?.first?.location_lat ?? "0.0"
            sg!.lng = activityInfo?.data?.first?.location_lng ?? "0.0"
        }
    }
}
