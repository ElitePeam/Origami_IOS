//
//  Approve_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 27/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import SCLAlertView
import WMSegmentControl
import NVActivityIndicatorView

class Approve_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var work_table: UITableView!
    @IBOutlet weak var need_table: UITableView!
    @IBOutlet weak var view_comment: UIView!
    @IBOutlet weak var label_reason: UILabel!
    @IBOutlet weak var textfield_reason: UITextField!
    @IBOutlet weak var button_apply: UIButton!
    @IBOutlet weak var button_cancle: UIButton!
    @IBOutlet weak var button_work: UIButton!
    @IBOutlet weak var button_need: UIButton!
    @IBOutlet weak var segment_view: WMSegment!
    @IBOutlet weak var shadow_view: UIView!
    
    
    var workRequests:WorkRequests? = nil
    var needRequests:NeedRequests? = nil
    var workRequest:WorkRequest? = nil
    var needRequest:NeedRequest? = nil
    var standardReturn:StandardReturn? = nil
    var table_popup = UITableView()
    var table_height : CGFloat = 300
    var transparentView = UIView()
    var view_bg = UIView()
    var settingArray = ["detail".localized(gb.lang_now), "approve".localized(gb.lang_now),"not_approve".localized(gb.lang_now),"need_info".localized(gb.lang_now)]
    var settingIcon = ["info.circle", "checkmark.circle","xmark.circle","questionmark.circle"]
    var colorIcon = [gb.color_main, gb.color_ot_green, gb.color_ot_red, gb.color_ot_blue]
    var work_row = 0
    var need_row = 0
    var selected_table = ""
    var selected_approve = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "title_approve".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        gb.now_vc = "approve"
        segment_view.buttonTitles = "\("title_work".localized(gb.lang_now)),\("title_need".localized(gb.lang_now))"
        segment_view.selectorType = .bottomBar
        label_reason.text = "reason".localized(gb.lang_now)
        button_cancle.setTitle("cancle".localized(gb.lang_now), for: .normal)
        button_apply.setTitle("apply".localized(gb.lang_now), for: .normal)
        getWorkRequest()
        work_table.delegate = self
        work_table.dataSource = self
        need_table.delegate = self
        need_table.dataSource = self
        table_popup.delegate = self
        table_popup.dataSource = self
        table_popup.isScrollEnabled = false
        table_popup.register(PopupTableViewCell.self, forCellReuseIdentifier: "cell")
        table_popup.layer.cornerRadius = 10.0
        
        work_table.isHidden = false
        need_table.isHidden = true
        
        view_comment.layer.cornerRadius = 5.0
        view_comment.layer.shadowColor = UIColor.lightGray.cgColor
        view_comment.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_comment.layer.shadowRadius = 2.0
        view_comment.layer.shadowOpacity = 1
        view_comment.layer.masksToBounds = false
        
        button_apply.titleEdgeInsets = UIEdgeInsets(top: 3,left: 5,bottom: 3,right: 5)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view_comment.addGestureRecognizer(tap)
        
        shadow_view.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadow_view.layer.shadowRadius = 3
        shadow_view.layer.shadowOpacity = 1
        shadow_view.layer.shadowColor = UIColor.lightGray.cgColor
        shadow_view.clipsToBounds = false
        shadow_view.layer.masksToBounds = false
    }
    
    func getWorkRequest(){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_REQUEST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.workRequests = try JSONDecoder().decode(WorkRequests.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.work_row = 0
                    if (self.workRequests?.data != nil ) {
                        self.work_row = (self.workRequests?.data!.count)!
                    }
                    self.work_table.reloadData()
                    self.getNeedRequest()
                }
            }
        }
        task.resume()
    }
    
    func getNeedRequest(){
        let postString = "empId=\(String((gb.user?.emp_id)!))&compId=\(String((gb.user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_REQUEST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.needRequests = try JSONDecoder().decode(NeedRequests.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.need_row = 0
                    if (self.needRequests?.data != nil ) {
                        self.need_row = (self.needRequests?.data!.count)!
                    }
                    self.need_table.reloadData()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func sendNeedApprove(strAction : String, comment : String){
        let postString = "empId=\(String((gb.user?.emp_id)!))&compId=\(String((gb.user?.comp_id)!))&requestid=\(String((needRequest?.mny_request_id!)!))&howisit=\(strAction)&comment=\(String(comment))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_APPROVE)!
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
                    self.closeLoad()
                    var alert_txt = ""
                    if self.selected_approve == "yes" {
                        alert_txt = "Approve need success."
                    }
                    else if self.selected_approve == "no" {
                        alert_txt = "Not approve need success."
                    }
                    else {
                        alert_txt = "Request detail need success."
                    }
                    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                    let alert = SCLAlertView(appearance: appearance)
                    alert.addButton("Close") {
                       alert.hideView()
                       self.showLoad()
                       self.getWorkRequest()
                    }
                    alert.showSuccess("Success", subTitle: alert_txt, animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func sendWorkApprove(strAction : String, emp_id : String, head_id : String, req_id : String, comment : String, apv_code : String){
        let postString = "comp_id=\(String((gb.user?.comp_id)!))&emp=\(String(emp_id))&approve=\(String(head_id))&howisit=\(strAction)&req=\(String(req_id))&note_comment=&code_a=\(String(apv_code))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_APPROVE_WORK)!
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
                    self.closeLoad()
                    var alert_txt = ""
                    if self.selected_approve == "yes" {
                        alert_txt = "Approve work success."
                    }
                    else if self.selected_approve == "no" {
                        alert_txt = "Not approve work success."
                    }
                    else {
                        alert_txt = "Request detail work success."
                    }
                    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false)
                    let alert = SCLAlertView(appearance: appearance)
                    alert.addButton("Close") {
                       alert.hideView()
                       self.showLoad()
                       self.getWorkRequest()
                    }
                    alert.showSuccess("Success", subTitle: alert_txt, animationStyle: .noAnimation)
                }
            }
        }
        task.resume()
    }
    
    func sendFloatApprove(action : String, comment : String, float_id : String, float_type : String){
        let postString = "float_type=\(float_type)&float_id=\(float_id)&action=\(action)&comment=\(comment)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_APPROVE_FLOAT)!
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
                let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false))
                alert.addButton("close".localized(gb.lang_now)) {
                   alert.hideView()
                    if self.standardReturn?.status == "0" {
                        self.getWorkRequest()
                    }
                }
                
                if self.standardReturn?.status == "0" {
                    alert.showSuccess("success".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                else {
                    alert.showError("fail".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                }
                self.closeLoad()
            }
        }
        task.resume()
    }
    
    
    @IBAction func tapApply(_ sender: Any) {
        view_comment.isHidden = true
        onClickTransparentViews()
        view_comment.endEditing(true)
        showLoad()
        let comment = textfield_reason.text
        if selected_table == "need" {
            sendNeedApprove(strAction : selected_approve, comment : comment!)
        }
        else{
            if workRequest!.type == "leave" {
                sendWorkApprove(strAction : selected_approve, emp_id : workRequest!.u_emp_id!, head_id : workRequest!.u_head_id!, req_id : workRequest!.u_id!, comment : comment!, apv_code : workRequest!.u_apv_code!)
            }
            else {
                var float_type = ""
                if workRequest!.type == "flotre" {
                    float_type = "float_request"
                }
                else {
                    float_type = "float_leave"
                }
                sendFloatApprove(action: selected_approve, comment: comment ?? "", float_id: workRequest!.u_id!, float_type: float_type)
            }
        }
    }
    
    @IBAction func tapCancle(_ sender: Any) {
        view_comment.isHidden = true
        onClickTransparentViews()
        view_comment.endEditing(true)
    }
    
    
    @IBAction func tapChangeSegment(_ sender: WMSegment) {
        let segment_num = sender.selectedSegmentIndex
        switch segment_num {
        case 0:
            work_table.isHidden = false
            need_table.isHidden = true
        case 1:
            work_table.isHidden = true
            need_table.isHidden = false
        default:
            print("Some things wrong!")
        }
    }
    
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == need_table {
            return need_row
        }
        else if tableView == work_table {
            return work_row
        }
        else {
            return settingArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == need_table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApproveNeedTableViewCell
            
            cell.txt_doc.text = "doc_no".localized(gb.lang_now)
            cell.txt_topic.text = "subject".localized(gb.lang_now)
            cell.txt_date.text = "date".localized(gb.lang_now)
            cell.txt_budget.text = "total_budget".localized(gb.lang_now)
            
            let need_request = needRequests?.data![indexPath.row]
            cell.label_name.text = "\(String((need_request?.user_create!)!))"
            cell.label_type.text = need_request?.type
            cell.label_doc.text = need_request?.mny_request_generate_code
            cell.label_topic.text = need_request?.mny_request_location
            cell.label_date.text = need_request?.mny_request_date
            cell.label_budget.text = need_request?.mny_request_total
            cell.selectionStyle = .none
            
            cell.view_cell.layer.cornerRadius = 8.0
            cell.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.view_cell.layer.shadowRadius = 2.0
            cell.view_cell.layer.shadowOpacity = 1
            cell.view_cell.layer.masksToBounds = false
            
            return cell
        }
        else if tableView == work_table{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApproveWorkTableViewCell
            
            cell.txt_reason.text = "reason".localized(gb.lang_now)
            cell.txt_start.text = "start_request_ot".localized(gb.lang_now)
            cell.txt_end.text = "end_request_ot".localized(gb.lang_now)
            
            let work_request = workRequests?.data![indexPath.row]
            cell.label_name.text = "\(String(work_request!.u_firstname!)) \(String(work_request!.u_lastname!))"
            cell.label_reason.text = work_request?.u_subject
            cell.label_start.text = "\(String((work_request?.u_req_start)!)) \(String((work_request?.u_req_start_time)!))"
            cell.label_end.text = "\(String((work_request?.u_req_end)!)) \(String((work_request?.u_req_end_time)!))"
            if gb.lang_now == "en" {
                cell.label_type.text = "\(work_request?.u_type_en ?? "float_leave")".localized(gb.lang_now)
            }
            else {
                cell.label_type.text = "\(work_request?.u_type_th ?? "float_leave")".localized(gb.lang_now)
            }
            cell.selectionStyle = .none
            
            cell.view_cell.layer.cornerRadius = 8.0
            cell.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.view_cell.layer.shadowRadius = 2.0
            cell.view_cell.layer.shadowOpacity = 1
            cell.view_cell.layer.masksToBounds = false
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopupTableViewCell
            cell!.lbl.text = settingArray[indexPath.row]
            let symbol = UIImage.SymbolConfiguration(pointSize: 80, weight: .thin, scale: .large)
            let icon = UIImage(systemName: settingIcon[indexPath.row], withConfiguration: symbol)
            cell!.settingImage.image = icon
            cell!.settingImage.tintColor = colorIcon[indexPath.row]
            cell!.selectionStyle = .none
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == work_table {
            workRequest = workRequests?.data![indexPath.row]
            selected_table = "work"
            
            let window = UIApplication.shared.keyWindow
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            transparentView.frame = self.view.frame
            window?.addSubview(transparentView)
            
            let screenSize = UIScreen.main.bounds.size
            table_popup.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: table_height)
            window?.addSubview(table_popup)
    
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
            transparentView.addGestureRecognizer(tapGesture)
            transparentView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.table_popup.frame = CGRect(x: 0, y: screenSize.height - self.table_height, width: screenSize.width, height: self.table_height)
            }, completion: nil)
        }
        else if tableView == need_table {
            needRequest = needRequests?.data![indexPath.row]
            selected_table = "need"
            
            let window = UIApplication.shared.keyWindow
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            transparentView.frame = self.view.frame
            window?.addSubview(transparentView)
            
            let screenSize = UIScreen.main.bounds.size
            table_popup.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: table_height)
            window?.addSubview(table_popup)
    
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
            transparentView.addGestureRecognizer(tapGesture)
            transparentView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.table_popup.frame = CGRect(x: 0, y: screenSize.height - self.table_height, width: screenSize.width, height: self.table_height)
            }, completion: nil)
        }
        else {
            textfield_reason.text = ""
            
            if indexPath.row == 0 {
                if selected_table == "need" {
                    button_need.sendActions(for: .touchUpInside)
                }
                else {
                    button_work.sendActions(for: .touchUpInside)
                }
            }
            else if indexPath.row == 1{
                selected_approve = "yes"
                view_comment.isHidden = false
                openPopupBG()
            }
            else if indexPath.row == 2{
                selected_approve = "no"
                view_comment.isHidden = false
                openPopupBG()
            }
            else {
                selected_approve = "wait"
                view_comment.isHidden = false
                openPopupBG()
            }
            
            onClickTransparentView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == need_table {
            return 170
        }
        else if tableView == work_table {
            return 150
        }
        else {
            return 75
        }
    }
    
    func openPopupBG(){
        view_bg.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view_bg.frame = self.view.frame
        view_bg.alpha = 0
//        if #available(iOS 13, *) {
//            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
//            window?.addSubview(view_bg)
//            window?.addSubview(view_comment)
//        } else {
//            let window = UIApplication.shared.keyWindow
//            window?.addSubview(view_bg)
//            window?.addSubview(view_comment)
//        }
    
        self.view.addSubview(view_bg)
        self.view.addSubview(view_comment)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view_bg.alpha = 0.5
        }, completion: nil)
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.table_popup.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.table_height)
        }, completion: nil)
    }
    
    @objc func onClickTransparentViews() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view_bg.alpha = 0
        }, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view_comment.endEditing(true)
    }
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "approve_work" {
            let sb = segue.destination as! ApproveWorkDetail_VC
            sb.workRequest = workRequest
        }
        else if segue.identifier == "approve_need" {
            let sb = segue.destination as! ApproveNeedDetail_VC
            sb.needRequest = needRequest
        }
        else {
            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
            sideMenuNavigationController.settings = makeSettings()
        }
    }

    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        presentationStyle.backgroundColor = UIColor.clear
        presentationStyle.menuStartAlpha = CGFloat(1)
        presentationStyle.menuScaleFactor = CGFloat(1)
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingEndAlpha = CGFloat(1)
        presentationStyle.presentingScaleFactor = CGFloat(1)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(120, view.frame.height)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[1]
        settings.statusBarEndAlpha = 1
        
        return settings
    }

    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn, .viewSlideOutMenuPartialIn, .viewSlideOutMenuOut, .viewSlideOutMenuPartialOut, .viewSlideOutMenuZoom]
        return modes[0]
    }

    private func setupSideMenu() {
           SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
       }
    
    private func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
    }
}
