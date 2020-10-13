//
//  AddLeave_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 7/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import DropDown
import Foundation
import SCLAlertView
import NVActivityIndicatorView

final class AddLeave_VC: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var datetime_start: UITextField!
    @IBOutlet weak var datetime_end: UITextField!
    @IBOutlet weak var image_checkbox: UIImageView!
    @IBOutlet weak var button_apply: UIButton!
    @IBOutlet weak var button_trigger_check_box: UIButton!
    @IBOutlet weak var label_leave_without_pay: UILabel!
    @IBOutlet weak var text_reason: UITextField!
    @IBOutlet weak var text_note: UITextField!
    @IBOutlet weak var loading_bg: UIView!
    @IBOutlet weak var loading_icon: NVActivityIndicatorView!
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var text_type: UITextField!
    @IBOutlet weak var text_name: UITextField!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_leave: UILabel!
    @IBOutlet weak var label_leave_date: UILabel!
    @IBOutlet weak var label_pay: UILabel!
    @IBOutlet weak var label_reason: UILabel!
    @IBOutlet weak var label_note: UILabel!
    
    
    var isCheckbox = false
    let dropDown = DropDown()
    var workBalances:WorkBalances? = nil
    var workBalance:WorkBalance? = nil
    var workDatas:WorkDatas? = nil
    var workShift:WorkShift? = nil
    var floatShift:FloatShift? = nil
    var startEndWork:[StartEndWork]? = nil
    var standardReturn:StandardReturn? = nil
    var dropdown_name : [String] = []
    var dropdown_id : [String] = []
    var before_day : [String] = []
    var hours_day : [String] = []
    var selected_dropdown_id = ""
    var start_date_text = ""
    var end_date_text = ""
    var start_time_text = ""
    var end_time_text = ""
    var selected_datetime_end = ""
    var checkbox_leave_pay = "N"
    var reason_text = ""
    var note_text = ""
    var start_datetime = Date()
    var end_datetime = Date()
    var start_datePicker = UIDatePicker()
    var end_datePicker = UIDatePicker()
    var type = false
    var sdate = false
    var edate = false
    var reason = false
    var chk_before = false
    var chk_back = false
    var leave_days = 0.0
    var leave_hours = 0.0
    var leave_mod = 0.0
    var work_hour = 8.0
    var l_hours = 0.0
    var leave_mod_str = "0.0"
    var selectedType: String?
    var selected_emp_id = ""
    var selected_fullname = ""
    var selected_comp_id = ""
    var selected_hour_day = "8"
    var selected_before_day = "0"
    var float_list = ["rq_for_float".localized(gb.lang_now), "float_leave".localized(gb.lang_now)]
    var float_id = ["request_float", "leave_float"]
    var page_type = ""
    var work_id = ""
    var work_type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowLoading(isShow: true)
        initLayout()
        getWorkBalance()
    }
    
    func initLayout(){
        self.title = "add_work".localized(gb.lang_now)
        image_checkbox.image = UIImage(named: "checkbox_false")
        view_bg.backgroundColor = gb.color_background
        label_name.text = "name".localized(gb.lang_now)
        label_leave.text = "leave_type".localized(gb.lang_now)
        label_leave_date.text = "leave_date".localized(gb.lang_now)
        label_pay.text = "without_pay".localized(gb.lang_now)
        label_reason.text = "reason".localized(gb.lang_now)
        label_note.text = "note".localized(gb.lang_now)
        
        text_type.placeholder = "leave_type".localized(gb.lang_now)
        datetime_start.placeholder = "start_request_ot".localized(gb.lang_now)
        datetime_end.placeholder = "end_request_ot".localized(gb.lang_now)
        text_reason.placeholder = "reason".localized(gb.lang_now)
        text_note.placeholder = "note".localized(gb.lang_now)
        button_apply.setTitle("apply".localized(gb.lang_now), for: .normal)
        
        start_datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        end_datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        start_datePicker.addTarget(self, action: #selector(AddLeave_VC.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        end_datePicker.addTarget(self, action: #selector(AddLeave_VC.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        let cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        cancelButton.tintColor = UIColor.systemOrange
        doneButton.tintColor = UIColor.systemOrange
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        datetime_start.inputAccessoryView = toolBar
        datetime_end.inputAccessoryView = toolBar
        datetime_start.inputView = start_datePicker
        datetime_end.inputView = end_datePicker
        
        text_reason.addTarget(self, action: #selector(AddLeave_VC.textFieldDidChange(_:)),
        for: .editingChanged)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        text_type.inputView = pickerView
        text_type.inputAccessoryView = toolBar
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initData(){
        if page_type == "edit" {
            getWorkData()
        }
        else {
            text_name.text = selected_fullname
            isShowLoading(isShow: false)
        }
    }
    
    func initLayoutData(){
        type = true
        sdate = true
        edate = true
        reason = true
        chk_before = true
        chk_back = true
        let data = self.workDatas?.data[0]
        text_name.text = "\(data?.first_en ?? "") \(data?.last_en ?? "")"
        datetime_start.text = "\(data?.start_date ?? "00/00/0000") \(data?.start_time ?? "00:00")"
        datetime_end.text = "\(data?.end_date ?? "00/00/0000") \(data?.end_time ?? "00:00")"
        text_reason.text = data?.subject ?? ""
        text_note.text = data?.note ?? ""
        
        start_datePicker.date = convertToDate(datetime: datetime_start.text ?? "00/00/0000 00:00")
        end_datePicker.date = convertToDate(datetime: datetime_end.text ?? "00/00/0000 00:00")
        start_datetime = convertToDate(datetime: datetime_start.text ?? "00/00/0000 00:00")
        end_datetime = convertToDate(datetime: datetime_end.text ?? "00/00/0000 00:00")
        
        if data?.type_id == "request_float" || data?.type_id == "leave_float" {
            label_leave_without_pay.alpha = 0.5
            image_checkbox.alpha = 0.5
            button_trigger_check_box.isEnabled = false
            if data?.type_id == "request_float" {
                dropdown_name = ["rq_for_float".localized(gb.lang_now)]
                dropdown_id = ["request_float"]
            }
            else {
                dropdown_name = ["float_leave".localized(gb.lang_now)]
                dropdown_id = ["leave_float"]
            }
            text_type.text = dropdown_name[0]
            selected_dropdown_id = dropdown_id[0]
        }
        else {
            let index = dropdown_id.firstIndex(of: data?.type_id ?? "")
            text_type.text = dropdown_name[index ?? 0]
            selected_dropdown_id = dropdown_id[index ?? 0]
        }
            
        if data?.no_money == "N" {
            isCheckbox = false
            image_checkbox.image = UIImage(named: "checkbox_false")
            checkbox_leave_pay = "N"
        }
        else {
            isCheckbox = true
            image_checkbox.image = UIImage(named: "checkbox_true")
            checkbox_leave_pay = "Y"
        }
        
        start_date_text = data?.start_date ?? "00/00/0000"
        start_time_text = data?.start_time ?? "00:00"
        end_date_text = data?.end_date ?? "00/00/0000"
        end_time_text = data?.end_time ?? "00:00"
        reason_text = data?.subject ?? ""
        note_text = data?.note ?? ""
        checkbox_leave_pay = data?.no_money ?? "N"
//        leave_days = Double(data?.total_date ?? "0.0")!
//        leave_hours = Double(data?.total_time ?? "0.0")!
//        leave_mod = Double(data?.total_time ?? "0.0")!
        isShowLoading(isShow: false)
    }
    
    
    @IBAction func tapApply(_ sender: Any) {
        isShowLoading(isShow: true)
        leave_hours = 0.0
        if selected_emp_id != gb.user?.emp_id {
            chk_before = true
            chk_back = true
        }
        else{
            if sdate && edate {
               checkBeforeDay()
            }
        }

        if type == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_leave_type".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if sdate == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_leave_start".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if edate == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_leave_end".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if reason == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "warn_reason".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if chk_before == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "\("warn_before_day".localized(gb.lang_now)) \(selected_before_day) \("day".localized(gb.lang_now))", closeButtonTitle:"close",animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if chk_back == false {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "\("warn_past_day".localized(gb.lang_now)) \(selected_before_day) \("day".localized(gb.lang_now))", closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else if !(compareDate(start: datetime_start.text!, end: datetime_end.text!)){
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "wrong_time_format".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else{
            get_list_day()
        }
    }

    func get_list_day() {
        var list_day:[String] = []
        let day_index = 0
        var start_date = start_datetime
        let end_date   = end_datetime
        let fmt = DateFormatter()
        fmt.calendar = Calendar(identifier: .gregorian)
        fmt.dateFormat = "yyyy-MM-dd"
            
        while start_date <= end_date {
            list_day.append(fmt.string(from: start_date))
            start_date = Calendar.current.date(byAdding: .day, value: 1, to: start_date)!
        }
        
        let max_date = list_day.count
        get_startend_work(date: list_day[day_index], index: day_index, max_date: max_date,list_day: list_day)
    }
    
    func get_startend_work(date:String, index:Int, max_date: Int, list_day:[String]){
        let postString = "emp_id=\(String(selected_emp_id))&comp_id=\(String(selected_comp_id))&date_check=\(date)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_START_END_WORK)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.startEndWork = try JSONDecoder().decode([StartEndWork].self, from: data!)
            }catch{}

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                do{
                    self.leave_hours += self.cal_hour(data_startend:self.startEndWork!,date:date, index:index, max_date: max_date)
                    let ind = index + 1
                    if ind < max_date {
                        self.get_startend_work(date: list_day[ind], index: ind, max_date: max_date, list_day:list_day)
                    }
                    else {
                        let work_min = 480
                        self.leave_mod = Double(Int(self.leave_hours) % work_min)
                        let mod_hour = Int(self.leave_mod/60)
                        let mod_min  = Int(Int(self.leave_mod) % 60)
                        var zero_check2 = "0"
                        if mod_min < 10 {zero_check2 = "0\(String(mod_min))"}
                        else {zero_check2 = "\(String(mod_min))"}
                        self.leave_mod = Double("\(String(mod_hour)).\(zero_check2)")!
                        
                        let return_hour = Int(self.leave_hours/60)
                        let return_min = Int(Int(self.leave_hours) % 60)
                        var zero_check = "0"
                        if return_min < 10 {zero_check = "0\(String(return_min))"}
                        else {zero_check = "\(String(return_min))"}
                        let for_check_day = Float(self.leave_hours/60)
                        self.leave_days = floor(Double(for_check_day) / Double(self.selected_hour_day)!)
                        
                        var return_final = 0.0
                        return_final = Double("\(String(return_hour)).\(zero_check)")!
                        self.leave_hours = return_final
                        print("Final : \(self.leave_hours)")
                        
                        if self.selected_dropdown_id == "request_float" || self.selected_dropdown_id == "leave_float" {
                            self.checkFloatShift()
                        }
                        else {
                            self.checkShift()
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func StringToDate(date_string : String) -> Date{
        let fmt = DateFormatter()
        fmt.calendar = Calendar(identifier: .gregorian)
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.date(from: date_string)!
    }
    
    func cal_hour(data_startend:[StartEndWork],date:String, index:Int, max_date: Int) -> Double {
        var end_     = 1020
        var start_   = 510
        var have_day = false
        var that_day : StartEndWork? = nil
        if data_startend.count > 0 {
            for day in data_startend {
                if day.dt == date {
                    have_day = true
                    that_day = day
                    break
                }
            }
            if have_day {
                let str_start = strToMinute(strDate: (that_day?.datetime_in!)!)
                let str_end   = strToMinute(strDate: (that_day?.datetime_out!)!)
                let work_start = StringToDate(date_string: (that_day?.datetime_in!)!)
                let work_end   = StringToDate(date_string: (that_day?.datetime_out!)!)
                start_      = str_start
                end_        = str_end
                work_hour   = Double(Double(end_ - start_ - 60) / 60)
                
                var all_hour   = 0.0
                var sum_start  = 0
                var sum_end    = 0
                let calendar   = Calendar.current
            
                if index == 0 {
                    let start_hour     = calendar.component(.hour, from: start_datetime)
                    let start_minutes  = calendar.component(.minute, from: start_datetime)
                    var end_hour       = 0
                    var end_minutes    = 0
                    if max_date == 1 {
                        end_hour       = calendar.component(.hour, from: end_datetime)
                        end_minutes    = calendar.component(.minute, from: end_datetime)
                    }
                    else {
                        end_hour       = calendar.component(.hour, from: work_end)
                        end_minutes    = calendar.component(.minute, from: work_end)
                    }
                    sum_start          = (start_hour * 60) + start_minutes
                    sum_end            = (end_hour * 60) + end_minutes
                }
                else if index + 1 == max_date {
                    let start_hour     = calendar.component(.hour, from: work_start)
                    let start_minutes  = calendar.component(.minute, from: work_start)
                    var end_hour       = 0
                    var end_minutes    = 0
                    if work_end <= end_datetime{
                        end_hour       = calendar.component(.hour, from: work_end)
                        end_minutes    = calendar.component(.minute, from: work_end)
                    }
                    else {
                        end_hour       = calendar.component(.hour, from: end_datetime)
                        end_minutes    = calendar.component(.minute, from: end_datetime)
                    }
                    sum_start          = (start_hour * 60) + start_minutes
                    sum_end            = (end_hour * 60) + end_minutes
                }
                else if index < max_date && index > 0 {
                    let start_hour     = calendar.component(.hour, from: work_start)
                    let start_minutes  = calendar.component(.minute, from: work_start)
                    let end_hour       = calendar.component(.hour, from: work_end)
                    let end_minutes    = calendar.component(.minute, from: work_end)
                    sum_start          = (start_hour * 60) + start_minutes
                    sum_end            = (end_hour * 60) + end_minutes
                }
                else {
                    return 0.0
                }

                all_hour = Double(sum_end - sum_start)
                if all_hour >= 300 {
                    all_hour -= 60
                }
                return all_hour
            }
            else {return 0.0}
        }
        else {return 0.0}
    }
    
    func checkShift(){
        let postString = "sdate=\(start_date_text)&edate=\(end_date_text)&emp_idsi=\(String((gb.user?.emp_id)!))&emp_id_ss=\(selected_emp_id)&type=\(selected_dropdown_id)&stime=\(start_time_text)&etime=\(end_time_text)"
        print("DEBUG : 182389 : \(postString)")
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_SHIFT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.workShift = try JSONDecoder().decode(WorkShift.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if self.workShift != nil {
                        if self.workShift?.state == "t"{
                            if self.page_type == "add" {
                                self.insertWorkLeave()
                            }
                            else {
                                self.updateWorkLeave(type: "normal_leave")
                            }
                        }
                        else {
                            SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "check_work_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                            self.isShowLoading(isShow: false)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func checkFloatShift(){
        let postString = "start_date=\(start_date_text)&end_date=\(end_date_text)&emp_upper=\(String((gb.user?.emp_id)!))&emp_under=\(selected_emp_id)&float_type=\(selected_dropdown_id)&start_time=\(start_time_text)&end_time=\(end_time_text)&comp_id=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_FLOAT_SHIFT)!
        print("DEBUG 123827 : \(postString)")
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.floatShift = try JSONDecoder().decode(FloatShift.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.floatShift != nil {
                    if self.floatShift?.state == "t"{
                        if self.selected_dropdown_id == "request_float"{
                            SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "check_work_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                            self.isShowLoading(isShow: false)
                        }
                        else {
                            if self.page_type == "edit" {
                                self.updateWorkLeave(type: "float_leave")
                            }
                            else {
                                self.insertFloat()
                            }
                        }
                    }
                    else {
                        if self.selected_dropdown_id == "request_float"{
                            self.leave_hours = Double(self.findTotalDateHour(start: self.start_datetime,end: self.end_datetime,break_time: self.floatShift?.sum_break ?? "0")) ?? 0.00
                            if self.page_type == "edit" {
                                self.updateWorkLeave(type: "float_request")
                            }
                            else {
                                self.insertFloat()
                            }
                        }
                        else {
                            SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "check_work_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                            self.isShowLoading(isShow: false)
                        }
                    }
                }
                else {
                    self.isShowLoading(isShow: false)
                }
            }
        }
        task.resume()
    }
    
    func checkRequestFloatApproved(){
        
    }
    
    func findTotalDateHour(start: Date, end: Date, break_time: String)->String{
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "GMT")! as TimeZone
        let dateComponents = calendar.dateComponents([Calendar.Component.minute], from: start, to: end)
        let minute = dateComponents.minute
        let min = minute! - Int(break_time)!
        let h = Int(min / 60)
        let m = Int(min % 60)
        print("findTotalDateHour_1 : minute=\(minute ?? 0) break=\(break_time)")
        var zero_check = "0"
        if m < 10 {zero_check = "0\(String(m))"}
        else {zero_check  = "\(String(m))"}
        print("findTotalDateHour_2 : \(String(h)).\(zero_check)")
        return String("\(String(h)).\(zero_check)")
    }
    
    func findTotalHour(start_time:String,end_time:String)->String{
        var result = "0.0"
        var zero_check = "0"
        let splited_start = start_time.components(separatedBy: ":")
        let splited_end   = end_time.components(separatedBy: ":")
        let start_min     = ((Int(splited_start[0]) ?? 0) * 60) + (Int(splited_start[1]) ?? 0)
        let end_min       = ((Int(splited_end[0]) ?? 0) * 60) + (Int(splited_end[1]) ?? 0)
        let remain_min    = end_min - start_min
        let hour          = Int(remain_min/60)
        let min           = Int(Int(remain_min) % 60)
        if min < 10 {zero_check = "0\(String(min))"}
        else {zero_check  = "\(String(min))"}
        result            = "\(String(hour)).\(String(zero_check))"
        return result
    }
    
    func checkSameDay(start_date:String,end_date:String)-> Bool {
        var result = false
        if start_date == end_date {
            result = true
        }
        return result
    }
    
    func insertFloat(){
        reason_text = text_reason.text!
        note_text   = text_note.text!
        let format_total_hour = String(format: "%.2f", leave_hours)
        print("format_total_hour : \(format_total_hour)")
        let start_date_ = DateString(datetime: start_date_text)
        let end_date_   = DateString(datetime: end_date_text)
        let postString = "emp_id=\(String(selected_emp_id))&comp_id=\(String(selected_comp_id))&float_type=\(selected_dropdown_id)&start_date=\(start_date_)&end_date=\(end_date_)&start_time=\(start_time_text)&end_time=\(end_time_text)&reason=\(reason_text )&note=\(note_text)&total_date=\(Int(leave_days))&total_hour=\(String(format_total_hour))"
        print(String(postString))
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_FLOAT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }
            catch let err{
                print("Error : ",err)
            }
            DispatchQueue.main.async {
                self.isShowLoading(isShow: false)
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false, shouldAutoDismiss: false
                )
                let alert = SCLAlertView(appearance: appearance)
                if self.standardReturn != nil {
                    if self.standardReturn!.status == "0" {
                        alert.addButton("close".localized(gb.lang_now)) {
                            alert.hideView()
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        alert.showSuccess("success".localized(gb.lang_now), subTitle: "\(self.standardReturn!.msg ?? "success")".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                    else {
                        alert.addButton("close".localized(gb.lang_now)) {
                            alert.hideView()
                        }
                        alert.showError("fail".localized(gb.lang_now), subTitle: "\(self.standardReturn!.msg ?? "error")".localized(gb.lang_now),animationStyle: .noAnimation)
                    }
                }
                else {
                    alert.addButton("close".localized(gb.lang_now)) {
                        alert.hideView()
                    }
                    alert.showError("fail".localized(gb.lang_now), subTitle: "error".localized(gb.lang_now),animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if text_reason.text != "" {
            reason = true
        }
        else{
            reason = false
        }
    }
    
    func insertWorkLeave(){
        reason_text = text_reason.text!
        note_text = text_note.text!
        
        let postString = "user=\(gb.username)&pass=\(gb.password)&action=\("submit_leave_form")&id_of_emp=\(String(selected_emp_id))&comp_id=\(String(selected_comp_id))&id_of_type=\(selected_dropdown_id)&sdate_leave=\(start_date_text)&edate_leave=\(end_date_text)&start_time=\(start_time_text)&end_time=\(end_time_text)&reason_leave=\(reason_text )&note_leave=\(note_text)&total_use_date=\(Int(leave_days))&total_use_time=\(String(leave_hours))&total_use_date_hour=\(String(leave_mod))&no_pay=\(checkbox_leave_pay)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_WORK_LEAVE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{}
            DispatchQueue.main.async {
                self.isShowLoading(isShow: false)
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false, shouldAutoDismiss: false
                )
                let alert = SCLAlertView(appearance: appearance)
                alert.addButton("close".localized(gb.lang_now)) {
                    alert.hideView()
                    _ = self.navigationController?.popViewController(animated: true)
                }
                alert.showSuccess("success".localized(gb.lang_now), subTitle: "add_leave_success".localized(gb.lang_now),animationStyle: .noAnimation)
            }
        }
        task.resume()
    }
    
    func updateWorkLeave(type:String){
        let full_fmt = DateFormatter()
        full_fmt.calendar = Calendar(identifier: .gregorian)
        full_fmt.locale = Locale(identifier: "en_US_POSIX")
        full_fmt.dateFormat = "dd/MM/yyyy  HH:mm"
        let date_fmt = DateFormatter()
        date_fmt.calendar = Calendar(identifier: .gregorian)
        date_fmt.locale = Locale(identifier: "en_US_POSIX")
        date_fmt.dateFormat = "yyyy-MM-dd"
        let time_fmt = DateFormatter()
        time_fmt.calendar = Calendar(identifier: .gregorian)
        time_fmt.locale = Locale(identifier: "en_US_POSIX")
        time_fmt.dateFormat = "HH:mm"
        let start_dt = full_fmt.date(from: datetime_start.text!)!
        let end_dt = full_fmt.date(from: datetime_end.text!)!
        start_date_text = date_fmt.string(from: start_dt)
        start_time_text = time_fmt.string(from: start_dt)
        end_date_text = date_fmt.string(from: end_dt)
        end_time_text = time_fmt.string(from: end_dt)
        reason_text = text_reason.text!
        note_text = text_note.text!
        let leave_hours_ = String(format: "%.2f", leave_hours)
    
        let postString = "type=\(String(type))&id=\(String(work_id))&leave_id=\(selected_dropdown_id)&start_date=\(start_date_text)&start_time=\(start_time_text)&end_date=\(end_date_text)&end_time=\(end_time_text)&total_date=\(leave_days )&total_time=\(leave_hours_)&reason=\(reason_text)&note=\(String(note_text))&no_pay=\(checkbox_leave_pay)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.UPDATE_WORK)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }
            catch let err{print("Error : ",err)}
            DispatchQueue.main.async {
                self.isShowLoading(isShow: false)
                let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(
                    showCloseButton: false, shouldAutoDismiss: false
                ))
                
                if self.standardReturn?.status == "0" {
                    alert.addButton("close".localized(gb.lang_now)) {
                        alert.hideView()
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now),animationStyle: .noAnimation)
                }
                else {
                    alert.addButton("close".localized(gb.lang_now)) {
                        alert.hideView()
                    }
                    alert.showError("fail".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now),animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func getWorkBalance(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(String(selected_emp_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_BALANCES)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.workBalances = try JSONDecoder().decode(WorkBalances.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                if (self.workBalances?.data != nil ) {
                    for data in (self.workBalances?.data)!{
                        var df_hour_day = "8"
                        self.dropdown_id.append(data.leave_type_id!)
                        if gb.lang_now == "en"{
                            self.dropdown_name.append(data.leave_type_name_en!)
                        }
                        else {
                            self.dropdown_name.append(data.leave_type_name_th!)
                        }
                        self.before_day.append(data.before_day!)
                        if (data.hours_day == nil || data.hours_day! == "0" || data.hours_day! == "") {
                            df_hour_day = "8"
                        }
                        self.hours_day.append(df_hour_day)
                    }
                    
                    if self.page_type == "add" {
                        for item in self.float_list {
                            self.dropdown_name.append(item)
                            self.before_day.append("0")
                            self.hours_day.append("8")
                        }
                        for item in self.float_id {
                            self.dropdown_id.append(item)
                        }
                    }
                }
                self.initData()
            }
        }
        task.resume()
    }
    
    func getWorkData(){
        let postString = "id=\(work_id)&type=\(work_type)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_EDIT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.workDatas = try JSONDecoder().decode(WorkDatas.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.workDatas != nil {
                    self.initLayoutData()
                }
                else {
                    
                }
            }
        }
        task.resume()
    }
    
    func checkBeforeDay(){
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let start = calendar.startOfDay(for: start_datetime)
        let components = calendar.dateComponents([.day], from: today, to: start)
        let days = components.day!
        let bf_day = Int(selected_before_day)
        
        if bf_day! >= 0 {
            chk_back = true
            if days >= bf_day! {
                chk_before = true
            }
            else{
                chk_before = false
            }
        }
        else{
            chk_before = true
            if days >= bf_day! {
                chk_back = true
            }
            else{
                chk_back = false
            }
        }
        
    }
    
    func calculateDay() -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: start_datetime)
        let date2 = calendar.startOfDay(for: end_datetime)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let days = components.day! + 1
        return days
    }
    
    func get_start_end_work(){
        let postString = "emp_id=\(String(selected_emp_id))&comp_id=\(String(selected_comp_id))&date_check=\(DateStringForSendStartEndWork(datetime:start_date_text))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_START_END_WORK)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.startEndWork = try JSONDecoder().decode([StartEndWork].self, from: data!)
            }catch let err{}

            DispatchQueue.main.async {
                do{
                    self.leave_hours = self.calculateHour()
                }
            }
        }
        task.resume()
    }
    
    func strToMinute(strDate:String)->Int{
        var newDate = strDate.split(separator: " ")
        newDate = newDate[1].split(separator: ":")
        let min = Int(newDate[1])
        let hour = Int(newDate[0])
        let hour60 = hour! * 60
        let sum = min! + hour60
        return sum
    }
    
    func calculateHour() -> Double {
        var end_    = 1020
        var start_  = 510
        var work_min = 0
        if startEndWork!.count > 0 {
            let str_start = strToMinute(strDate: startEndWork![0].datetime_in!)
            let str_end   = strToMinute(strDate: startEndWork![0].datetime_out!)

            start_      = str_start
            end_        = str_end
            work_hour   = Double(Double(end_ - start_ - 60) / 60)
            work_min    = end_ - start_ - 60
        }
        var all_hour       = 0.0
        let day_i          = calculateDay()
        let calendar       = Calendar.current
        let start_hour     = calendar.component(.hour, from: start_datetime)
        let start_minutes  = calendar.component(.minute, from: start_datetime)
        let end_hour       = calendar.component(.hour, from: end_datetime)
        let end_minutes    = calendar.component(.minute, from: end_datetime)
        let start_sum_min  = (start_hour * 60) + start_minutes
        let end_sum_min    = (end_hour * 60) + end_minutes
        
        if day_i == 1 {
            all_hour = Double(end_sum_min - start_sum_min)
            if all_hour >= 300 {
                all_hour -= 60
            }
        }
        else if day_i == 2 {
            all_hour = Double(end_ - start_sum_min)
            if all_hour >= 300 {
                all_hour -= 60
            }

            var day_2 = Double(end_sum_min - start_)
            if day_2 >= 300 {
                day_2 -= 60
            }
            all_hour += day_2
        }
        else{
            for i in 1...day_i {
                var tmp_min = 0.0
                if i == 1 {
                    tmp_min = Double(end_sum_min - start_sum_min)
                    if tmp_min >= 300 {
                        tmp_min -= 60
                    }
                    all_hour += tmp_min
                }
                else if i == day_i {
                    tmp_min = Double(end_sum_min - start_)
                    if tmp_min >= 300 {
                        tmp_min -= 60
                    }
                    all_hour += tmp_min
                }
                else {
                    tmp_min = Double(end_ - start_)
                    tmp_min -= 60
                    all_hour += tmp_min
                }
            }
        }
        
        let return_hour = Int(all_hour/60)
        let for_check_day = Float(all_hour/60)
        let return_min = Int(Int(all_hour) % 60)
        leave_days = floor(Double(for_check_day) / Double(selected_hour_day)!)
        var zero_check = "0"
        if return_min < 10 {
            zero_check = "0\(String(return_min))"
        }
        else {
            zero_check = "\(String(return_min))"
        }
        var return_final = 0.0
        return_final = Double("\(String(return_hour)).\(zero_check)")!
        return return_final
    }
    
    func convertToDate(datetime : String) -> Date{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter2.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy HH:mm"
        if let to_date = date_formatter.date(from: datetime) {
           return to_date
        }
        else {
            return Date()
        }
        
    }
    
    func compareDate(start : String, end : String) -> Bool{
        var true_format = false
        let date_formatter = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy  HH:mm"
        let start_date = date_formatter.date(from: start)!
        let end_date = date_formatter.date(from: end)!
        if end_date > start_date {
            true_format = true
        }
        return true_format
    }
    
    func DateStringForSend(datetime : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter2.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm"
        date_formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let to_date = date_formatter.date(from: datetime)!
        let to_string = date_formatter2.string(from: to_date)
        return to_string
    }
    
    func DateString(datetime : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter2.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy"
        date_formatter2.dateFormat = "yyyy-MM-dd"
        let to_date = date_formatter.date(from: datetime)!
        let to_string = date_formatter2.string(from: to_date)
        return to_string
    }
    
    func DateStringForSendStartEndWork(datetime : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter2.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd-MM-yyyy"
        date_formatter2.dateFormat = "yyyy-MM-dd"
        let to_date = date_formatter.date(from: datetime)!
        let to_string = date_formatter2.string(from: to_date)
        return to_string
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy  HH:mm"
        
        let date_formatter = DateFormatter()
        date_formatter.calendar = Calendar(identifier: .gregorian)
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "dd/MM/yyyy"
        
        let time_formatter = DateFormatter()
        time_formatter.calendar = Calendar(identifier: .gregorian)
        time_formatter.locale = Locale(identifier: "en_US_POSIX")
        time_formatter.dateFormat = "HH:mm"
        
        if datetime_start.isFirstResponder{
            start_datetime = start_datePicker.date
            datetime_start.text = formatter.string(from: start_datePicker.date)
            datetime_start.resignFirstResponder()
            start_date_text = date_formatter.string(from: start_datePicker.date)
            start_time_text = time_formatter.string(from: start_datePicker.date)
            sdate = true
        }
        else if datetime_end.isFirstResponder{
            end_datetime = end_datePicker.date
            datetime_end.text = formatter.string(from: end_datePicker.date)
            datetime_end.resignFirstResponder()
            end_date_text = date_formatter.string(from: end_datePicker.date)
            end_time_text = time_formatter.string(from: end_datePicker.date)
            edate = true
        }
        else {
            if selectedType == nil {
                selectedType = dropdown_name[0]
                selected_dropdown_id = dropdown_id[0]
                selected_hour_day = hours_day[0]
                selected_before_day = before_day[0]
            }
            if self.selected_dropdown_id == "request_float" || self.selected_dropdown_id == "leave_float" {
                label_leave_without_pay.alpha = 0.5
                image_checkbox.alpha = 0.5
                button_trigger_check_box.isEnabled = false
                isCheckbox = false
                image_checkbox.image = UIImage(named: "checkbox_false")
                checkbox_leave_pay = "N"
            }
            else {
                label_leave_without_pay.alpha = 1
                image_checkbox.alpha = 1
                button_trigger_check_box.isEnabled = true
            }
            text_type.text = selectedType
            type = true
            text_type.resignFirstResponder()
        }
        
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        if datetime_start.isFirstResponder{
            datetime_start.resignFirstResponder()
        }
        else if datetime_end.isFirstResponder{
            datetime_end.resignFirstResponder()
        }
        else{
            text_type.resignFirstResponder()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func tapChangeCheckBox(){
        isCheckbox = !isCheckbox
        if isCheckbox {
            image_checkbox.image = UIImage(named: "checkbox_true")
            checkbox_leave_pay = "Y"
        }
        else{
            image_checkbox.image = UIImage(named: "checkbox_false")
            checkbox_leave_pay = "N"
        }
    }
    
    func isShowLoading(isShow:Bool) {
        if isShow {
            loading_bg.backgroundColor = UIColor.black
            loading_bg.isHidden = false
            loading_icon.startAnimating()
        }
        else{
            loading_bg.isHidden = true
            loading_icon.stopAnimating()
        }
    }
    
    @IBAction func tapTriggerCheckBox(_ sender: Any) {
        tapChangeCheckBox()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if text_reason.isFirstResponder {
                if text_reason.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            else if text_note.isFirstResponder {
                if text_note.frame.origin.y > keyboardSize.height && self.view.frame.origin.y == 0 {
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdown_name.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdown_name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType            = dropdown_name[row]
        selected_dropdown_id    = dropdown_id[row]
        selected_hour_day       = hours_day[row]
        selected_before_day     = before_day[row]
    }
}

//                            if !(self.checkSameDay(start_date: self.start_date_text,end_date: self.end_date_text)){
//                                print("Request float have to be same day.")
//                                SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "check_work_time".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
//                                self.isShowLoading(isShow: false)
//                            }
//                            else {
//                               self.leave_hours = Double(self.findTotalHour(start_time: self.start_time_text, end_time: self.end_time_text)) ?? 0.0
//                               self.insertFloat()
//                            }
