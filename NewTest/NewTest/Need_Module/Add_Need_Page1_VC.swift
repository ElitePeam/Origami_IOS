//
//  Add_Need_Page1_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 15/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView
import NVActivityIndicatorView

class Add_Need_Page1_VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var datepicker_need: UITextField!
    @IBOutlet weak var textfield_topic: UITextField!
    @IBOutlet weak var textfield_reason: UITextField!
    @IBOutlet weak var button_next: UIButton!
    @IBOutlet weak var button_mockup: UIButton!
    @IBOutlet weak var view_form: UIView!
    @IBOutlet weak var picker_type: UITextField!
    @IBOutlet weak var picker_project: UITextField!
    @IBOutlet weak var picker_depart: UITextField!
    @IBOutlet weak var picker_type_rq: UITextField!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_doc_type: UILabel!
    @IBOutlet weak var label_project: UILabel!
    @IBOutlet weak var label_department: UILabel!
    @IBOutlet weak var label_subject: UILabel!
    @IBOutlet weak var label_reason: UILabel!
    
    var user:UserLoginDao? = nil
    var needItems:NeedItems? = nil
    var needItems_Project:NeedItems_Project? = nil
    var needItems_Type:NeedItems_Type? = nil
    var needItems_Depart:NeedItems_Depart? = nil
    var sended_data:NeedList? = nil
    var datePicker = UIDatePicker()
    var array_project : [String] = []
    var array_type : [String] = []
    var array_depart : [String] = []
    var array_project_id : [String] = []
    var array_type_id : [String] = []
    var array_depart_id : [String] = []
    var array_typerq_id : [String] = ["EP","PR"]
    var array_typerq_name : [String] = ["Expense","Puchasing Request"]
    var project_id = ""
    var type_id = ""
    var dept_id = ""
    var typerq_id = ""
    var check_date = false
    var check_type = false
    var check_project = false
    var check_depart = false
    var check_topic = false
    var check_reason = false
    var check_typerq = false
    var sended_type = "add"
    var selected_type = ""
    var selected_project = ""
    var selected_depart = ""
    var selected_typerq = ""
    let pickerView_type = UIPickerView()
    let pickerView_project = UIPickerView()
    let pickerView_department = UIPickerView()
    let pickerView_typerq = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "need_detail".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        view_form.backgroundColor = gb.color_background
        getNeedItems()
        user = gb.user
        
        label_date.text = "date".localized(gb.lang_now)
        label_type.text = "type".localized(gb.lang_now)
        label_doc_type.text = "doc_type".localized(gb.lang_now)
        label_project.text = "project".localized(gb.lang_now)
        label_department.text = "department".localized(gb.lang_now)
        label_subject.text = "subject".localized(gb.lang_now)
        label_reason.text = "reason".localized(gb.lang_now)
        button_next.setTitle("next".localized(gb.lang_now), for: .normal)
        
        textfield_topic.placeholder = "subject".localized(gb.lang_now)
        textfield_reason.placeholder = "reason".localized(gb.lang_now)
        picker_type_rq.placeholder = "type".localized(gb.lang_now)
        picker_project.placeholder = "project".localized(gb.lang_now)
        picker_depart.placeholder = "department".localized(gb.lang_now)
        picker_type.placeholder = "doc_type".localized(gb.lang_now)
        
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = UIColor.white
        let cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        cancelButton.tintColor = UIColor.systemOrange
        doneButton.tintColor = UIColor.systemOrange
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        datepicker_need.inputAccessoryView = toolBar
        datepicker_need.inputView = datePicker
        
        let date_formatter = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy"
        datepicker_need.text = date_formatter.string(from: datePicker.date)
        check_date = true
        
        textfield_topic.addTarget(self, action: #selector(Add_Need_Page1_VC.topicDidChange(_:)),
        for: .editingChanged)
    
        pickerView_type.delegate = self
        pickerView_project.delegate = self
        pickerView_department.delegate = self
        pickerView_typerq.delegate = self
        picker_type.inputView = pickerView_type
        picker_project.inputView = pickerView_project
        picker_depart.inputView = pickerView_department
        picker_type_rq.inputView = pickerView_typerq
        picker_type.inputAccessoryView = toolBar
        picker_project.inputAccessoryView = toolBar
        picker_depart.inputAccessoryView = toolBar
        picker_type_rq.inputAccessoryView = toolBar
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if textfield_reason.isFirstResponder {
                if textfield_reason.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if textfield_topic.isFirstResponder {
                if textfield_topic.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if picker_depart.isFirstResponder {
                if picker_depart.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if picker_project.isFirstResponder {
                if picker_project.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
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
    
    func getNeedItems(){
        let postString = "idComp=\(String((gb.user?.comp_id)!))&idEmp=\(String((gb.user?.emp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_ITEMS)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.needItems = try JSONDecoder().decode(NeedItems.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if (self.needItems?.project_list != nil ) {
                        for item in (self.needItems?.project_list)! {
                            self.array_project.append(item.project_name!)
                            self.array_project_id.append(item.project_id!)
                        }
                    }
                    
                    if (self.needItems?.type_need != nil ) {
                        for item in (self.needItems?.type_need)! {
                            self.array_type.append(item.mny_request_generate_name!)
                            self.array_type_id.append(item.mny_request_generate_code!)
                        }
                    }
                    
                    if (self.needItems?.dept_list != nil ) {
                        for item in (self.needItems?.dept_list)! {
                            self.array_depart.append(item.dept_description!)
                            self.array_depart_id.append(item.dept_id!)
                            
                            if self.user?.dept_id == item.dept_id {
                                self.selected_depart = item.dept_description!
                                self.dept_id = item.dept_id!
                                self.picker_depart.text = self.selected_depart
                                self.check_depart = true
                            }
                        }
                    }
                    
                    if self.sended_type == "edit" {
                        self.datepicker_need.text = self.sended_data?.date
                        self.textfield_topic.text = self.sended_data?.subject
                        self.textfield_reason.text = self.sended_data?.mny_request_note

                        self.picker_type_rq.text = self.sended_data?.type
                        self.picker_project.text = self.sended_data?.project_id
                        self.picker_depart.text = self.sended_data?.mny_for_team_id
                        
                        self.project_id = self.sended_data!.project_id!
                        self.dept_id = self.sended_data!.mny_for_team_id!
                        self.type_id = self.sended_data!.type_id!
                        self.typerq_id = self.sended_data!.mny_request_type_id!
                        
                        for ty in (self.needItems?.type_need)! {
                            if ty.mny_request_generate_code == self.type_id {
                                self.picker_type.text = ty.mny_request_generate_name
                                break
                            }
                        }
                        
                        for proj in (self.needItems?.project_list)! {
                            if self.project_id == "0"{
                                self.picker_project.text = "no_project".localized(gb.lang_now)
                                break
                            }
                            else if proj.project_id == self.project_id {
                                self.picker_project.text = proj.project_name
                                break
                            }
                        }
                        
                        for dept in (self.needItems?.dept_list)! {
                            if dept.dept_id == self.dept_id {
                                self.picker_depart.text = dept.dept_description
                                break
                            }
                        }
                        
                        self.check_date = true
                        self.check_type = true
                        self.check_project = true
                        self.check_depart = true
                        self.check_topic = true
                        self.check_reason = true
                        self.check_typerq = true
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func tapNext(_ sender: Any) {
        showLoad()
        if !check_date {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_date".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !check_typerq {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_typerq".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !check_type {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !check_project {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_project".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !check_depart {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_depart".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !check_topic {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_need_subject".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else{
            button_mockup.sendActions(for: .touchUpInside)
        }
        closeLoad()
    }
    
    @objc func topicDidChange(_ textField: UITextField) {
        if textfield_topic.text != "" {
            check_topic = true
        }
        else{
            check_topic = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sb = segue.destination as! Add_Need_Page2_VC
        sb.need_date = datepicker_need.text
        sb.need_topic = textfield_topic.text
        sb.need_reason = textfield_reason.text
        sb.project_id = project_id
        sb.type_id = type_id
        sb.dept_id = dept_id
        sb.typerq_id = typerq_id
        sb.sended_type = sended_type
        sb.sended_data = sended_data
    }
    
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        let date_formatter = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy"
        if datepicker_need.isFirstResponder{
            datepicker_need.text = date_formatter.string(from: datePicker.date)
            datepicker_need.resignFirstResponder()
            check_date = true
        }
        else if picker_type.isFirstResponder{
            if selected_type == "" {
                selected_type = array_type[0]
                type_id = array_type_id[0]
            }
            picker_type.text = selected_type
            picker_type.resignFirstResponder()
            check_type = true
        }
        else if picker_project.isFirstResponder{
            if selected_project == "" {
                selected_project = array_project[0]
                project_id = array_project_id[0]
            }
            picker_project.text = selected_project
            picker_project.resignFirstResponder()
            check_project = true
        }
        else if picker_type_rq.isFirstResponder{
            if selected_typerq == "" {
                selected_typerq = array_typerq_name[0]
                typerq_id = array_typerq_id[0]
            }
            picker_type_rq.text = selected_typerq
            picker_type_rq.resignFirstResponder()
            check_typerq = true
        }
        else {
            if selected_depart == "" {
                selected_depart = array_depart[0]
                dept_id = array_depart_id[0]
            }
            picker_depart.text = selected_depart
            picker_depart.resignFirstResponder()
            check_depart = true
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if datepicker_need.isFirstResponder{
            datepicker_need.resignFirstResponder()
        }
        else if picker_type.isFirstResponder{
            picker_type.resignFirstResponder()
        }
        else if picker_type_rq.isFirstResponder{
            picker_type_rq.resignFirstResponder()
        }
        else if picker_project.isFirstResponder{
            picker_project.resignFirstResponder()
        }
        else {
            picker_depart.resignFirstResponder()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        else if pickerView == pickerView_project {
            return array_project.count
        }
        else if pickerView == pickerView_typerq {
            return array_typerq_name.count
        }
        else {
            return array_depart.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView_type {
            return array_type[row]
        }
        else if pickerView == pickerView_project {
            return array_project[row]
        }
        else if pickerView == pickerView_typerq {
            return array_typerq_name[row]
        }
        else {
            return array_depart[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView_type {
            selected_type = array_type[row]
            type_id = array_type_id[row]
        }
        else if pickerView == pickerView_project {
            selected_project = array_project[row]
            project_id = array_project_id[row]
        }
        else if pickerView == pickerView_typerq {
            selected_typerq = array_typerq_name[row]
            typerq_id = array_typerq_id[row]
        }
        else {
            selected_depart = array_depart[row]
            dept_id = array_depart_id[row]
        }
    }
}
