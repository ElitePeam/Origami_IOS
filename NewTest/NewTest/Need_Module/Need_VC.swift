//
//  Need_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 8/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import SCLAlertView
import NVActivityIndicatorView

class Need_VC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var bar_button_add: UIBarButtonItem!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var table_need: UITableView!
    @IBOutlet weak var table_approve: UITableView!
    @IBOutlet weak var view_approve: UIView!
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var button_close: UIButton!
    
    
    var user:UserLoginDao? = nil
    var underUsers:UnderUsers? = nil
    var underUser:UnderUser? = nil
    var needLists:NeedLists? = nil
    var needList:NeedList? = nil
    var needSelected:NeedList? = nil
    var delete_Need:Delete_Need? = nil
    var needApprove:NeedApprove? = nil
    var itemApprove:ItemApprove? = nil
    var image_array : [UIImage] = []
    var name_array : [String] = []
    var user_id_array : [String] = []
    var user_comp_array : [String] = []
    var selectedIndexPath: IndexPath?
    var need_row = 0
    var approve_row = 0
    var selected_emp_id = ""
    var selected_emp_comp = ""
    var table_popup = UITableView()
    var table_height : CGFloat = 225
    var transparentView = UIView()
    var settingArray : [String] = []
    var settingIcon : [String] = []
    var menu_name1 = ["check_approve".localized(gb.lang_now),"delete_need".localized(gb.lang_now)]
    var menu_icon1 = ["arrow.up.doc","trash"]
    var menu_name2 = ["edit_need".localized(gb.lang_now),"check_approve".localized(gb.lang_now),"delete_need".localized(gb.lang_now)]
    var menu_icon2 = ["pencil.circle","arrow.up.doc","trash"]
    var send_type = "add"
    var first_user = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "title_need".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        showLoad()
        user = gb.user
        gb.now_vc = "need"
        selected_emp_id = (gb.user?.emp_id)!
        selected_emp_comp = (gb.user?.comp_id)!
        setupSideMenu()
        updateMenus()
        setUnderUser()
        
        table_need.delegate = self
        table_need.dataSource = self
        table_approve.delegate = self
        table_approve.dataSource = self
        
        table_popup.delegate = self
        table_popup.dataSource = self
        table_popup.isScrollEnabled = false
        table_popup.register(PopupTableViewCell.self, forCellReuseIdentifier: "cell")
        table_popup.layer.cornerRadius = 10.0

        view_bg.backgroundColor = UIColor.black
        view_bg.alpha = 0.7
        view_approve.layer.cornerRadius = 5
        view_approve.clipsToBounds = true
        
        button_close.setTitle("close".localized(gb.lang_now), for: .normal)
        
        collection_view.layer.shadowOffset = CGSize(width: 0, height: 2)
        collection_view.layer.shadowRadius = 3
        collection_view.layer.shadowOpacity = 1
        collection_view.layer.shadowColor = UIColor.lightGray.cgColor
        collection_view.clipsToBounds = false
        collection_view.layer.masksToBounds = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        send_type = "add"
    }
    
    @IBAction func tapTest(_ sender: Any) {
    }
    
    @IBAction func tapClose(_ sender: Any) {
        view_bg.isHidden = true
        view_approve.isHidden = true
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
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.image_array = []
                    self.name_array = []
                    self.user_id_array = []
                    self.user_comp_array = []
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
                    self.user_comp_array.append((gb.user?.comp_id)!)
                    
                    if self.underUsers?.data != nil {
                        for under_user in (self.underUsers?.data)! {
                            if under_user.emp_pic != nil {
                                var imageString = "\(Const_Var.BASE_URL)\(String((under_user.emp_pic!.replacingOccurrences(of: "\\", with: ""))))"
                                imageString = imageString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
                                let url = URL(string: imageString)
                                let data = try Data(contentsOf: url!)
                                self.image_array.append(UIImage(data: data)!)
                                self.user_id_array.append((under_user.emp_id)!)
                                self.user_comp_array.append((under_user.comp_id)!)
                                if gb.lang_now == "en" {
                                    self.name_array.append(under_user.firstname!)
                                }
                                else {
                                    self.name_array.append(under_user.firstname_th!)
                                }
                            }
                        }
                    }
                    self.collection_view.reloadData()
                    self.getNeedList()
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getNeedList(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&idEmp=\(String(selected_emp_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.needLists = try JSONDecoder().decode(NeedLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.need_row = 0
                    if (self.needLists?.list_request != nil ) {
                        self.need_row = (self.needLists?.list_request!.count)!
                    }
                    self.table_need.reloadData()
                    self.onClickTransparentView()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func deleteNeed(){
        let postString = "action=need&id=\(String(needSelected!.id!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_NEED)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.delete_Need = try JSONDecoder().decode(Delete_Need.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    print(self.delete_Need?.massage)
                    self.getNeedList()
                }
            }
        }
        task.resume()
    }
    
    func getApproveList(){
        let postString = "compId=\(selected_emp_comp)&requestId=\(String(needSelected!.id!))&requestType=\(String(needSelected!.type!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_APPROVE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.needApprove = try JSONDecoder().decode(NeedApprove.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if self.needApprove?.data != nil {
                        self.approve_row = (self.needApprove?.data!.count)!
                        self.table_approve.reloadData()
                    }
                    
                    self.onClickTransparentView()
                    self.view_bg.isHidden = false
                    self.view_approve.isHidden = false
                }
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! UnderUserCollectionViewCell
        cell.image_cell.image = image_array[indexPath.row]
        cell.name_text.text = name_array[indexPath.row]
        
        cell.name_text.textColor = UIColor.darkGray
        cell.image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
        cell.image_cell.layer.borderWidth = 2
        
        if first_user{
            cell.name_text.textColor = UIColor.systemOrange
            cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_cell.layer.borderWidth = 2
            selectedIndexPath = indexPath
            first_user = false
        }
        
        if indexPath.row == selectedIndexPath!.row {
            cell.name_text.textColor = UIColor.systemOrange
            cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_cell.layer.borderWidth = 2
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UnderUserCollectionViewCell
        self.selectedIndexPath = indexPath
        selected_emp_id = user_id_array[indexPath.row]
        selected_emp_comp = user_comp_array[indexPath.row]
        getNeedList()
        
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for index in visibleIndexPaths {
            let cell_1 = collectionView.cellForItem(at: index) as! UnderUserCollectionViewCell
            cell_1.name_text.textColor = UIColor.darkGray
            cell_1.image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
            cell_1.image_cell.layer.borderWidth = 2
        }
        
        cell.name_text.textColor = UIColor.systemOrange
        cell.image_cell.layer.borderColor = gb.color_orenge_a6.cgColor
        cell.image_cell.layer.borderWidth = 2
        selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//       let cell = collectionView.cellForItem(at: indexPath) as! UnderUserCollectionViewCell
//        cell.name_text.textColor = UIColor.darkGray
//        cell.image_cell.layer.borderColor = gb.color_darkgrey_a6.cgColor
//        cell.image_cell.layer.borderWidth = 2
//        self.selectedIndexPath = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if tableView == table_need {
            row = need_row
        }
        else if tableView == table_approve {
            row = approve_row
        }
        else{
            row = settingArray.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table_need{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! need_cell
            let need = needLists?.list_request![indexPath.row]
            cell.label_type.text = need?.type
            cell.label_status.text = need?.status
            if need?.doc_no == "" {
                cell.label_docnumber.text = "-"
            }
            else{
                cell.label_docnumber.text = need?.doc_no
            }
            if need?.subject == "" {
                cell.label_topic.text = "-"
            }
            else{
                cell.label_topic.text = need?.subject
            }
            cell.label_budget.text = "\(String((need?.total)!)) \("baht".localized(gb.lang_now))"
            cell.label_date.text = need?.date
            
            if need?.mny_request_type_id == "EP" {
                cell.label_type.textColor = gb.color_EP
            }
            else if need?.mny_request_type_id == "CR" {
                cell.label_type.textColor = gb.color_CR
            }
            else if need?.mny_request_type_id == "PR" {
                cell.label_type.textColor = gb.color_PR
            }
            else {
                cell.label_type.textColor = gb.color_EL
            }
            
            cell.view_cell.layer.cornerRadius = 8.0
            cell.view_cell.layer.borderWidth = 0.0
            cell.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.view_cell.layer.shadowRadius = 2.0
            cell.view_cell.layer.shadowOpacity = 1
            cell.view_cell.layer.masksToBounds = false
            
            return cell
        }
        else if tableView == table_approve {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApproveTableViewCell
            let approve = needApprove?.data![indexPath.row]
            cell.position.text = approve?.mny_permission_name
            
            cell.label_person.text = "person".localized(gb.lang_now)
            cell.label_status.text = "status".localized(gb.lang_now)
            cell.label_date.text = "date".localized(gb.lang_now)
            
            if approve?.firstname == nil {
                cell.name.text = "-"
            }
            else {
                cell.name.text = "\(String((approve?.firstname)!)) \(String((approve?.lastname)!))"
            }
            
            if approve?.mny_request_approve_comment == nil {
                cell.status.text = "-"
            }
            else {
                cell.status.text = approve?.mny_request_approve_comment
            }
            
            if approve?.mny_request_approve_datetime == nil {
                cell.date.text = "-"
            }
            else {
                cell.date.text = approve?.mny_request_approve_datetime
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PopupTableViewCell
            cell!.lbl.text = settingArray[indexPath.row]
            let symbol = UIImage.SymbolConfiguration(pointSize: 80, weight: .thin, scale: .large)
            let icon = UIImage(systemName: settingIcon[indexPath.row], withConfiguration: symbol)
            cell!.settingImage.image = icon
            cell!.selectionStyle = .none
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == table_need {
            needSelected = needLists?.list_request![indexPath.row]
            if needSelected?.apv_status == nil {
                settingArray = menu_name2
                settingIcon  = menu_icon2
                table_height = 225
            }
            else {
                settingArray = menu_name1
                settingIcon  = menu_icon1
                table_height = 150
            }
            table_popup.reloadData()
            
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
        else if tableView == table_approve {
            print("Nothings")
        }
        else{
            if needSelected?.apv_status == nil {
                if indexPath.row == 2 {
                    deleteNeed()
                }
                else if indexPath.row == 1{
                    getApproveList()
                }
                else{
                    onClickTransparentView()
                    send_type = "edit"
                    UIApplication.shared.sendAction(bar_button_add.action!, to: bar_button_add.target, from: self, for: nil)
                }
            }
            else {
                if indexPath.row == 1 {
                    deleteNeed()
                }
                else if indexPath.row == 0{
                    getApproveList()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == table_need {
            return 140
        }
        else if tableView == table_approve {
            return 110
        }
        else{
            return 75
        }
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.table_popup.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.table_height)
        }, completion: nil)
        view_approve.isHidden = true
    }
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit_need" {
            let sb = segue.destination as! Add_Need_Page1_VC
            sb.sended_data = needSelected
            sb.sended_type = send_type
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
