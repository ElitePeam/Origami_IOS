//
//  AddActivity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SCLAlertView
import FontAwesome_swift

class AddActivity_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var table_contact: UITableView!
    @IBOutlet weak var view_separate1: UIView!
    @IBOutlet weak var view_separate2: UIView!
    @IBOutlet weak var view_separate3: UIView!
    @IBOutlet weak var view_separate4: UIView!
    @IBOutlet weak var view_separate5: UIView!
    @IBOutlet weak var view_separate6: UIView!
    @IBOutlet weak var sec_location: UILabel!
    @IBOutlet weak var sec_contact: UILabel!
    @IBOutlet weak var btn_marker: UIButton!
    @IBOutlet weak var btn_contact: UIButton!
    @IBOutlet weak var btn_skoop: UIButton!
    @IBOutlet weak var btn_close: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var icon_location: UIButton!
    @IBOutlet weak var txt_subject: UITextField!
    @IBOutlet weak var txt_sdate: UITextField!
    @IBOutlet weak var txt_stime: UITextField!
    @IBOutlet weak var txt_edate: UITextField!
    @IBOutlet weak var txt_etime: UITextField!
    @IBOutlet weak var txt_type: UITextField!
    @IBOutlet weak var txt_project: UITextField!
    @IBOutlet weak var txt_contact: UITextField!
    @IBOutlet weak var txt_account: UITextField!
    @IBOutlet weak var txt_place: UITextField!
    @IBOutlet weak var txt_status: UITextField!
    @IBOutlet weak var txt_priority: UITextField!
    @IBOutlet weak var txt_cost: UITextField!
    @IBOutlet weak var txtv_description: UITextView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var view_description: UIView!
    @IBOutlet weak var table_height_const: NSLayoutConstraint!
    @IBOutlet weak var view_scroll_height: NSLayoutConstraint!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_subject: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_sdate: UILabel!
    @IBOutlet weak var label_stime: UILabel!
    @IBOutlet weak var label_edate: UILabel!
    @IBOutlet weak var label_etime: UILabel!
    @IBOutlet weak var label_project: UILabel!
    @IBOutlet weak var label_contact: UILabel!
    @IBOutlet weak var label_account: UILabel!
    @IBOutlet weak var label_place: UILabel!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_priority: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    
    var activityTypes:ActivityTypes? = nil
    var activityProjects:ActivityProjects? = nil
    var activityContacts:ActivityContacts? = nil
    var activityStatuss:ActivityStatuss? = nil
    var activityPrioritys:ActivityPrioritys? = nil
    var standardReturn:StandardReturn? = nil
    var activityInfo:ActivityInfo? = nil
    var icon_size = 35
    let icon_skoop_size = 25
    var textfieldList:[UITextField] = []
    var labelList:[UILabel] = []
    var labelTextList:[String] = []
    var placeholderList:[String] = []
    var toolBar : UIToolbar = UIToolbar()
    var doneButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    var start_date = UIDatePicker()
    var end_date = UIDatePicker()
    var start_time = UIDatePicker()
    var end_time = UIDatePicker()
    let pkv_type = UIPickerView()
    let pkv_project = UIPickerView()
    let pkv_contact = UIPickerView()
    let pkv_place = UIPickerView()
    let pkv_status = UIPickerView()
    let pkv_priority = UIPickerView()
    var page_type = ""
    let place_list = ["in_door".localized(gb.lang_now),"out_door".localized(gb.lang_now)]
    var scroll_now = CGFloat(0)
    let date_fmt = DateFormatter()
    let time_fmt = DateFormatter()
    var slt_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVariable()
        initLayout()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showLoad()
        if gb.activityData != nil {
            setDataLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        for txt_item in textfieldList {
            txt_item.delegate = self
            setTextField(txt_field: txt_item)
            setPlaceHolder(txt_field: txt_item)
            setKeyborad(txt_field: txt_item)
        }
        for label in labelList {
            setLabel(label:label)
        }
        closeLoad()
    }
    
    func initLayout(){
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        let done_save = UIBarButtonItem(title: "done".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        view_separate1.backgroundColor = gb.color_seperate
        view_separate2.backgroundColor = gb.color_seperate
        view_separate3.backgroundColor = gb.color_seperate
        view_separate4.backgroundColor = gb.color_seperate
        view_separate5.backgroundColor = gb.color_seperate
        view_separate6.backgroundColor = gb.color_seperate
        sec_location.textColor = gb.color_lightgrey
        sec_contact.textColor  = gb.color_lightgrey
        btn_marker.setTitleColor(gb.color_main, for: .normal)
        btn_contact.setTitleColor(gb.color_main, for: .normal)
        btn_skoop.setTitleColor(gb.color_darkgrey, for: .normal)
        btn_close.setTitleColor(gb.color_darkgrey, for: .normal)
        btn_delete.setTitleColor(gb.color_redtext, for: .normal)
        label_location.textColor = gb.color_darkgrey
        icon_location.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        if page_type == "add" {
            self.title = "add_activity".localized(gb.lang_now)
            view_separate4.isHidden = true
            view_separate5.isHidden = true
            view_separate6.isHidden = true
            btn_skoop.isHidden      = true
            btn_close.isHidden      = true
            btn_delete.isHidden     = true
            view_scroll_height.constant = 1600
        }
        else {
            self.title = "edit_activity".localized(gb.lang_now)
            view_scroll_height.constant = 1900
        }
        scroll_now = view_scroll_height.constant
        view.layoutIfNeeded()
        
        let loc = Locale(identifier: "us")
        start_date.locale = loc
        end_date.locale = loc
        start_time.locale = loc
        end_time.locale = loc
        start_date.datePickerMode = UIDatePicker.Mode.date
        end_date.datePickerMode = UIDatePicker.Mode.date
        start_time.datePickerMode = UIDatePicker.Mode.time
        end_time.datePickerMode = UIDatePicker.Mode.time
        txt_sdate.inputView = start_date
        txt_edate.inputView = end_date
        txt_stime.inputView = start_time
        txt_etime.inputView = end_time

        txt_account.isEnabled = false
        txt_edate.isEnabled = false
        txt_edate.backgroundColor = gb.color_disable
        txt_account.backgroundColor = gb.color_disable
        txt_type.inputView = pkv_type
        txt_type.delegate = self
        pkv_type.delegate = self
        txt_project.inputView = pkv_project
        txt_project.delegate = self
        pkv_project.delegate = self
        txt_contact.inputView = pkv_contact
        txt_contact.delegate = self
        pkv_contact.delegate = self
        txt_place.inputView = pkv_place
        txt_place.delegate = self
        pkv_place.delegate = self
        txt_status.inputView = pkv_status
        txt_status.delegate = self
        pkv_status.delegate = self
        txt_priority.inputView = pkv_priority
        txt_priority.delegate = self
        pkv_priority.delegate = self
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
        
        view_description.backgroundColor = UIColor.clear
        txtv_description.layer.borderWidth = 1.0
        txtv_description.layer.cornerRadius = 22.5
        txtv_description.layer.borderColor = UIColor.lightGray.cgColor
        txtv_description.textColor = gb.color_phd
        txtv_description.text = "\("description".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))"
        txtv_description.delegate = self
        txtv_description.inputAccessoryView = toolBar
        let one_tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLocation))
        label_location.isUserInteractionEnabled = true
        label_location.addGestureRecognizer(one_tap)
        date_fmt.locale = Locale(identifier: "en_US_POSIX")
        date_fmt.dateFormat = "yyyy-MM-dd"
        time_fmt.locale = Locale(identifier: "en_US_POSIX")
        time_fmt.dateFormat = "HH:mm"
        btn_contact.setTitle("add_other_contact".localized(gb.lang_now), for: .normal)
        btn_skoop.setTitle("Uskoop".localized(gb.lang_now), for: .normal)
        btn_close.setTitle("close_activity".localized(gb.lang_now), for: .normal)
        btn_delete.setTitle("delete_activity".localized(gb.lang_now), for: .normal)
        sec_location.text = "activity_location".localized(gb.lang_now)
        sec_contact.text = "Uother_contact".localized(gb.lang_now)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if txt_cost.isFirstResponder {
                if txt_cost.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
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
    
    @objc func tapLocation(sender:UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "delete".localized(gb.lang_now), style: .destructive) { action in
            gb.activityData?.location = ""
            gb.activityData?.location_lat = ""
            gb.activityData?.location_long = ""
            self.setDataLayout()
        }
        
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func initVariable(){
        textfieldList = [txt_subject,txt_sdate,txt_stime,txt_edate,txt_etime,txt_type,txt_project,txt_contact,txt_account,txt_place,txt_status,txt_priority,txt_cost]
        placeholderList = ["\("subject".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))","Start date","Start time","End date","End time","\("type".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))","\("project".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))","\("contact".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))","account".localized(gb.lang_now),"Place","Status","Priority","cost".localized(gb.lang_now)]
        
        labelList = [label_type,label_subject,label_description,label_sdate,label_stime,label_edate,label_etime,label_project,label_contact,label_account,label_place,label_status,label_priority,label_cost]
        labelTextList = ["type".localized(gb.lang_now),"subject".localized(gb.lang_now),"description".localized(gb.lang_now),"start_date".localized(gb.lang_now),"start_time".localized(gb.lang_now),"end_date".localized(gb.lang_now),"end_time".localized(gb.lang_now),"project".localized(gb.lang_now),"contact".localized(gb.lang_now),"account".localized(gb.lang_now),"place".localized(gb.lang_now),"status".localized(gb.lang_now),"priority".localized(gb.lang_now),"cost".localized(gb.lang_now)]
    }
    
    func initData(){
        gb.newActivityData()
        if page_type == "edit" {
            setEditData()
        }
        else {
            gb.activityData?.start_date = date_fmt.string(from: Date())
            gb.activityData?.end_date = date_fmt.string(from: Date())
            gb.activityData?.start_time = time_fmt.string(from: Date())
            gb.activityData?.end_time = time_fmt.string(from: Date().addingTimeInterval(60))
            gb.activityData?.place = "in_door".localized(gb.lang_now)
            gb.activityData?.place_id = "in"
        }
        setDataLayout()
        getActivityType()
        getActivityProject()
        getActivityStatus(comp_id: gb.user?.comp_id ?? "0")
        getActivityPriority(comp_id: gb.user?.comp_id ?? "0")
    }
    
    func setDataLayout(){
        txt_subject.text     = gb.activityData?.subject
        txt_sdate.text       = DateToString(date: gb.activityData?.start_date ?? "00/00/0000")
        txt_stime.text       = gb.activityData?.start_time
        txt_edate.text       = DateToString(date: gb.activityData?.end_date ?? "00/00/0000")
        txt_etime.text       = gb.activityData?.end_time
        txt_type.text        = gb.activityData?.type
        txt_project.text     = gb.activityData?.project
        txt_contact.text     = gb.activityData?.contact
        txt_account.text     = gb.activityData?.account
        txt_place.text       = gb.activityData?.place
        txt_status.text      = gb.activityData?.status
        txt_priority.text    = gb.activityData?.priority
        txt_cost.text        = gb.activityData?.cost
        label_location.text  = gb.activityData?.location
        
        if gb.activityData?.description == "" {
            txtv_description.text = "\("description".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))"
            txtv_description.textColor = gb.color_phd
        }
        else {
            txtv_description.text = gb.activityData?.description
            txtv_description.textColor = gb.color_darkgrey
        }
        
        if (gb.activityData?.location_lat == "" || gb.activityData?.location_lat == nil) && (gb.activityData?.location_long == "" || gb.activityData?.location_long == nil){
            btn_marker.setTitle("add_map".localized(gb.lang_now), for: .normal)
            icon_location.isHidden = true
        }
        else {
            btn_marker.setTitle("edit_map".localized(gb.lang_now), for: .normal)
            icon_location.isHidden = false
        }
        checkSkooped()
        table_contact.reloadData()
        closeLoad()
    }
    
    func setEditData(){
        let data = activityInfo?.data?.first
        gb.activityData?.activity_id = data?.activity_id ?? ""
        gb.activityData?.subject = data?.activity_name ?? ""
        gb.activityData?.start_date = data?.start_date ?? ""
        gb.activityData?.start_time = data?.time_start ?? ""
        gb.activityData?.end_date = data?.end_date ?? ""
        gb.activityData?.end_time = data?.time_end ?? ""
        gb.activityData?.type = data?.type_name ?? ""
        gb.activityData?.project = data?.project_name ?? ""
        gb.activityData?.contact = "\(data?.contact_first ?? "") \(data?.contact_last ?? "")"
        gb.activityData?.account = data?.account_en ?? ""
        gb.activityData?.status = data?.status_name ?? ""
        gb.activityData?.priority = data?.priority_name ?? ""
        gb.activityData?.cost = data?.cost ?? ""
        gb.activityData?.location = data?.location ?? ""
        gb.activityData?.location_lat = data?.location_lat ?? ""
        gb.activityData?.location_long = data?.location_lng ?? ""
        gb.activityData?.emp_id = data?.emp_id ?? ""
        gb.activityData?.comp_id = data?.comp_id ?? ""
        gb.activityData?.type_id = data?.type_id ?? ""
        gb.activityData?.project_id = data?.project_id ?? ""
        gb.activityData?.contact_id = data?.contact_id ?? ""
        gb.activityData?.account_id = data?.account_id ?? ""
        gb.activityData?.place_id = data?.place ?? ""
        gb.activityData?.status_id = data?.status_id ?? ""
        gb.activityData?.priority_id = data?.priority_id ?? ""
        gb.activityData?.skoop_id = data?.skoop_id ?? ""
        gb.activityData?.skoop_description = data?.skoop_detail ?? ""
        gb.activityData?.skoop_location = data?.skoop_location ?? ""
        gb.activityData?.skoop_lat = data?.skoop_lat ?? ""
        gb.activityData?.skoop_lng = data?.skoop_lng ?? ""
        gb.activityData?.skooped = data?.skooped ?? "0"
        gb.activityData?.activity_status = data?.activity_status ?? ""
        gb.activityData?.stamp_in = data?.stamp_in ?? ""
        gb.activityData?.stamp_out = data?.stamp_out ?? ""
        gb.activityData?.is_ticket = data?.is_ticket ?? ""
        
        for item in activityInfo?.other_contact ?? []{
            let newOtherContact = activity_contacts.init(
                contact_id          : item.contact_id ?? "",
                contact_first       : item.contact_first ?? "",
                contact_last        : item.contact_last ?? "",
                contact_image       : item.contact_image ?? "",
                contact_account_en  : item.account_en ?? "",
                contact_account_th  : item.account_th ?? ""
            )
            gb.activityData?.other_contact.append(newOtherContact)
        }
        
        if txtv_description.text.isEmpty {
            txtv_description.text = "\("description".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))"
            txtv_description.textColor = gb.color_phd
            gb.activityData?.description = ""
        }
        else {
            txtv_description.textColor = gb.color_darkgrey
            gb.activityData?.description = data?.activity_description ?? ""
        }
        
        if data?.place == "in" {
            gb.activityData?.place = "in_door".localized(gb.lang_now)
        }
        else if data?.place == "out" {
            gb.activityData?.place = "out_door".localized(gb.lang_now)
        }
        else {
            gb.activityData?.place = ""
        }
        disableField()
        checkSkooped()
    }
    
    func disableField(){
        if gb.activityData?.is_ticket != "" {
            txt_type.isEnabled      = false
            txt_subject.isEnabled   = false
            txt_sdate.isEnabled     = false
            txt_stime.isEnabled     = false
            txt_edate.isEnabled     = false
            txt_etime.isEnabled     = false
            txt_project.isEnabled   = false
            txt_contact.isEnabled   = false
            txt_account.isEnabled   = false
            txt_place.isEnabled     = false
            txt_status.isEnabled    = false
            txt_priority.isEnabled  = false
            txt_cost.isEnabled      = false
            txtv_description.isSelectable = false
            
            txt_type.backgroundColor = gb.color_disable
            txt_subject.backgroundColor = gb.color_disable
            txt_sdate.backgroundColor = gb.color_disable
            txt_edate.backgroundColor = gb.color_disable
            txt_stime.backgroundColor = gb.color_disable
            txt_edate.backgroundColor = gb.color_disable
            txt_etime.backgroundColor = gb.color_disable
            txt_project.backgroundColor = gb.color_disable
            txt_contact.backgroundColor = gb.color_disable
            txt_account.backgroundColor = gb.color_disable
            txt_place.backgroundColor = gb.color_disable
            txt_status.backgroundColor = gb.color_disable
            txt_priority.backgroundColor = gb.color_disable
            txt_cost.backgroundColor = gb.color_disable
            txtv_description.backgroundColor = gb.color_disable
            
            btn_marker.isEnabled = false
            btn_contact.isEnabled = false
            btn_marker.setTitleColor(gb.color_darkgrey, for: .normal)
            btn_contact.setTitleColor(gb.color_darkgrey, for: .normal)
        }
    }
    
    func checkSkooped(){
        if gb.activityData?.activity_status == "close" {
            btn_close.setTitleColor(gb.color_lightgrey, for: .normal)
            btn_close.isEnabled = false
            btn_skoop.setImage(UIImage.fontAwesomeIcon(name: .podcast, style: .solid, textColor: gb.color_skooped, size: CGSize(width: icon_skoop_size, height: icon_skoop_size)), for: .normal)
            btn_skoop.setTitleColor(gb.color_skooped, for: .normal)
            self.navigationItem.rightBarButtonItem = nil
        }
        else {
            if gb.activityData?.skooped == "0" {
                btn_skoop.setTitleColor(gb.color_darkgrey, for: .normal)
                btn_skoop.setImage(UIImage.fontAwesomeIcon(name: .podcast, style: .solid, textColor: gb.color_darkgrey, size: CGSize(width: icon_skoop_size, height: icon_skoop_size)), for: .normal)
                btn_close.setTitleColor(gb.color_lightgrey, for: .normal)
                btn_close.isEnabled = false
            }
            else {
                btn_skoop.setTitleColor(gb.color_skooped, for: .normal)
                btn_skoop.setImage(UIImage.fontAwesomeIcon(name: .podcast, style: .solid, textColor: gb.color_skooped, size: CGSize(width: icon_skoop_size, height: icon_skoop_size)), for: .normal)
                btn_close.setTitleColor(gb.color_greentext, for: .normal)
                btn_close.isEnabled = true
            }
        }
        
    }
    
    func getActivityType(){
        let postString = "comp_id=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_TYPE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityTypes = try JSONDecoder().decode(ActivityTypes.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
//                if self.page_type == "add" {
//                    if self.activityTypes?.data != nil {
//                        let data = self.activityTypes?.data?[0]
//                        self.txt_type.text = data?.type_name
//                        gb.activityData?.type = data?.type_name ?? ""
//                        gb.activityData?.type_id = data?.type_id ?? ""
//                    }
//                    else {
//                        gb.activityData?.type = ""
//                        gb.activityData?.type_id = ""
//                    }
//                }
            }
        }
        task.resume()
    }
    
    func getActivityProject(){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&type=project"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_PROJECT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityProjects = try JSONDecoder().decode(ActivityProjects.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                print(self.activityProjects)
            }
        }
        task.resume()
    }
    
    func getActivityContact(proj_id:String){
        let postString = "project_id=\(String(proj_id))&type=contact"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_PROJECT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityContacts = try JSONDecoder().decode(ActivityContacts.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                
            }
        }
        task.resume()
    }
    
    func getActivityStatus(comp_id:String){
        let postString = "comp_id=\(String(comp_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_STATUS)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activityStatuss = try JSONDecoder().decode(ActivityStatuss.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.page_type == "add" {
                    if self.activityStatuss?.data != nil {
                        let data = self.activityStatuss?.data?[0]
                        self.txt_status.text = data?.status_name
                        gb.activityData?.status = data?.status_name ?? ""
                        gb.activityData?.status_id = data?.status_id ?? ""
                    }
                    else {
                        gb.activityData?.status = ""
                        gb.activityData?.status_id = ""
                    }
                }
            }
        }
        task.resume()
    }
    
    func getActivityPriority(comp_id:String){
        let postString = "comp_id=\(String(comp_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_PRIORITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.activityPrioritys = try JSONDecoder().decode(ActivityPrioritys.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.page_type == "add" {
                    if self.activityPrioritys?.data != nil {
                        let data = self.activityPrioritys?.data?[0]
                        self.txt_priority.text = data?.priority_name
                        gb.activityData?.priority = data?.priority_name ?? ""
                        gb.activityData?.priority_id = data?.priority_id ?? ""
                    }
                    else {
                        gb.activityData?.priority = ""
                        gb.activityData?.priority_id = ""
                    }
                }
            }
        }
        task.resume()
    }
    
    func insertActivity(contact_list:String){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&type_id=\(gb.activityData?.type_id ?? "")&project_id=\(gb.activityData?.project_id ?? "")&account_id=\(gb.activityData?.account_id ?? "")&contact_id=\(gb.activityData?.contact_id ?? "")&status_id=\(gb.activityData?.status_id ?? "")&priority_id=\(gb.activityData?.priority_id ?? "")&place_id=\(gb.activityData?.place_id ?? "")&location=\(gb.activityData?.location ?? "")&location_lat=\(gb.activityData?.location_lat ?? "")&location_long=\(gb.activityData?.location_long ?? "")&activity_name=\(gb.activityData?.subject ?? "")&description=\(gb.activityData?.description ?? "")&start_date=\(gb.activityData?.start_date ?? "")&start_time=\(gb.activityData?.start_time ?? "")&end_date=\(gb.activityData?.end_date ?? "")&end_time=\(gb.activityData?.end_time ?? "")&cost=\(gb.activityData?.cost ?? "")&contact_list=\(contact_list)"
        print(String(postString))
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_ACTIVITY)!
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
                    if self.page_type == "edit"{
                        self.backTwo()
                    }
                    else {
                        self.backOne()
                    }
                }
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: "fail_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func updateActivity(contact_list:String){
        let postString = "activity_id=\(slt_id)&type_id=\(gb.activityData?.type_id ?? "")&project_id=\(gb.activityData?.project_id ?? "")&account_id=\(gb.activityData?.account_id ?? "")&contact_id=\(gb.activityData?.contact_id ?? "")&status_id=\(gb.activityData?.status_id ?? "")&priority_id=\(gb.activityData?.priority_id ?? "")&place_id=\(gb.activityData?.place_id ?? "")&location=\(gb.activityData?.location ?? "")&location_lat=\(gb.activityData?.location_lat ?? "")&location_long=\(gb.activityData?.location_long ?? "")&activity_name=\(gb.activityData?.subject ?? "")&description=\(gb.activityData?.description ?? "")&start_date=\(gb.activityData?.start_date ?? "")&start_time=\(gb.activityData?.start_time ?? "")&end_date=\(gb.activityData?.end_date ?? "")&end_time=\(gb.activityData?.end_time ?? "")&cost=\(gb.activityData?.cost ?? "")&contact_list=\(contact_list)&skoop_detail=\(gb.activityData?.skoop_description ?? "")"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.UPDATE_ACTIVITY)!
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
                    if self.page_type == "edit"{
                        self.backTwo()
                    }
                    else {
                        self.backOne()
                    }
                }
                print(self.standardReturn?.msg ?? "")
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: "fail_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func deleteActivity(activity_id:String){
        let postString = "activity_id=\(activity_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_ACTIVITY)!
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
                let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                let alert = SCLAlertView(appearance: appearance)
                alert.addButton("close".localized(gb.lang_now)) {
                   alert.hideView()
                    if self.page_type == "edit"{
                        self.backTwo()
                    }
                    else {
                        self.backOne()
                    }
                }
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "success_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: "fail_process".localized(gb.lang_now), animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func backOne() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_type && txt_type.text!.isEmpty{
            if activityTypes?.data != nil {
                txt_type.text = activityTypes?.data?[0].type_name
                gb.activityData?.type = activityTypes?.data?[0].type_name ?? ""
                gb.activityData?.type_id = activityTypes?.data?[0].type_id ?? ""
            }
        }
        else if textField == txt_project && txt_project.text!.isEmpty {
            if activityProjects?.data != nil {
                txt_project.text = activityProjects?.data?[0].project_name
                gb.activityData?.project = activityProjects?.data?[0].project_name ?? ""
                gb.activityData?.project_id = activityProjects?.data?[0].project_id ?? ""
            }
        }
        else if textField == txt_contact && txt_contact.text!.isEmpty {
            if activityContacts?.data != nil {
                txt_contact.text = "\(activityContacts?.data?[0].contact_first ?? "") \(activityContacts?.data?[0].contact_last ?? "")"
                txt_account.text = activityContacts?.data?[0].account_en
                gb.activityData?.contact = "\(activityContacts?.data?[0].contact_first ?? "") \(activityContacts?.data?[0].contact_last ?? "")"
                gb.activityData?.contact_id = activityContacts?.data?[0].contact_id ?? ""
                gb.activityData?.account = activityContacts?.data?[0].account_en ?? ""
                gb.activityData?.account_id = activityContacts?.data?[0].account_id ?? ""
                
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_subject {
            gb.activityData?.subject = textField.text ?? ""
        }
        else if textField == txt_sdate {
            gb.activityData?.start_date = date_fmt.string(from: start_date.date)
            gb.activityData?.end_date = date_fmt.string(from: start_date.date)
        }
        else if textField == txt_stime {
            gb.activityData?.start_time = textField.text ?? ""
        }
        else if textField == txt_edate {
            gb.activityData?.end_date = date_fmt.string(from: end_date.date)
        }
        else if textField == txt_etime {
            gb.activityData?.end_time = textField.text ?? ""
        }
        else if textField == txt_type {
            gb.activityData?.type = textField.text ?? ""
        }
        else if textField == txt_project {
            gb.activityData?.project = textField.text ?? ""
        }
        else if textField == txt_contact {
            gb.activityData?.contact = textField.text ?? ""
            gb.activityData?.account = txt_account.text ?? ""
        }
        else if textField == txt_account {
            gb.activityData?.account = textField.text ?? ""
        }
        else if textField == txt_place {
            gb.activityData?.place = textField.text ?? ""
        }
        else if textField == txt_status {
            gb.activityData?.status = textField.text ?? ""
        }
        else if textField == txt_priority {
            gb.activityData?.priority = textField.text ?? ""
        }
        else if textField == txt_cost {
            gb.activityData?.cost = textField.text ?? ""
        }
        setDataLayout()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == gb.color_phd {
            textView.text = nil
            textView.textColor = gb.color_darkgrey
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "\("description".localized(gb.lang_now)) \("require_field".localized(gb.lang_now))"
            textView.textColor = gb.color_phd
            gb.activityData?.description = ""
        }
        else {
            gb.activityData?.description = textView.text ?? ""
        }
        setDataLayout()
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txt_sdate.isFirstResponder{
//            txt_sdate.text = date_fmt.string(from: start_date.date)
//            txt_edate.text = date_fmt.string(from: start_date.date)
        }
        else if txt_edate.isFirstResponder{
//            txt_edate.text = date_fmt.string(from: end_date.date)
        }
        else if txt_stime.isFirstResponder{
            txt_stime.text = time_fmt.string(from: start_time.date)
        }
        else if txt_etime.isFirstResponder{
            txt_etime.text = time_fmt.string(from: end_time.date)
        }
        else if txtv_description.isFirstResponder{
            txtv_description.resignFirstResponder()
        }
        hideKeyboard()
    }
    
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        let contact_list = genOtherContact()
        if page_type == "add" {
            if validateRequire() {
                insertActivity(contact_list:contact_list)
            }
        }
        else {
            updateActivity(contact_list:contact_list)
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        hideKeyboard()
    }
    
    @IBAction func done_submit(_ sender: Any) {
//        let contact_list = genOtherContact()
//        if page_type == "add" {
//            if validateRequire() {
//                insertActivity(contact_list:contact_list)
//            }
//        }
//        else {
//            updateActivity(contact_list:contact_list)
//        }
    }
    
    func confirmDelete(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
        
        let option1 = UIAlertAction(title: "confirm_delete".localized(gb.lang_now), style: .destructive) { action in
            self.deleteActivity(activity_id: self.slt_id)
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func tapDeleteActivity(_ sender: Any) {
        confirmDelete()
    }
    
    func validateRequire()->Bool{
        var complete = true
        if gb.activityData?.subject == "" || gb.activityData?.subject == nil {
            alertWarning(sub: "subject_required".localized(gb.lang_now))
            complete = false
        }
        else if gb.activityData?.description == "" || gb.activityData?.description == nil {
            alertWarning(sub: "description_required".localized(gb.lang_now))
            complete = false
        }
        else if gb.activityData?.type_id == "" || gb.activityData?.type_id == nil {
            alertWarning(sub: "type_required".localized(gb.lang_now))
            complete = false
        }
        else if gb.activityData?.project_id == "" || gb.activityData?.project_id == nil {
            alertWarning(sub: "project_required".localized(gb.lang_now))
            complete = false
        }
        else if gb.activityData?.contact_id == "" || gb.activityData?.contact_id == nil {
            alertWarning(sub: "contact_required".localized(gb.lang_now))
            complete = false
        }
        return complete
    }
    
    func alertWarning(sub : String){
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("close".localized(gb.lang_now)) {
           alert.hideView()
        }
        alert.showWarning("warning".localized(gb.lang_now), subTitle: sub, animationStyle: .noAnimation)
    }
    
    func genOtherContact() -> String{
        var contact_list = ""
        if (gb.activityData?.other_contact.count)! > 0{
            for item in gb.activityData!.other_contact {
                contact_list = "\(contact_list),\(item.contact_id)"
            }
            contact_list.remove(at: contact_list.startIndex)
        }
        return contact_list
    }
    
    func hideKeyboard(){
        for txt_item in textfieldList {
            if txt_item.isFirstResponder{
                txt_item.resignFirstResponder()
            }
        }
        if txtv_description.isFirstResponder{
            txtv_description.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = gb.activityData?.other_contact.count
        if row == nil {row = 0}
        if row! >= 3 {
            table_height_const.constant = 210
        }
        else if row! >= 2 {
            table_height_const.constant = 140
        }
        else if row! >= 1 {
            table_height_const.constant = 70
        }
        else if row! == 0 {
            table_height_const.constant = 0
        }
        view_scroll_height.constant = scroll_now - (210 - table_height_const.constant)
        view.layoutIfNeeded()
        
        return row!
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityContact2_TVC
        cell.selectionStyle = .none
        cell.image_contact.image = loadImageContact(image_str: gb.activityData?.other_contact[indexPath.row].contact_image ?? "")
        cell.label_contact.text = "\(gb.activityData?.other_contact[indexPath.row].contact_first ?? "") \(gb.activityData?.other_contact[indexPath.row].contact_last ?? "")"
        cell.label_comp.text = gb.activityData?.other_contact[indexPath.row].contact_account_en
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            gb.activityData?.other_contact.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pkv_type {
            return activityTypes?.data?.count ?? 0
        }
        else if pickerView == pkv_project {
            return activityProjects?.data?.count ?? 0
        }
        else if pickerView == pkv_contact {
            return activityContacts?.data?.count ?? 0
        }
        else if pickerView == pkv_place {
            return place_list.count
        }
        else if pickerView == pkv_status {
            return activityStatuss?.data?.count ?? 0
        }
        else if pickerView == pkv_priority {
            return activityPrioritys?.data?.count ?? 0
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pkv_type {
            return  activityTypes?.data?[row].type_name
        }
        else if pickerView == pkv_project {
            let str = activityProjects?.data?[row].project_name?.replacingOccurrences(of: "&amp;", with: "&")
            return str
        }
        else if pickerView == pkv_contact {
            return "\(activityContacts?.data?[row].contact_first ?? "") \(activityContacts?.data?[row].contact_last ?? "")"
        }
        else if pickerView == pkv_place {
            return place_list[row]
        }
        else if pickerView == pkv_status {
            return activityStatuss?.data?[row].status_name
        }
        else if pickerView == pkv_priority {
            return activityPrioritys?.data?[row].priority_name
        }
        else {
            return "..."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pkv_type {
            txt_type.text = activityTypes?.data?[row].type_name
            gb.activityData?.type_id = activityTypes?.data?[row].type_id ?? ""
        }
        else if pickerView == pkv_project {
            txt_project.text = activityProjects?.data?[row].project_name?.replacingOccurrences(of: "&amp;", with: "&")
            gb.activityData?.project_id = activityProjects?.data?[row].project_id ?? ""
            if activityProjects != nil {
                getActivityContact(proj_id:(activityProjects?.data?[row].project_id) ?? "")
            }
            txt_contact.text = ""
            txt_account.text = ""
            gb.activityData?.contact = ""
            gb.activityData?.contact_id = ""
            gb.activityData?.account = ""
            gb.activityData?.account_id = ""
        }
        else if pickerView == pkv_contact {
            txt_contact.text = "\(activityContacts?.data?[row].contact_first ?? "") \(activityContacts?.data?[row].contact_last ?? "")"
            txt_account.text = activityContacts?.data?[row].account_en
            gb.activityData?.contact = "\(activityContacts?.data?[row].contact_first ?? "") \(activityContacts?.data?[row].contact_last ?? "")"
            gb.activityData?.contact_id = activityContacts?.data?[row].contact_id ?? ""
            gb.activityData?.account = activityContacts?.data?[row].account_en ?? ""
            gb.activityData?.account_id = activityContacts?.data?[row].account_id ?? ""
        }
        else if pickerView == pkv_place {
            txt_place.text = place_list[row]
            if row == 0 {
                gb.activityData?.place_id = "in"
            }
            else {
                gb.activityData?.place_id = "out"
            }
        }
        else if pickerView == pkv_status {
            txt_status.text = activityStatuss?.data?[row].status_name
            gb.activityData?.status_id = activityStatuss?.data?[row].status_id ?? ""
        }
        else if pickerView == pkv_priority {
            txt_priority.text = activityPrioritys?.data?[row].priority_name
            gb.activityData?.priority_id = activityPrioritys?.data?[row].priority_id ?? ""
        }
        else {
            txt_type.text = "..."
        }
    }
    
    func setTextField(txt_field : UITextField) {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: txt_field.frame.height - 1.5, width: txt_field.frame.width, height: 1.5)
//        bottomLine.backgroundColor = UIColor.lightGray.cgColor
//        txt_field.borderStyle = UITextField.BorderStyle.none
//        txt_field.textColor = gb.color_darkgrey
//        txt_field.layer.addSublayer(bottomLine)
//        txt_field.tintColor = UIColor.systemOrange
        txt_field.borderStyle = .none
        txt_field.layer.cornerRadius = 22.5
        txt_field.layer.borderWidth = 1.0
        txt_field.layer.borderColor = UIColor.lightGray.cgColor
        txt_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt_field.frame.height))
        txt_field.leftViewMode = .always
    }
    
    func setLabel(label : UILabel) {
        let index = labelList.firstIndex(of: label)
        label.text = labelTextList[index!]
        label.textColor = gb.color_lightgrey
    }
    
    func setPlaceHolder(txt_field : UITextField) {
        let index = textfieldList.firstIndex(of: txt_field)
        txt_field.placeholder = placeholderList[index!]
    }
    
    func setKeyborad(txt_field : UITextField){
        txt_field.inputAccessoryView = toolBar
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_add" {
            let sg = segue.destination as? SelectLocation_VC
            sg!.page_type = "from_add"
        }
    }
}
