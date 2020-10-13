//
//  CloseActivity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SCLAlertView

class CloseActivity_VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var txt_sdate: UITextField!
    @IBOutlet weak var txt_stime: UITextField!
    @IBOutlet weak var txt_edate: UITextField!
    @IBOutlet weak var txt_etime: UITextField!
    @IBOutlet weak var btn_skoop: UIButton!
    @IBOutlet weak var view_seperate1: UIView!
    @IBOutlet weak var view_seperate2: UIView!
    @IBOutlet weak var label_sdate: UILabel!
    @IBOutlet weak var label_stime: UILabel!
    @IBOutlet weak var label_edate: UILabel!
    @IBOutlet weak var label_etime: UILabel!
    
    var standardReturn:StandardReturn? = nil
    var textfieldList:[UITextField] = []
    var placeholderList:[String] = []
    var toolBar : UIToolbar = UIToolbar()
    var doneButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    let date_fmt = DateFormatter()
    let date2_fmt = DateFormatter()
    let time_fmt = DateFormatter()
    var start_date = UIDatePicker()
    var end_date = UIDatePicker()
    var start_time = UIDatePicker()
    var end_time = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        initVariable()
        initLayout()
        initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        for txt_item in textfieldList {
            setTextField(txt_field: txt_item)
            setPlaceHolder(txt_field: txt_item)
            setKeyborad(txt_field: txt_item)
        }
        closeLoad()
    }
    
    func initData(){
        if gb.activityData?.stamp_in == "" {
            gb.activityData?.close_start_date = gb.activityData?.start_date ?? ""
            gb.activityData?.close_start_time = gb.activityData?.start_time ?? ""
        }
        else {
            let datetime = gb.activityData?.stamp_in.components(separatedBy: " ")
            var date = datetime?[0]
            let time = datetime?[1]
            date = convertDateTime(date: date ?? "00/00/0000",from_fmt: "dd/MM/yyyy",to_fmt: "yyyy-MM-dd")
            gb.activityData?.close_start_date = date ?? ""
            gb.activityData?.close_start_time = time ?? ""
        }
        
        if gb.activityData?.stamp_out == "" {
            gb.activityData?.close_end_date = gb.activityData?.end_date ?? ""
            gb.activityData?.close_end_time = gb.activityData?.end_time ?? ""
        }
        else {
            let datetime = gb.activityData?.stamp_out.components(separatedBy: " ")
            var date = datetime?[0]
            let time = datetime?[1]
            date = convertDateTime(date: date ?? "00/00/0000",from_fmt: "dd/MM/yyyy",to_fmt: "yyyy-MM-dd")
            gb.activityData?.close_end_date = date ?? ""
            gb.activityData?.close_end_time = time ?? ""
        }
        txt_sdate.text = convertDateTime(date: gb.activityData?.close_start_date ?? "0000/00/00",from_fmt: "yyyy-MM-dd",to_fmt: "dd/MM/yyyy")
        txt_edate.text = convertDateTime(date: gb.activityData?.close_end_date ?? "0000/00/00",from_fmt: "yyyy-MM-dd",to_fmt: "dd/MM/yyyy")
        txt_stime.text = gb.activityData?.close_start_time
        txt_etime.text = gb.activityData?.close_end_time
    }
    
    func initLayout(){
        self.title = "close_activity".localized(gb.lang_now)
        let done_save = UIBarButtonItem(title: "done".localized(gb.lang_now), style: .done, target: self, action: #selector(doneSave))
        self.navigationItem.rightBarButtonItem  = done_save
        view_seperate1.backgroundColor = gb.color_seperate
        view_seperate2.backgroundColor = gb.color_seperate
        btn_skoop.setTitleColor(gb.color_darkgrey, for: .normal)
        
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
        
        let loc = Locale(identifier: "us")
        start_date.locale = loc
        end_date.locale = loc
        start_time.locale = loc
        end_time.locale = loc
        start_date.datePickerMode = UIDatePicker.Mode.date
        end_date.datePickerMode = UIDatePicker.Mode.date
        start_time.datePickerMode = UIDatePicker.Mode.time
        end_time.datePickerMode = UIDatePicker.Mode.time
        date_fmt.locale = Locale(identifier: "en_US_POSIX")
        date_fmt.dateFormat = "yyyy-MM-dd"
        date2_fmt.locale = Locale(identifier: "en_US_POSIX")
        date2_fmt.dateFormat = "dd/MM/yyyy"
        time_fmt.locale = Locale(identifier: "en_US_POSIX")
        time_fmt.dateFormat = "HH:mm"
        txt_sdate.inputView = start_date
        txt_edate.inputView = end_date
        txt_stime.inputView = start_time
        txt_etime.inputView = end_time
        label_sdate.text = "start_date".localized(gb.lang_now)
        label_stime.text = "start_time".localized(gb.lang_now)
        label_edate.text = "end_date".localized(gb.lang_now)
        label_etime.text = "end_time".localized(gb.lang_now)
        label_sdate.textColor = gb.color_lightgrey
        label_stime.textColor = gb.color_lightgrey
        label_edate.textColor = gb.color_lightgrey
        label_etime.textColor = gb.color_lightgrey
    }
    
    @objc func doneSave(sender:UIBarButtonItem!) {
        closeActivity()
    }
    
    func initVariable(){
        textfieldList = [txt_sdate,txt_stime,txt_edate,txt_etime]
        placeholderList = ["Start date","Start time","End date","End time"]
    }
    
    func closeActivity(){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&activity_id=\(gb.activityData?.activity_id ?? "")&start_date=\(gb.activityData?.close_start_date ?? "")&start_time=\(gb.activityData?.close_start_time ?? "")&end_date=\(gb.activityData?.close_end_date ?? "")&end_time=\(gb.activityData?.close_end_time ?? "")"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_CLOSE_ACTIVITY)!
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
                    if self.standardReturn?.status == "0" {
                        self.backThree()
                    }
                }
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: self.standardReturn?.msg!.localized(gb.lang_now) ?? "", animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: self.standardReturn?.msg!.localized(gb.lang_now) ?? "", animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func convertDateTime(date:String, from_fmt:String, to_fmt:String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = from_fmt
        date_formatter2.dateFormat = to_fmt
        if let to_date = date_formatter.date(from: date) {
            let to_string = date_formatter2.string(from: to_date)
            return to_string
        }
        else {
            return "0000-00-00"
        }
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    func backThree() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_sdate {
            gb.activityData?.close_start_date = textField.text ?? ""
        }
        else if textField == txt_edate {
            gb.activityData?.close_end_date = textField.text ?? ""
        }
        else if textField == txt_stime {
            gb.activityData?.close_start_time = textField.text ?? ""
        }
        else if textField == txt_etime {
            gb.activityData?.close_end_time = textField.text ?? ""
        }
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txt_sdate.isFirstResponder{
            txt_sdate.text = date2_fmt.string(from: start_date.date)
            gb.activityData?.close_start_date = date_fmt.string(from: start_date.date)
        }
        else if txt_edate.isFirstResponder{
            txt_edate.text = date2_fmt.string(from: end_date.date)
            gb.activityData?.close_end_date = date_fmt.string(from: end_date.date)
        }
        else if txt_stime.isFirstResponder{
            txt_stime.text = time_fmt.string(from: start_time.date)
            gb.activityData?.close_start_time = date_fmt.string(from: start_time.date)
        }
        else if txt_etime.isFirstResponder{
            txt_etime.text = time_fmt.string(from: end_time.date)
            gb.activityData?.close_end_time = date_fmt.string(from: end_time.date)
        }
        hideKeyboard()
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        hideKeyboard()
    }
    
    @IBAction func tapCloseActivity(_ sender: Any) {
//        closeActivity()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    func setTextField(txt_field : UITextField) {
//            let bottomLine = CALayer()
//            bottomLine.frame = CGRect(x: 0.0, y: txt_field.frame.height - 1.5, width: txt_field.frame.width, height: 1.5)
//            bottomLine.backgroundColor = UIColor.lightGray.cgColor
//            txt_field.borderStyle = UITextField.BorderStyle.none
//            txt_field.textColor = UIColor.darkGray
//            txt_field.layer.addSublayer(bottomLine)
//            txt_field.tintColor = UIColor.systemOrange
        txt_field.borderStyle = .none
        txt_field.layer.cornerRadius = 22.5
        txt_field.layer.borderWidth = 1.0
        txt_field.layer.borderColor = UIColor.lightGray.cgColor
        txt_field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt_field.frame.height))
        txt_field.leftViewMode = .always
    }
        
    func setPlaceHolder(txt_field : UITextField) {
        let index = textfieldList.firstIndex(of: txt_field)
        txt_field.placeholder = placeholderList[index!]
    }
    
    func hideKeyboard(){
        for txt_item in textfieldList {
            if txt_item.isFirstResponder{
                txt_item.resignFirstResponder()
            }
        }
    }
    
    func setKeyborad(txt_field : UITextField){
        txt_field.delegate = self
        txt_field.inputAccessoryView = toolBar
    }
    
}
