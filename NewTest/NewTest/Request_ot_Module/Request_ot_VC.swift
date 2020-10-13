//
//  Request_ot_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 19/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class Request_ot_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var collection_user: UICollectionView!
    @IBOutlet weak var tableview_request_ot: UITableView!
    @IBOutlet weak var fake_btn: UIButton!
    
    var user:UserLoginDao? = nil
    var underUsers:UnderUsers? = nil
    var underUser:UnderUser? = nil
    var requestOTLists:RequestOTLists? = nil
    var requestOTList:RequestOTList? = nil
    var selected_emp:selectedEmp? = nil
    var image_array : [UIImage] = []
    var name_array : [String] = []
    var user_id_array : [String] = []
    var user_comp_array : [String] = []
    var firstname_array : [String] = []
    var lastname_array : [String] = []
    var first_user = true
    var first_load = true
    var selectedIndexPath: IndexPath?
    var selected_emp_id = ""
    var selected_emp_comp = ""
    var send_type = "add"
    var same_img : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        self.title = "title_request_ot".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        view.backgroundColor = gb.color_background
        gb.now_vc = "request_ot"
        user = gb.user
        selected_emp_id = (gb.user?.emp_id)!
        selected_emp_comp = (gb.user?.comp_id)!
        selected_emp = selectedEmp(
            emp_id: (gb.user?.emp_id)!,
            comp_id: (gb.user?.comp_id)!,
            f_name: (gb.user?.firstname)!,
            l_name: (gb.user?.lastname)!
        )
        
        tableview_request_ot.delegate = self
        tableview_request_ot.dataSource = self
        tableview_request_ot.rowHeight = 150.0
        tableview_request_ot.refreshControl = nil
        
        collection_user.layer.shadowOffset = CGSize(width: 0, height: 2)
        collection_user.layer.shadowRadius = 3
        collection_user.layer.shadowOpacity = 1
        collection_user.layer.shadowColor = UIColor.lightGray.cgColor
        collection_user.clipsToBounds = false
        collection_user.layer.masksToBounds = false
        
        setUnderUser()
        setupSideMenu()
        updateMenus()
        first_load = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !first_load {
            showLoad()
            getRequestOT()
        }
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
                    self.firstname_array = []
                    self.lastname_array = []
                    var imageString = ""
                    if gb.user?.emp_pic == nil {
                        imageString = "\(Const_Var.BASE_URL)images/default.png"
                    }
                    else{
                        imageString = "\(Const_Var.BASE_URL)\(String(((gb.user?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!)))"
                        imageString = imageString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
                        
                    }
                    print(imageString)
                    let url = URL(string: imageString)
                    let data = try Data(contentsOf: url!)
                    self.image_array.append(UIImage(data: data)!)
                    self.name_array.append("me".localized(gb.lang_now))
                    self.user_id_array.append((gb.user?.emp_id)!)
                    self.user_comp_array.append((gb.user?.comp_id)!)
                    self.firstname_array.append((gb.user?.firstname)!)
                    self.lastname_array.append((gb.user?.lastname)!)
                    
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
                                    self.firstname_array.append((under_user.firstname)!)
                                    self.lastname_array.append((under_user.lastname)!)
                                }
                                else {
                                    self.name_array.append(under_user.firstname_th!)
                                    self.firstname_array.append((under_user.firstname_th)!)
                                    self.lastname_array.append((under_user.lastname_th)!)
                                }
                            }
                        }
                    }
                    self.collection_user.reloadData()
                    self.getRequestOT()
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getRequestOT(){
        let postString = "user=\(gb.username)&pass=\(gb.password)&emp_id=\(String(selected_emp!.emp_id))&comp_id=\(String(selected_emp!.comp_id))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_REQUEST_OT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.requestOTLists = try JSONDecoder().decode(RequestOTLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    self.tableview_request_ot.reloadData()
                    self.closeLoad()
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    @IBAction func tap_add(_ sender: Any) {
        send_type = "add"
        fake_btn.sendActions(for: .touchUpInside)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cc", for: indexPath) as! RequestOT_CC
        cell.image_user.image = image_array[indexPath.row]
        cell.label_user.text = name_array[indexPath.row]
        
        cell.label_user.textColor = UIColor.darkGray
        cell.image_user.layer.borderColor = gb.color_darkgrey_a6.cgColor
        cell.image_user.layer.borderWidth = 2
        
        if first_user{
            cell.label_user.textColor = UIColor.systemOrange
            cell.image_user.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_user.layer.borderWidth = 2
            selectedIndexPath = indexPath
            first_user = false
        }
        
        if indexPath.row == selectedIndexPath!.row {
            cell.label_user.textColor = UIColor.systemOrange
            cell.image_user.layer.borderColor = gb.color_orenge_a6.cgColor
            cell.image_user.layer.borderWidth = 2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showLoad()
        let cell = collectionView.cellForItem(at: indexPath) as! RequestOT_CC
        self.selectedIndexPath = indexPath
        selected_emp?.emp_id = user_id_array[indexPath.row]
        selected_emp?.comp_id = user_comp_array[indexPath.row]
        selected_emp?.f_name = firstname_array[indexPath.row]
        selected_emp?.l_name = lastname_array[indexPath.row]
        
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for index in visibleIndexPaths {
            let cell_1 = collectionView.cellForItem(at: index) as! RequestOT_CC
            cell_1.label_user.textColor = UIColor.darkGray
            cell_1.image_user.layer.borderColor = gb.color_darkgrey_a6.cgColor
            cell_1.image_user.layer.borderWidth = 2
        }
        
        cell.label_user.textColor = UIColor.systemOrange
        cell.image_user.layer.borderColor = gb.color_orenge_a6.cgColor
        cell.image_user.layer.borderWidth = 2
        selectedIndexPath = indexPath
        same_img = nil
        getRequestOT()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if requestOTLists?.msg != nil {
            row = (requestOTLists?.msg!.count)!
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestOTList = requestOTLists?.msg![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! RequestOT_TC
        var reason = ""
        var status = ""
        var approve = ""
        var status_color = gb.color_ot_orenge

        if requestOTList?.ot_reason == nil {
            reason = "-"
        }
        else {
            reason = String((requestOTList?.ot_reason)!)
        }

        if requestOTList?.upper_name == nil {
            approve = "-"
        }
        else {
            approve = (requestOTList?.upper_name)!
        }

        let status_rq = requestOTList?.ot_status
        if status_rq == "0" {
            status = "pending".localized(gb.lang_now)
            status_color = gb.color_ot_yellow
        }
        else if status_rq == "1" {
            status = "approve".localized(gb.lang_now)
            status_color = gb.color_ot_green
        }
        else if status_rq == "2" {
            status = "not_approve".localized(gb.lang_now)
            status_color = gb.color_ot_red
        }
        else if status_rq == "3" {
            status = "need_info".localized(gb.lang_now)
            status_color = gb.color_ot_blue
        }
        else if status_rq == "4" {
            status = "wait_delete".localized(gb.lang_now)
            status_color = gb.color_ot_orenge
        }
        else{
            status = "no_status".localized(gb.lang_now)
            status_color = gb.color_ot_orenge
        }

        cell.label_status.backgroundColor = status_color
        cell.selectionStyle = .none
        cell.label_reason.text = reason
        cell.label_datetime.text = "\(String(DateStringForDisplay(datetime : (requestOTList?.request_ot_in)!))) - \(String(DateStringForDisplay(datetime : (requestOTList?.request_ot_out)!)))"
        cell.label_rq_num.text = requestOTList?.request_run_no
        cell.label_status.text = status
        cell.label_approve.text = approve
        cell.label_emp.text = requestOTList?.emp_info

        cell.view_cell.layer.cornerRadius = 8.0
        cell.view_cell.layer.borderWidth = 0.0
        cell.view_cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.view_cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.view_cell.layer.shadowRadius = 2.0
        cell.view_cell.layer.shadowOpacity = 1
        cell.view_cell.layer.masksToBounds = false

        cell.label_status.layer.cornerRadius = 10.0
        cell.label_status.layer.masksToBounds = true
        
        if same_img == nil{
            do{
                let imageString = "\(Const_Var.BASE_URL)\(String(((requestOTList?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!)))"
                let url = URL(string: imageString)
                let data = try Data(contentsOf: url!)
                same_img = UIImage(data: data)!
            }
            catch{

            }
        }
        cell.img_emp.image = same_img
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        requestOTList = requestOTLists?.msg![indexPath.row]
        if requestOTList?.ot_status != "1" && requestOTList?.ot_status != "2" {
            send_type = "edit"
            fake_btn.sendActions(for: .touchUpInside)
        }
    }
    
    func DateStringForDisplay(datetime : String) -> String{
        let date_formatter = DateFormatter()
        let date_formatter2 = DateFormatter()
        date_formatter.locale = Locale(identifier: "en_US_POSIX")
        date_formatter2.locale = Locale(identifier: "en_US_POSIX")
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date_formatter2.dateFormat = "yyyy/MM/dd HH:mm"
        
        let to_date = date_formatter.date(from: datetime)!
        let to_string = date_formatter2.string(from: to_date)
        return to_string
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_add_ot"{
            let sb = segue.destination as! Request_ot_add_VC
            if send_type == "edit"{
                sb.requestOTList = requestOTList
            }
            sb.selected_emp = selected_emp
            sb.send_type = send_type
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

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
