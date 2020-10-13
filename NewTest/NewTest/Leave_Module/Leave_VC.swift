//
//  Leave_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 6/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import WMSegmentControl
import SCLAlertView
import NVActivityIndicatorView

class Leave_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_leave: UITableView!
    @IBOutlet weak var table_overall: UITableView!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var loading_icon: NVActivityIndicatorView!
    @IBOutlet weak var loading_bg: UIView!
    @IBOutlet weak var segment_view: WMSegment!
    @IBOutlet weak var shadow_view: UIView!
    
    
    var user:UserLoginDao? = nil
    var underUsers:UnderUsers? = nil
    var underUser:UnderUser? = nil
    var workBalances:WorkBalances? = nil
    var workBalance:WorkBalance? = nil
    var workLeaves:WorkLeaves? = nil
    var workLeave:WorkLeave? = nil
    var standardReturn:StandardReturn? = nil
    var data_leave = [String]()
    var data_overall = [String]()
    var image_array : [UIImage] = []
    var name_array : [String] = []
    var fullname_array : [String] = []
    var user_id_array : [String] = []
    var comp_id_array : [String] = []
    var selectedIndexPath: IndexPath?
    var work_balance_row = 0
    var work_leave_row = 0
    var selected_emp_id = ""
    var selected_comp_id = ""
    var selected_fullname = ""
    var first_user = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "title_work".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        view.backgroundColor = gb.color_background
        segment_view.selectorType = .bottomBar
        segment_view.buttonTitles = "\("leave".localized(gb.lang_now)),\("overall".localized(gb.lang_now))"
        isShowLoading(isShow: true)
        user = gb.user
        gb.now_vc = "work"
        selected_emp_id = (gb.user?.emp_id)!
        selected_fullname = "\(String((gb.user?.firstname)!)) \(String((gb.user?.lastname)!))"
        selected_comp_id = (gb.user?.comp_id)!
        setUnderUser()
        setupSideMenu()
        updateMenus()
        getWorkBalance()
        
        table_leave.delegate = self
        table_overall.delegate = self
        table_leave.dataSource = self
        table_overall.dataSource = self
        table_leave.rowHeight = 150.0
        table_overall.rowHeight = 130.0
        table_overall.isHidden = true
        
        shadow_view.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadow_view.layer.shadowRadius = 3
        shadow_view.layer.shadowOpacity = 1
        shadow_view.layer.shadowColor = UIColor.lightGray.cgColor
        shadow_view.clipsToBounds = false
        shadow_view.layer.masksToBounds = false
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getWorkBalance()
    }
    
    func setUnderUser(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(String((user?.emp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_UNDER_USER_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.underUsers = try JSONDecoder().decode(UnderUsers.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.image_array = []
                    self.name_array = []
                    self.user_id_array = []
                    self.comp_id_array = []
                    self.fullname_array = []
                    var imageString = ""
                    if gb.user?.emp_pic == nil {
                        imageString = "\(Const_Var.BASE_URL)images/default.png"
                    }
                    else{
                        imageString = "\(Const_Var.BASE_URL)\(String(((gb.user?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!)))"
                        imageString = imageString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
                    }
                    let url = URL(string: imageString)
                    let data = try Data(contentsOf: url!)
                    self.image_array.append(UIImage(data: data)!)
                    self.name_array.append("me".localized(gb.lang_now))
                    self.user_id_array.append((gb.user?.emp_id)!)
                    self.fullname_array.append("\(String((gb.user?.firstname)!)) \(String((gb.user?.lastname)!))")
                    self.comp_id_array.append((gb.user?.comp_id)!)
                    
                    if self.underUsers?.data != nil {
                        for under_user in (self.underUsers?.data)! {
                            var imageString = ""
                            if under_user.emp_pic != nil {
                                imageString = "\(Const_Var.BASE_URL)\(String(under_user.emp_pic!.replacingOccurrences(of: "\\", with: "")))"
                                imageString = imageString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
                            }
                            else{
                                imageString = "\(Const_Var.BASE_URL)images/default.png"
                            }
                            let url = URL(string: imageString)
                            let data = try Data(contentsOf: url!)
                            self.image_array.append(UIImage(data: data)!)
                            self.user_id_array.append((under_user.emp_id)!)
                            self.comp_id_array.append((under_user.comp_id)!)
                            if gb.lang_now == "en" {
                                self.name_array.append(under_user.firstname!)
                                self.fullname_array.append("\(String(under_user.firstname!)) \(String(under_user.lastname!))")
                            }
                            else {
                                self.name_array.append(under_user.firstname_th!)
                                self.fullname_array.append("\(String(under_user.firstname_th!)) \(String(under_user.lastname_th!))")
                            }
                        }
                    }
                    self.collection_view.reloadData()
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getWorkBalance(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(selected_emp_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_BALANCE)!
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
                self.work_balance_row = 0
                do{
                    if (self.workBalances?.data != nil ) {
                        self.work_balance_row = (self.workBalances?.data!.count)!
                    }
                    self.table_overall.reloadData()
                    self.getWorkLeave()
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getWorkLeave(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(selected_emp_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_WORK_LEAVE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.workLeaves = try JSONDecoder().decode(WorkLeaves.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.work_leave_row = 0
                do{
                    if (self.workLeaves?.data != nil ) {
                       self.work_leave_row = (self.workLeaves?.data!.count)!
                    }
                    self.table_leave.reloadData()
                    self.isShowLoading(isShow: false)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func deleteWork(type:String, id:String){
        let postString = "type=\(type)&id=\(id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_WORK)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.standardReturn = try JSONDecoder().decode(StandardReturn.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false, shouldAutoDismiss: false))
                alert.addButton("close".localized(gb.lang_now)) {
                   alert.hideView()
                }
                if self.standardReturn != nil {
                    if self.standardReturn?.status == "0" {
                        alert.showSuccess("success".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                        self.getWorkLeave()
                    }
                    else {
                        alert.showError("fail".localized(gb.lang_now), subTitle: "\(self.standardReturn?.msg ?? "")".localized(gb.lang_now), animationStyle: .noAnimation)
                         self.isShowLoading(isShow: false)
                    }
                }
            }
        }
        task.resume()
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
    
    @IBAction func segmentChange(_ sender: WMSegment) {
        let segment_num = sender.selectedSegmentIndex
        switch segment_num {
        case 0:
            table_leave.isHidden = false
            table_overall.isHidden = true
        case 1:
            table_leave.isHidden = true
            table_overall.isHidden = false
        default:
            print("Some things wrong!")
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                segment_view.setSelectedIndex(0)
            case .left:
                segment_view.setSelectedIndex(1)
            default:
                break
            }
            segment_view.sendActions(for: .valueChanged)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        switch tableView {
        case table_leave:
            row = work_leave_row
        case table_overall:
            row = work_balance_row
        default:
            print("Some things wrong!")
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView {
        case table_leave:
            let cells = tableView.dequeueReusableCell(withIdentifier: "cell_leave", for: indexPath) as! work_leave_cell
            cells.selectionStyle = .none
            let row_data = workLeaves?.data![indexPath.row]
            var label_title = ""
            
            var color = UIColor(hexString: "#000000")
            if row_data?.leave_color != nil && row_data?.leave_color != "" {
                color = UIColor(hexString: (row_data?.leave_color)!)
            }
            
            
            if row_data!.leave_name != "0" {
                if gb.lang_now == "en" {
                    label_title = row_data!.leave_name!
                }
                else {
                    label_title = row_data!.leave_name_th!
                }
            }
            else{
                if row_data!.TYPE == "flotre" {
                    label_title = "rq_for_float".localized(gb.lang_now)
                    color = UIColor(hexString: "#3a87ad")
                }
                else{
                    label_title = "float_leave".localized(gb.lang_now)
                    color = UIColor(hexString: "#3a87ad")
                }
            }
            
            var status_str = ""
            var status_color = UIColor()
            if row_data?.approve_del == "del" {
                status_str = "waiting_delete".localized(gb.lang_now)
                status_color = gb.color_ot_red
            }
            else if row_data?.state_approve == "Y"{
                status_str = "approve".localized(gb.lang_now)
                status_color = gb.color_ot_green
            }
            else if row_data?.state_approve == "N" && row_data?.approve_comment == nil{
                status_str = "pending".localized(gb.lang_now)
                status_color = gb.color_ot_yellow
            }
            else if row_data?.state_approve == "N" && (row_data?.approve_comment!.hasPrefix(" [Waiting]"))! {
                status_str = "need_info".localized(gb.lang_now)
                status_color = gb.color_ot_blue
            }
            else {
                status_str = "not_approve".localized(gb.lang_now)
                status_color = gb.color_ot_red
            }
            
            cells.label_status.textColor = status_color
            cells.label_status.text = status_str
            cells.view_color.backgroundColor = color
            cells.view_color.roundCorners([.topLeft, .bottomLeft], radius: 8.0)
            cells.label_title.text = label_title
            cells.label_reason.text = "\(String(row_data!.reason!))"
            cells.label_start.text = "Start : \(String(row_data!.from_date!))  \(String(row_data!.from_time!))"
            cells.label_end.text = "End  : \(String(row_data!.to_date!))  \(String(row_data!.to_time!))"
            cells.label_reason.font = UIFont.systemFont(ofSize: 15.0)
            cells.label_start.font = UIFont.systemFont(ofSize: 15.0)
            cells.label_end.font = UIFont.systemFont(ofSize: 15.0)
            
            cells.view_cell.layer.cornerRadius = 8.0
            cells.view_cell.layer.borderWidth = 0.0
            cells.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
            cells.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cells.view_cell.layer.shadowRadius = 2.0
            cells.view_cell.layer.shadowOpacity = 1
            cells.view_cell.layer.masksToBounds = false
            
            return cells
        case table_overall:
            let cells = tableView.dequeueReusableCell(withIdentifier: "cell_balance", for: indexPath) as! work_balance_cell
            let row_data = workBalances?.data![indexPath.row]
            var used_h = "0.00"
            var remean_h = "0.00"
            var total_h = "0.00"
            
            var color = UIColor(hexString: "#000000")
            if row_data?.leave_type_color != nil && row_data?.leave_type_color != "" {
                color = UIColor(hexString: (row_data?.leave_type_color)!)
            }
            
            if gb.lang_now == "en"{
                cells.label_title.text = row_data?.leave_type_name_en
            }
            else {
                cells.label_title.text = row_data?.leave_type_name_th
            }
            
            
            if row_data?.used != nil {
                used_h = row_data!.used!
            }
            if row_data?.Available != nil {
                remean_h = row_data!.Available!
            }
            if row_data?.total != nil{
                total_h = row_data!.total!
            }
            
            cells.label_used.text = "used".localized(gb.lang_now)
            cells.label_remain.text = "remain".localized(gb.lang_now)
            cells.label_total.text = "total".localized(gb.lang_now)
            cells.label_used_hour.text = used_h
            cells.label_remean_hour.text = remean_h
            cells.label_total_hour.text = total_h
            
            cells.view_color.backgroundColor = color
            cells.view_color.roundCorners([.topLeft, .bottomLeft], radius: 8.0)
            cells.view_cell.layer.cornerRadius = 8.0
            cells.view_cell.layer.borderWidth = 0.0
            cells.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
            cells.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cells.view_cell.layer.shadowRadius = 2.0
            cells.view_cell.layer.shadowOpacity = 1
            cells.view_cell.layer.masksToBounds = false
    
            return cells
        default:
            print("Some things wrong!")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = workLeaves?.data![indexPath.row]
        if data?.state_approve == "N" && data?.approve_comment == nil {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "addleave") as? AddLeave_VC
            vc?.page_type = "edit"
            vc?.work_id = data?.see_id ?? ""
            var type = data?.TYPE
            if type == "flotre" {
                type = "float_request"
            }
            else if type == "flotle" {
                type = "float_leave"
            }
            else {
                type = "normal_leave"
            }
            vc?.work_type = type ?? ""
            vc?.selected_emp_id = selected_emp_id
            vc?.selected_comp_id = selected_comp_id
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case table_leave:
            return true
        default:
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch tableView {
        case table_leave:
            if (editingStyle == .delete) {
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "cancle".localized(gb.lang_now), style: .cancel, handler: nil)
                
                let option1 = UIAlertAction(title: "confirm_delete".localized(gb.lang_now), style: .destructive) { action in
                    
                    self.isShowLoading(isShow: true)
                    let data = self.workLeaves?.data![indexPath.row]
                    var type = data?.TYPE
                    let id   = data?.see_id ?? ""
                    if type == "flotre" {
                        type = "float_request"
                    }
                    else if type == "flotle" {
                        type = "float_leave"
                    }
                    else {
                        type = "normal_leave"
                    }
                    self.deleteWork(type: type ?? "", id: id)
                }
                
                actionSheet.addAction(option1)
                actionSheet.addAction(cancel)
                present(actionSheet, animated: true, completion: nil)
            }
        default:
            print("Some things wrong!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ImageCollectionViewCell
        cell.image_cell.image = image_array[indexPath.row]
        cell.text_cell.text = name_array[indexPath.row]
        
        cell.text_cell.textColor = UIColor.darkGray
        cell.image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
        cell.image_cell.layer.borderWidth = 2
        
        if first_user{
            cell.text_cell.textColor = UIColor.systemOrange
            cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_cell.layer.borderWidth = 2
            selectedIndexPath = indexPath
            first_user = false
        }
        
        if indexPath.row == selectedIndexPath!.row {
            cell.text_cell.textColor = UIColor.systemOrange
            cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_cell.layer.borderWidth = 2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        self.selectedIndexPath = indexPath
        selected_emp_id = user_id_array[indexPath.row]
        selected_fullname = fullname_array[indexPath.row]
        selected_comp_id = comp_id_array[indexPath.row]
        getWorkBalance()

        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for index in visibleIndexPaths {
            let cell_1 = collectionView.cellForItem(at: index) as! ImageCollectionViewCell
            cell_1.text_cell.textColor = UIColor.darkGray
            cell_1.image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
            cell_1.image_cell.layer.borderWidth = 2
        }
        
        cell.text_cell.textColor = UIColor.systemOrange
        cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
        cell.image_cell.layer.borderWidth = 2
        selectedIndexPath = indexPath
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_add_leave" {
            let sb = segue.destination as! AddLeave_VC
            sb.selected_emp_id = selected_emp_id
            sb.selected_fullname = selected_fullname
            sb.selected_comp_id = selected_comp_id
            sb.page_type = "add"
        }
        else{
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
