//
//  Request_ot_add_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 20/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SCLAlertView
import NVActivityIndicatorView

class Request_ot_add_VC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textfield_name: UITextField!
    @IBOutlet weak var textfield_start: UITextField!
    @IBOutlet weak var textfield_end: UITextField!
    @IBOutlet weak var textview_reason: UITextView!
    @IBOutlet weak var apply_button: UIButton!
    @IBOutlet weak var delete_button: UIBarButtonItem!
    @IBOutlet weak var view_content: UIView!
    @IBOutlet weak var txt_name: UILabel!
    @IBOutlet weak var txt_start: UILabel!
    @IBOutlet weak var txt_end: UILabel!
    @IBOutlet weak var txt_reason: UILabel!
    
    
    var startPicker = UIDatePicker()
    var endPicker = UIDatePicker()
    var selected_emp:selectedEmp? = nil
    var requestOTList:RequestOTList? = nil
    var basicReturn:BasicReturn? = nil
    var send_type  = ""
    var chk_start  = false
    var chk_end    = false
    var chk_reason = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "request_ot_datail".localized(gb.lang_now)
        txt_name.text = "name".localized(gb.lang_now)
        txt_start.text = "start_request_ot".localized(gb.lang_now)
        txt_end.text = "end_request_ot".localized(gb.lang_now)
        txt_reason.text = "reason".localized(gb.lang_now)
        textfield_name.placeholder = "name".localized(gb.lang_now)
        textfield_start.placeholder = "start_request_ot".localized(gb.lang_now)
        textfield_end.placeholder = "end_request_ot".localized(gb.lang_now)
        
        textview_reason.delegate = self
        view.backgroundColor = gb.color_background
        view_content.layer.cornerRadius = 8
        view_content.layer.shadowColor = UIColor.lightGray.cgColor
        view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_content.layer.shadowRadius = 1.0
        view_content.layer.shadowOpacity = 1
        view_content.layer.masksToBounds = false
        
        textview_reason.layer.cornerRadius = 5
        textview_reason.layer.borderWidth = 1
        textview_reason.layer.borderColor = gb.color_border.cgColor
        let loc = Locale(identifier: "us")
        startPicker.locale = loc
        endPicker.locale = loc
        
        startPicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        endPicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
       toolBar.barStyle = UIBarStyle.default
       let cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
       cancelButton.tintColor = UIColor.systemOrange
       doneButton.tintColor = UIColor.systemOrange
       toolBar.items = [cancelButton, flexibleSpace, doneButton]
       textfield_start.inputAccessoryView = toolBar
       textfield_start.inputView = startPicker
       textfield_end.inputAccessoryView = toolBar
       textfield_end.inputView = endPicker
        
        textfield_name.text = "\(String(selected_emp!.f_name)) \(String(selected_emp!.l_name))"
        if send_type == "add" {
            navigationItem.rightBarButtonItem = nil
            textview_reason.text = "reason".localized(gb.lang_now)
            textview_reason.textColor = UIColor.lightGray
            apply_button.setTitle("add".localized(gb.lang_now), for: .normal)
        }
        else {
            chk_start = true
            chk_end = true
            chk_reason = true
            apply_button.setTitle("update".localized(gb.lang_now), for: .normal)
            let date_formatter = DateFormatter()
            let date_formatter2 = DateFormatter()
            date_formatter.locale = Locale(identifier: "en_US_POSIX")
            date_formatter2.locale = Locale(identifier: "en_US_POSIX")
            date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date_formatter2.dateFormat = "yyyy-MM-dd HH:mm"
            let start_d = date_formatter.date(from: requestOTList!.request_ot_in!)
            let end_d   = date_formatter.date(from: requestOTList!.request_ot_out!)
            let start_s = date_formatter2.string(from: start_d!)
            let end_s = date_formatter2.string(from: end_d!)
                        
            startPicker.date = start_d!
            endPicker.date = end_d!
            textfield_start.text = start_s
            textfield_end.text = end_s
            textview_reason.text = requestOTList?.ot_reason
        }
        
        textview_reason.autocorrectionType = .no
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func insertRequestOT(start : String, end : String, reason : String){
        showLoad()
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(String(selected_emp!.emp_id))&comp_id=\(String(selected_emp!.comp_id))&start=\(String(start))&end=\(String(end))&ot_reason=\(String(reason))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_REQUEST_OT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.basicReturn = try JSONDecoder().decode(BasicReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{
                    self.closeLoad()
                    let return_status = self.basicReturn?.status
                    let return_msg = self.basicReturn?.msg
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false, shouldAutoDismiss: false
                    )
                    let alert = SCLAlertView(appearance: appearance)
                    if return_status == 0 {
                        alert.addButton("OK") {
                            alert.hideView()
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        alert.showSuccess("success".localized(gb.lang_now), subTitle: "add_rq_ot_success".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                    else {
                        alert.addButton("close".localized(gb.lang_now)) {
                            alert.hideView()
                        }
                        alert.showError("fail".localized(gb.lang_now), subTitle: "add_rq_ot_fail".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                }
            }
        }
        task.resume()
    }
    
    func updateRequestOT(start : String, end : String, reason : String, request_id : String, request_no : String){
        showLoad()
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(String(selected_emp!.emp_id))&comp_id=\(String(selected_emp!.comp_id))&start=\(String(start))&end=\(String(end))&ot_reason=\(String(reason))&id_request_ot=\(String(request_id))&request_run_no=\(String(request_no))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_REQUEST_OT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.basicReturn = try JSONDecoder().decode(BasicReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{
                    self.closeLoad()
                    let return_status = self.basicReturn?.status
                    let return_msg = self.basicReturn?.msg
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false, shouldAutoDismiss: false
                    )
                    let alert = SCLAlertView(appearance: appearance)
                    if return_status == 0 {
                        alert.addButton("OK") {
                            alert.hideView()
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        alert.showSuccess("success".localized(gb.lang_now), subTitle: "update_rq_ot_success".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                    else {
                        alert.addButton("close".localized(gb.lang_now)) {
                            alert.hideView()
                        }
                        alert.showError("fail".localized(gb.lang_now), subTitle: "update_rq_ot_fail".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                }
            }
        }
        task.resume()
    }
    
    func deleteRequestOT(){
        showLoad()
        let postString = "user=\(gb.username)&pass=\(gb.password)&id_request_ot=\(String(requestOTList!.id_request_ot!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_REQUEST_OT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.basicReturn = try JSONDecoder().decode(BasicReturn.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }

            DispatchQueue.main.async {
                do{
                    self.closeLoad()
                    let return_status = self.basicReturn?.status
                    let return_msg = self.basicReturn?.msg
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false, shouldAutoDismiss: false
                    )
                    let alert = SCLAlertView(appearance: appearance)
                    if return_status == 0 {
                        alert.addButton("ok".localized(gb.lang_now)) {
                            alert.hideView()
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        alert.showSuccess("success".localized(gb.lang_now), subTitle: "delete_rq_ot_success".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                    else {
                        alert.addButton("close".localized(gb.lang_now)) {
                            alert.hideView()
                        }
                        alert.showError("fail".localized(gb.lang_now), subTitle: "delete_rq_ot_fail".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                }
            }
        }
        task.resume()
    }
    
    func DateStringForSend(datetime : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm"
        date_formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let to_date = date_formatter.date(from: datetime)!
        let to_string = date_formatter2.string(from: to_date)
        return to_string
    }
    
    @IBAction func tap_apply(_ sender: Any) {
        if !chk_start {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_start_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !chk_end {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "select_end_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else if !chk_reason {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "insert_rq_reason".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
        }
        else {
            let date_start = DateStringForSend(datetime: textfield_start.text!)
            let date_end = DateStringForSend(datetime: textfield_end.text!)
            if compareDate(start: date_start, end: date_end) {
                if send_type == "add" {
                    insertRequestOT(start: date_start, end: date_end, reason : textview_reason.text!)
                }
                else {
                    updateRequestOT(start : date_start, end : date_end, reason : textview_reason.text!, request_id : requestOTList!.id_request_ot!, request_no : requestOTList!.request_run_no!)
                }
            }
            else {
                SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "wrong_time_format".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            }
        }
    }
    
    @IBAction func tap_delete(_ sender: Any) {
        deleteRequestOT()
    }
    
    func compareDate(start : String, end : String) -> Bool{
        var true_format = false
        let date_formatter = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let start_date = date_formatter.date(from: start)!
        let end_date = date_formatter.date(from: end)!
        if end_date > start_date {
            true_format = true
        }
        return true_format
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textview_reason.textColor == UIColor.lightGray {
            textview_reason.text = nil
            textview_reason.textColor = UIColor.black
            chk_reason = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textview_reason.text.isEmpty {
            textview_reason.text = "reason".localized(gb.lang_now)
            textview_reason.textColor = UIColor.lightGray
            chk_reason = false
        }
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        let date_formatter = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if textfield_start.isFirstResponder{
            textfield_start.text = date_formatter.string(from: startPicker.date)
            textfield_start.resignFirstResponder()
            chk_start = true
        }
        else {
            textfield_end.text = date_formatter.string(from: endPicker.date)
            textfield_end.resignFirstResponder()
            chk_end = true
        }
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if textfield_start.isFirstResponder{
            textfield_start.resignFirstResponder()
        }
        else {
            textfield_end.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if textview_reason.isFirstResponder {
                if textview_reason.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
