//
//  InfoAccount_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 29/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import FontAwesome_swift

class InfoAccount_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var table_contact: UITableView!
    @IBOutlet weak var table_project: UITableView!
    @IBOutlet weak var table_activity: UITableView!
    @IBOutlet weak var view_account: UIView!
    @IBOutlet weak var bar_edit: UIBarButtonItem!
    @IBOutlet weak var image_account: UIImageView!
    @IBOutlet weak var label_comp_en: UILabel!
    @IBOutlet weak var label_comp_th: UILabel!
    @IBOutlet weak var label_type_status: UILabel!
    @IBOutlet weak var label_code: UILabel!
    @IBOutlet weak var label_mobile: UILabel!
    @IBOutlet weak var label_work: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_fax: UILabel!
    @IBOutlet weak var image_owner: UIImageView!
    @IBOutlet weak var label_owner: UILabel!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_comp_size: UILabel!
    @IBOutlet weak var label_regist: UILabel!
    @IBOutlet weak var label_capital: UILabel!
    @IBOutlet weak var label_staff_num: UILabel!
    @IBOutlet weak var label_payment: UILabel!
    @IBOutlet weak var label_tax_id: UILabel!
    @IBOutlet weak var label_old_code: UILabel!
    @IBOutlet weak var label_ship: UILabel!
    @IBOutlet weak var label_doc_address: UILabel!
    @IBOutlet weak var ic_mobile: UIImageView!
    @IBOutlet weak var ic_tel: UIImageView!
    @IBOutlet weak var ic_email: UIImageView!
    @IBOutlet weak var ic_fax: UIImageView!
    @IBOutlet weak var ic_owner: UIImageView!
    @IBOutlet weak var ic_location_1: UIImageView!
    @IBOutlet weak var ic_location_2: UIImageView!
    @IBOutlet weak var ic_location_3: UIImageView!
    @IBOutlet weak var ic_location_4: UIImageView!
    @IBOutlet weak var tab_button_1: UIButton!
    @IBOutlet weak var tab_button_2: UIButton!
    @IBOutlet weak var tab_button_3: UIButton!
    @IBOutlet weak var tab_button_4: UIButton!
    @IBOutlet weak var image_map_location: UIImageView!
    @IBOutlet weak var txt_mobile: UILabel!
    @IBOutlet weak var txt_work: UILabel!
    @IBOutlet weak var txt_email: UILabel!
    @IBOutlet weak var txt_fax: UILabel!
    @IBOutlet weak var txt_owner: UILabel!
    @IBOutlet weak var txt_address: UILabel!
    @IBOutlet weak var txt_descrip: UILabel!
    @IBOutlet weak var txt_com_size: UILabel!
    @IBOutlet weak var txt_regist: UILabel!
    @IBOutlet weak var txt_regist_cap: UILabel!
    @IBOutlet weak var txt_number_staff: UILabel!
    @IBOutlet weak var txt_payment: UILabel!
    @IBOutlet weak var txt_tax: UILabel!
    @IBOutlet weak var txt_old_code: UILabel!
    @IBOutlet weak var txt_ship: UILabel!
    @IBOutlet weak var txt_doc: UILabel!
    @IBOutlet weak var txt_map_image: UILabel!
    @IBOutlet weak var map_image_height: NSLayoutConstraint!
    @IBOutlet weak var view_scroll_height: NSLayoutConstraint!
    @IBOutlet weak var view_scroll: UIView!
    @IBOutlet weak var button_cus_map: UIButton!
    @IBOutlet weak var button_ship_map: UIButton!
    @IBOutlet weak var button_doc_map: UIButton!
    @IBOutlet weak var icon_mobile: UIImageView!
    @IBOutlet weak var icon_tel: UIImageView!
    @IBOutlet weak var icon_email: UIImageView!
    @IBOutlet weak var icon_fax: UIImageView!
    @IBOutlet weak var icon_owner: UIImageView!
    
    
    var accountList:AccountList? = nil
    var accountContacts:AccountContacts? = nil
    var accountContact:AccountContact? = nil
    var accountProjects:AccountProjects? = nil
    var accountProject:AccountProject? = nil
    var accountActivitys:AccountActivitys? = nil
    var accountActivity:AccountActivity? = nil
    var moreContacts:AccountContacts? = nil
    var moreProjects:AccountProjects? = nil
    var moreActivitys:AccountActivitys? = nil
    var addressTxt:AddressTxt? = nil
    var icon_size = 35
    var row_contact = 0
    var row_project = 0
    var row_activity = 0
    var icon = UIImage()
    var contact_image = [UIImage]()
    var activity_image = [UIImage]()
    var index_contact = 0
    var index_project = 0
    var index_activity = 0
    let searchController1 = UISearchController(searchResultsController: nil)
    let searchController2 = UISearchController(searchResultsController: nil)
    let searchController3 = UISearchController(searchResultsController: nil)
    var refreshControl1 = UIRefreshControl()
    var refreshControl2 = UIRefreshControl()
    var refreshControl3 = UIRefreshControl()
    var txt_search = ""
    var comfirm_search = ""
    var active_page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "account_detail".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        showLoad()
        initLayout()
        initTab()
        initIcon()
        setLang()
        tabButton(tab: 1)
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .thin, scale: .medium)
        icon = UIImage(systemName: "person.circle.fill", withConfiguration: iconConfig)!
        
        table_contact.delegate = self
        table_contact.dataSource = self
        table_contact.rowHeight = 70
        table_project.delegate = self
        table_project.dataSource = self
        table_project.rowHeight = 100
        table_activity.delegate = self
        table_activity.dataSource = self
        table_activity.rowHeight = 140
        
        image_account.layoutIfNeeded()
        image_account.layer.cornerRadius = image_account.frame.height / 2
        image_account.layer.borderColor = gb.color_darkgrey_a6.cgColor
        image_account.layer.borderWidth = 3
        image_account.clipsToBounds = true

        setLabelData()
        
        searchController1.searchResultsUpdater = self
        searchController1.hidesNavigationBarDuringPresentation = false
        searchController1.searchBar.delegate = self
        searchController1.searchBar.enablesReturnKeyAutomatically = false
        
        searchController2.searchResultsUpdater = self
        searchController2.hidesNavigationBarDuringPresentation = false
        searchController2.searchBar.delegate = self
        searchController2.searchBar.enablesReturnKeyAutomatically = false
        
        searchController3.searchResultsUpdater = self
        searchController3.hidesNavigationBarDuringPresentation = false
        searchController3.searchBar.delegate = self
        searchController3.searchBar.enablesReturnKeyAutomatically = false
        
        table_contact.tableHeaderView = searchController1.searchBar
        table_project.tableHeaderView = searchController2.searchBar
        table_activity.tableHeaderView = searchController3.searchBar
        
        refreshControl1.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl1.addTarget(self, action: #selector(self.refresh1(_:)), for: .valueChanged)
        table_contact.addSubview(refreshControl1)
        
        refreshControl2.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl2.addTarget(self, action: #selector(self.refresh2(_:)), for: .valueChanged)
        table_project.addSubview(refreshControl2)
        
        refreshControl3.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl3.addTarget(self, action: #selector(self.refresh3(_:)), for: .valueChanged)
        table_activity.addSubview(refreshControl3)
    }
    
    func initLayout(){
        label_comp_en.textColor = gb.color_darkgrey
        label_comp_th.textColor = gb.color_lightgrey
        label_type_status.textColor = gb.color_lightgrey
        label_code.textColor = gb.color_lightgrey
        label_mobile.textColor = gb.color_main
        label_work.textColor = gb.color_main
        label_email.textColor = gb.color_darkgrey
        label_fax.textColor = gb.color_darkgrey
        label_owner.textColor = gb.color_darkgrey
        label_address.textColor = gb.color_darkgrey
        label_description.textColor = gb.color_darkgrey
        label_comp_size.textColor = gb.color_darkgrey
        label_regist.textColor = gb.color_darkgrey
        label_capital.textColor = gb.color_darkgrey
        label_staff_num.textColor = gb.color_darkgrey
        label_payment.textColor = gb.color_darkgrey
        label_tax_id.textColor = gb.color_darkgrey
        label_old_code.textColor = gb.color_darkgrey
        label_ship.textColor = gb.color_darkgrey
        label_doc_address.textColor = gb.color_darkgrey
        
        txt_mobile.textColor = gb.color_lightgrey
        txt_work.textColor = gb.color_lightgrey
        txt_email.textColor = gb.color_lightgrey
        txt_fax.textColor = gb.color_lightgrey
        txt_owner.textColor = gb.color_lightgrey
        txt_address.textColor = gb.color_lightgrey
        txt_descrip.textColor = gb.color_lightgrey
        txt_com_size.textColor = gb.color_lightgrey
        txt_regist.textColor = gb.color_lightgrey
        txt_regist_cap.textColor = gb.color_lightgrey
        txt_number_staff.textColor = gb.color_lightgrey
        txt_payment.textColor = gb.color_lightgrey
        txt_tax.textColor = gb.color_lightgrey
        txt_old_code.textColor = gb.color_lightgrey
        txt_ship.textColor = gb.color_lightgrey
        txt_doc.textColor = gb.color_lightgrey
        txt_map_image.textColor = gb.color_lightgrey
    }
    
    @objc func refresh1(_ sender: AnyObject) {
       txt_search = ""
       index_contact = 0
       showLoad()
       getContact()
       refreshControl1.endRefreshing()
    }
    
    @objc func refresh2(_ sender: AnyObject) {
       txt_search = ""
       index_project = 0
       showLoad()
       getProject()
       refreshControl2.endRefreshing()
    }
    
    @objc func refresh3(_ sender: AnyObject) {
       txt_search = ""
       index_activity = 0
       showLoad()
       getActivity()
       refreshControl3.endRefreshing()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        txt_search = searchController.searchBar.text!
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoad()
        comfirm_search = txt_search
        if active_page == 2 {
            getContact()
            searchController1.isActive = false
        }
        else if active_page == 3 {
            getProject()
            searchController2.isActive = false
        }
        else if active_page == 4 {
            getActivity()
            searchController3.isActive = false
        }
        
    }
    
    func getContact(){
        index_contact = 0
        let postString = "cus_id=\(String((accountList?.cus_id)!))&index=0&search=\(String(txt_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_CONTACT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.accountContacts = try JSONDecoder().decode(AccountContacts.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.accountContacts?.data != nil {
                    self.row_contact = (self.accountContacts?.data!.count)!
                    self.loadContactImage()
                }
                else{
                    self.row_contact = 0
                    self.table_contact.reloadData()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func loadContactImage(){
        contact_image = [UIImage]()
        for item in self.accountContacts!.data! {
            if item.cus_cont_photo != nil && item.cus_cont_photo != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)crm/\(String(item.cus_cont_photo!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.contact_image.append(im)
                        }
                        catch{
                            self.contact_image.append(UIImage())
                        }
                    }
                    else{
                        self.contact_image.append(UIImage())
                    }
                }
                catch{
                    self.contact_image.append(UIImage())
                }
            }
            else {
                self.contact_image.append(UIImage())
            }
        }
        table_contact.reloadData()
        closeLoad()
    }
    
    func moreContact(index: Int){
        let postString = "cus_id=\(String((accountList?.cus_id)!))&index=\(String(index))&search=\(String(comfirm_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_CONTACT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.moreContacts = try JSONDecoder().decode(AccountContacts.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.moreContacts?.data != nil {
                    for item in self.moreContacts!.data! {
                        self.accountContacts?.data?.append(item)
                    }
                    self.row_contact = (self.accountContacts?.data!.count)!
                    self.moreContactImage()
                }
                else{
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func moreContactImage(){
        for item in self.moreContacts!.data! {
            if item.cus_cont_photo != nil && item.cus_cont_photo != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)crm/\(String(item.cus_cont_photo!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.contact_image.append(im)
                        }
                        catch{
                            self.contact_image.append(UIImage())
                        }
                    }
                    else{
                        self.contact_image.append(UIImage())
                    }
                }
                catch{
                    self.contact_image.append(UIImage())
                }
            }
            else {
                self.contact_image.append(UIImage())
            }
        }
        table_contact.reloadData()
        closeLoad()
    }
    
    func getProject(){
        index_project = 0
        let postString = "cus_id=\(String((accountList?.cus_id)!))&index=0&search=\(String(txt_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_PROJECT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.accountProjects = try JSONDecoder().decode(AccountProjects.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.accountProjects?.data != nil {
                    self.row_project = (self.accountProjects?.data!.count)!
                }
                else {
                    self.row_project = 0
                }
                self.table_project.reloadData()
                self.closeLoad()
            }
        }
        task.resume()
    }
    
    func moreProject(index: Int){
        let postString = "cus_id=\(String((accountList?.cus_id)!))&index=\(String(index))&search=\(String(comfirm_search))"
        print("More project : \(postString)")
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_PROJECT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.moreProjects = try JSONDecoder().decode(AccountProjects.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.moreProjects?.data != nil {
                    for item in self.moreProjects!.data! {
                        self.accountProjects?.data?.append(item)
                    }
                    self.row_project = (self.accountProjects?.data!.count)!
                }
                self.table_project.reloadData()
                self.closeLoad()
            }
        }
        task.resume()
    }
    
    func getActivity(){
        index_activity = 0
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&cus_id=\(String((accountList?.cus_id)!))&index=0&search=\(String(txt_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.accountActivitys = try JSONDecoder().decode(AccountActivitys.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.accountActivitys?.data != nil {
                    self.row_activity = (self.accountActivitys?.data!.count)!
                    self.loadActivityImage()
                }
                else {
                    self.row_activity = 0
                    self.table_activity.reloadData()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func loadActivityImage(){
        activity_image = [UIImage]()
        for item in self.accountActivitys!.data! {
            if item.emp_pic != nil && item.emp_pic != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)\(String(item.emp_pic!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.activity_image.append(im)
                        }
                        catch{
                            self.activity_image.append(UIImage())
                        }
                    }
                    else{
                        self.activity_image.append(UIImage())
                    }
                }
            }
            else {
                self.activity_image.append(UIImage())
            }
        }
        table_activity.reloadData()
        closeLoad()
    }
    
    func moreActivity(index: Int){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&cus_id=\(String((accountList?.cus_id)!))&index=\(String(index))&search=\(String(comfirm_search))"
        print("More activity : \(postString)")
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.moreActivitys = try JSONDecoder().decode(AccountActivitys.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.moreActivitys?.data != nil {
                    for item in self.moreActivitys!.data! {
                        self.accountActivitys?.data?.append(item)
                    }
                    self.row_activity = (self.accountActivitys?.data!.count)!
                    self.moreActivityImage()
                }
                else{
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func moreActivityImage(){
        for item in self.moreActivitys!.data! {
            if item.emp_pic != nil && item.emp_pic != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)\(String(item.emp_pic!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.activity_image.append(im)
                        }
                        catch{
                            self.activity_image.append(UIImage())
                        }
                    }
                    else{
                        self.activity_image.append(UIImage())
                    }
                }
                catch{
                    self.activity_image.append(UIImage())
                }
            }
            else {
                self.activity_image.append(UIImage())
            }
        }
        table_activity.reloadData()
        closeLoad()
    }
    
    func setLabelData(){
        let ac = accountList
        var str_post = ac?.post_id ?? ""
        if str_post == "0" {
            str_post = " "
        }
        
        var road = ac?.cus_txtroad ?? ""
        var soi  = ac?.cus_txtsoi ?? ""
        var build = ac?.cus_txtbuilding ?? ""
        
        if gb.lang_now == "en"{
            if road != "" && road != "-"{
                road = "\(road) Road"
            }
            if soi != "" && soi != "-"{
                soi = "\(soi) Lane"
            }
            if build != "" && build != "-"{
                build = "\(build) Building"
            }
        }
        else{
            if road != "" && road != "-"{
                road = "ถนน\(road)"
            }
            if soi != "" && soi != "-"{
                soi = "ซอย \(soi)"
            }
            if build != "" && build != "-"{
                build = "ตึก\(build)"
            }
        }
        
        let address = "\(ac?.cus_address_th ?? "") \(soi) \(road) \(build)"
        getAddressTxt(country_id: ac?.country_id ?? "", province_id: ac?.province_id ?? "", district: ac?.district_id ?? "", subdistrict: ac?.sub_district_id ?? "",adrs: address,post_id:str_post)
        

//        let check_address = address.replacingOccurrences(of: " ", with: "")
//        if check_address == "" {
//            address = "-"
//        }
        label_type_status.text  = "\(String(emptyTextfield(para: ac?.cus_group_name ?? ""))) - \(String(emptyTextfield(para: ac?.cus_type_name ?? "")))"
        label_owner.text        = "\(emptyTextfield(para: ac?.firstname ?? "")) \(emptyTextfield(para: ac?.lastname ?? ""))"
        label_comp_en.text      = emptyTextfield(para: ac?.cus_name_en ?? "")
        label_comp_th.text      = emptyTextfield(para: ac?.cus_name_th ?? "")
        label_code.text         = emptyTextfield(para: ac?.cus_code ?? "")
        label_mobile.text       = emptyTextfield(para: "\(ac?.cus_mob_no ?? "")")
        label_work.text         = emptyTextfield(para: "\(ac?.cus_tel_no ?? "")")
        label_email.text        = emptyTextfield(para: ac?.cus_email ?? "")
        label_fax.text          = emptyTextfield(para: "\(ac?.cus_fax_no ?? "")")
        label_description.text  = emptyTextfield(para: ac?.cus_description ?? "")
        label_comp_size.text    = emptyTextfield(para: ac?.cus_size ?? "")
        label_regist.text       = emptyTextfield(para: ac?.cus_status_name ?? "")
        label_capital.text      = emptyTextfield(para: ac?.cus_cost_register ?? "")
        label_staff_num.text    = emptyTextfield(para: ac?.cus_all_staff ?? "")
        label_payment.text      = emptyTextfield(para: ac?.cus_type_doc_name ?? "")
        label_tax_id.text       = emptyTextfield(para: ac?.cus_tax_no ?? "")
        label_old_code.text     = emptyTextfield(para: ac?.cus_code_old ?? "")
        label_ship.text         = emptyTextfield(para: ac?.ship_address ?? "")
        label_doc_address.text  = emptyTextfield(para: ac?.doc_address ?? "")
        
        label_mobile.isUserInteractionEnabled = true
        label_work.isUserInteractionEnabled = true
        let call_mobile: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCallMobile))
        label_mobile.addGestureRecognizer(call_mobile)
        let call_work: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCallWork))
        label_work.addGestureRecognizer(call_work)
        
        if (ac?.cus_latitude == "0.0" && ac?.cus_longtitude == "0.0") || (ac?.cus_latitude == nil && ac?.cus_longtitude == nil) {
            button_cus_map.isHidden = true
        }
        else {
            button_cus_map.isHidden = false
        }
        
        if (ac?.ship_latitude == "0.0" && ac?.ship_longtitude == "0.0") || (ac?.ship_latitude == nil && ac?.ship_longtitude == nil){
            button_ship_map.isHidden = true
        }
        else {
            button_ship_map.isHidden = false
        }
        
        if (ac?.doc_latitude == "0.0" && ac?.doc_longtitude == "0.0") || (ac?.doc_latitude == nil && ac?.doc_longtitude == nil) {
            button_doc_map.isHidden = true
        }
        else {
            button_doc_map.isHidden = false
        }
        
        var image_account_str = ""
        if ac?.cus_logo == nil {
            image_account.image = UIImage()
        }
        else{
            image_account_str = "\(Const_Var.BASE_URL)crm/\(String(((ac?.cus_logo!.replacingOccurrences(of: "\\", with: ""))!)))"
            image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
            image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
            image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            do{
                let url = URL(string: image_account_str)
                let data = try Data(contentsOf: url!)
                let im = UIImage(data: data) ?? UIImage()
                image_account.image = im
            }
            catch{
                print(error)
            }
        }
        
        
        var imageString = ""
        if ac?.emp_pic == nil {
            imageString = "\(Const_Var.BASE_URL)images/default.png"
        }
        else{
            imageString = "\(Const_Var.BASE_URL)\(String(((ac?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!)))"
            imageString = imageString.replacingOccurrences(of: " ", with: "%20")
            imageString = imageString.replacingOccurrences(of: "+", with: "%2B")
        }
        do{
            let url = URL(string: imageString)
            let data = try Data(contentsOf: url!)
            image_owner.image = UIImage(data: data)!
        }
        catch{
            print(error)
        }
        
        var image_map_str = ""
        if ac?.cus_map == nil || ac?.cus_map == ""{
            image_map_location.backgroundColor = UIColor.clear
            map_image_height.constant = 0
            view_scroll_height.constant = 1400
            view.layoutIfNeeded()
        }
        else{
            image_map_str = "\(Const_Var.BASE_URL)crm/\(String(((ac?.cus_map!.replacingOccurrences(of: "\\", with: ""))!)))"
            image_map_str = image_map_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            image_map_str = image_map_str.replacingOccurrences(of: " ", with: "%20")
            image_map_str = image_map_str.replacingOccurrences(of: "+", with: "%2B")
            do{
                let url = URL(string: image_map_str)
                if url != nil {
                    let data = try Data(contentsOf: url!)
                    let im = UIImage(data: data) ?? UIImage()
                    image_map_location.image = im
                    map_image_height.constant = 150
                    view_scroll_height.constant = 1550
                    view.layoutIfNeeded()
                }
                else {
                    map_image_height.constant = 0
                    view_scroll_height.constant = 1400
                    view.layoutIfNeeded()
                }
            }
            catch{
                print(error)
            }
        }
        closeLoad()
    }
    
    func getAddressTxt(country_id:String,province_id:String,district:String,subdistrict:String,adrs:String,post_id:String){
        let postString = "country=\(String(country_id))&province=\(String(province_id))&district=\(String(district))&subdistrict=\(String(subdistrict))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ADDRESS_TXT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.addressTxt = try JSONDecoder().decode(AddressTxt.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                var ct = ""
                var pv = ""
                var dt = ""
                var st = ""
                if self.addressTxt?.country != nil {
                    ct    = self.addressTxt?.country?.first?.name ?? ""
                }
                if self.addressTxt?.province != nil {
                    pv = self.addressTxt?.province?.first?.name ?? ""
                
                }
                if self.addressTxt?.district != nil {
                    dt = self.addressTxt?.district?.first?.name ?? ""
                
                }
                if self.addressTxt?.sub_district != nil {
                    st = self.addressTxt?.sub_district?.first?.name ?? ""
                }
                
                var address = "\(adrs) \(st) \(dt) \(pv) \(post_id) \(ct)"
                let check_address = address.replacingOccurrences(of: " ", with: "")
                if check_address == "" {
                    address = "-"
                }
                 self.label_address.text      = address
            }
        }
        task.resume()
    }
    
    @objc func tapCallMobile() {
        let phone = label_mobile.text
        let phone_call = phone!.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(String(phone_call))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func tapCallWork() {
        let phone = label_work.text
        let phone_call = phone!.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(String(phone_call))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func emptyTextfield(para:String)->String{
        if para == "" {
            return "-"
        }
        else {
            return para
        }
    }
    
    func emptyCoor(para:String)->String{
        if para == "" {
            return "0.0"
        }
        else {
            return para
        }
    }
    
    func tabChange(send_case:Int){
        view_account.isHidden = true
        table_contact.isHidden = true
        table_project.isHidden = true
        table_activity.isHidden = true
        bar_edit.isEnabled = false
        bar_edit.tintColor = UIColor.clear
        
        if send_case == 0 {
            view_account.isHidden = false
            bar_edit.isEnabled = true
            bar_edit.tintColor = UIColor.white
        }
        else if send_case == 1 {
            table_contact.isHidden = false
        }
        else if send_case == 2 {
            table_project.isHidden = false
        }
        else {
            table_activity.isHidden = false
        }
        
    }
    
    func initIcon(){
        button_cus_map.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        button_ship_map.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        button_doc_map.setImage(UIImage.fontAwesomeIcon(name: .mapMarkerAlt, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        
        icon_mobile.image = UIImage.fontAwesomeIcon(name: .mobileAlt, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_tel.image = UIImage.fontAwesomeIcon(name: .phoneAlt, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_email.image = UIImage.fontAwesomeIcon(name: .envelope, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_fax.image = UIImage.fontAwesomeIcon(name: .fax, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
        icon_owner.image = UIImage.fontAwesomeIcon(name: .key, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size))
    }
    
    func initTab(){
        tab_button_1.setTitle("title_account".localized(gb.lang_now), for: .normal)
        tab_button_2.setTitle("title_contact".localized(gb.lang_now), for: .normal)
        tab_button_3.setTitle("title_project".localized(gb.lang_now), for: .normal)
        tab_button_4.setTitle("title_activity".localized(gb.lang_now), for: .normal)
        
        tab_button_1.alignVertical()
        tab_button_2.alignVertical()
        tab_button_3.alignVertical()
        tab_button_4.alignVertical()
    }
    
    func tabButton(tab:Int){
        tab_button_1.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_button_2.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_button_3.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_button_4.setTitleColor(gb.color_lightgrey, for: .normal)
        tab_button_1.tintColor = gb.color_lightgrey
        tab_button_2.tintColor = gb.color_lightgrey
        tab_button_3.tintColor = gb.color_lightgrey
        tab_button_4.tintColor = gb.color_lightgrey
        
        tab_button_1.setImage(UIImage.fontAwesomeIcon(name: .building, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        tab_button_2.setImage(UIImage.fontAwesomeIcon(name: .userCircle, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        tab_button_3.setImage(UIImage.fontAwesomeIcon(name: .filePowerpoint, style: .light, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        tab_button_4.setImage(UIImage.fontAwesomeIcon(name: .child, style: .solid, textColor: gb.color_lightgrey, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
        
        if tab == 1 {
            active_page = 1
            tab_button_1.setTitleColor(gb.color_main, for: .normal)
            tab_button_1.setImage(UIImage.fontAwesomeIcon(name: .building, style: .light, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
            tab_button_1.tintColor = gb.color_main
            self.title = "title_account".localized(gb.lang_now)
        }
        else if tab == 2 {
            active_page = 2
            txt_search = ""
            comfirm_search = txt_search
            showLoad()
            getContact()
            tab_button_2.setTitleColor(gb.color_main, for: .normal)
            tab_button_2.setImage(UIImage.fontAwesomeIcon(name: .userCircle, style: .light, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
            tab_button_2.tintColor = gb.color_main
            self.title = "title_contact".localized(gb.lang_now)
        }
        else if tab == 3 {
            active_page = 3
            txt_search = ""
            comfirm_search = txt_search
            showLoad()
            getProject()
            tab_button_3.setTitleColor(gb.color_main, for: .normal)
            tab_button_3.setImage(UIImage.fontAwesomeIcon(name: .filePowerpoint, style: .light, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
            tab_button_3.tintColor = gb.color_main
            self.title = "title_project".localized(gb.lang_now)
        }
        else {
            active_page = 4
            txt_search = ""
            comfirm_search = txt_search
            showLoad()
            getActivity()
            tab_button_4.setTitleColor(gb.color_main, for: .normal)
            tab_button_4.setImage(UIImage.fontAwesomeIcon(name: .child, style: .solid, textColor: gb.color_main, size: CGSize(width: icon_size, height: icon_size)), for: .normal)
            tab_button_4.tintColor = gb.color_main
            self.title = "title_activity".localized(gb.lang_now)
        }
        initTab()
    }
    
    @IBAction func button_1(_ sender: Any) {
        tabButton(tab:1)
        tabChange(send_case:0)
    }
    
    @IBAction func button_2(_ sender: Any) {
        tabButton(tab:2)
        tabChange(send_case:1)
    }
    
    @IBAction func button_3(_ sender: Any) {
        tabButton(tab:3)
        tabChange(send_case:2)
    }
    
    @IBAction func button_4(_ sender: Any) {
        tabButton(tab:4)
        tabChange(send_case:3)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var return_row = 0
        if tableView == table_contact {
            return_row = row_contact
        }
        else if tableView == table_project {
            return_row = row_project
        }
        else {
            return_row = row_activity
        }
        return return_row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table_contact {
            let item = accountContacts?.data![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! AccountContact_TC
            cell.selectionStyle = .none
            cell.label_name.text = "\(String(item?.cus_cont_name ?? "")) \(String(item?.cus_cont_surname ?? ""))"
            cell.label_company.text = accountList?.cus_name_en
            cell.image_person.image = contact_image[indexPath.row]
            
            if indexPath.row == (self.accountContacts?.data?.count)! - 1 && index_contact < (self.accountContacts?.data?.count)!{
                showLoad()
                index_contact = (self.accountContacts?.data!.count)!
                self.moreContact(index: index_contact)
            }
            return cell
        }
        else if tableView == table_project {
            let item = accountProjects?.data![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! AccountProject_TC
            cell.selectionStyle = .none
            cell.label_name.text = item?.project_name
            cell.label_company.text = "\(String(accountList?.cus_name_en ?? ""))(\(String(accountList?.cus_name_th ?? "")))"
            cell.label_person.text = "\(String((item?.cus_cont_name ?? ""))) \(String((item?.cus_cont_surname ?? "")))"
            
            if indexPath.row == (self.accountProjects?.data?.count)! - 1 && index_project < (self.accountProjects?.data?.count)!{
                showLoad()
                index_project = (self.accountProjects?.data!.count)!
                self.moreProject(index: index_project)
            }
            return cell
        }
        else {
            let item = accountActivitys?.data![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! AccountActivity_TC
            cell.selectionStyle = .none
            let f_name  = emptyTextfield(para: String(item?.first_en ?? ""))
            let l_name  = emptyTextfield(para: String(item?.last_en ?? ""))
            let project = emptyTextfield(para: String(item?.project_name ?? ""))
            let st_date = emptyTextfield(para: String(item?.activity_start_date ?? ""))
            let st_time = emptyTextfield(para: String(item?.activity_start_time_ ?? ""))
            let en_date = emptyTextfield(para: String(item?.activity_end_date ?? ""))
            let en_time = emptyTextfield(para: String(item?.activity_end_time_ ?? ""))
            
            cell.label_company.text = accountList?.cus_name_en
            cell.label_name.text = item?.activity_project_name
            cell.label_project.text = "\(f_name) \(l_name) - \(project)"
            cell.label_datetime.text = "\(st_date) \(st_time) - \(en_date) \(en_time)"
            cell.image_person.image = activity_image[indexPath.row]
            cell.label_status.text = item?.status
            cell.label_type.text = "Type : \(item?.type_name ?? "")"
            if item?.status == "Plan" {
                cell.label_status.backgroundColor = gb.ac_plan
            }
            else if item?.status == "Close" {
                cell.label_status.backgroundColor = gb.ac_close
            }
            else if item?.status == "Approve" {
                cell.label_status.backgroundColor = gb.ac_approve
            }
            else if item?.status == "Not Approve" {
                cell.label_status.backgroundColor = gb.ac_notapprove
            }
            else if item?.status == "Need Infomation" {
                cell.label_status.backgroundColor = gb.ac_needinfo
                cell.label_status.text = "Need Info"
            }
            else if item?.status == "Leave" {
                cell.label_status.backgroundColor = gb.ac_leave
            }
            else if item?.status == "Create Project" {
                cell.label_status.backgroundColor = gb.ac_create
                cell.label_status.text = "Project"
            }
            else if item?.status == "Join" {
                cell.label_status.backgroundColor = gb.ac_join
            }
            else {
                cell.label_status.backgroundColor = gb.color_main
            }
            cell.label_status.layer.cornerRadius = 10.0
            cell.label_status.layer.masksToBounds = true
            if item?.type_chage == "0" {
                cell.image_charge.isHidden = true
            }
            else {
                cell.image_charge.isHidden = false
            }
            
            if indexPath.row == (self.accountActivitys?.data?.count)! - 1 && index_activity < (self.accountActivitys?.data?.count)!{
                showLoad()
                index_activity = (self.accountActivitys?.data!.count)!
                self.moreActivity(index: index_activity)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == table_contact {
            let phone = accountContacts?.data![indexPath.row].cus_cont_mob
            var phone_call = phone?.replacingOccurrences(of: "+66", with: "") ?? ""
            phone_call = "+66\(phone_call)"
            if let url = URL(string: "tel://\(String(phone_call))"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else if tableView == table_activity {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "info_activity") as? InfoActivity_VC
            vc!.slt_id = accountActivitys?.data![indexPath.row].activity_id ?? "0"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func setLang(){
        txt_mobile.text = "Umobile".localized(gb.lang_now)
        txt_work.text = "Uwork".localized(gb.lang_now)
        txt_email.text = "Ue_mail".localized(gb.lang_now)
        txt_fax.text = "Ufax".localized(gb.lang_now)
        txt_owner.text = "Uowner".localized(gb.lang_now)
        txt_address.text = "Uaddress".localized(gb.lang_now)
        txt_descrip.text = "Udescription".localized(gb.lang_now)
        txt_com_size.text = "Ucompany_size".localized(gb.lang_now)
        txt_regist.text = "Uregistration".localized(gb.lang_now)
        txt_regist_cap.text = "Uregistered_capital".localized(gb.lang_now)
        txt_number_staff.text = "Unumber_staff".localized(gb.lang_now)
        txt_payment.text = "Upayment".localized(gb.lang_now)
        txt_tax.text = "Utax_id".localized(gb.lang_now)
        txt_old_code.text = "Uold_code".localized(gb.lang_now)
        txt_ship.text = "Uship_to".localized(gb.lang_now)
        txt_doc.text = "Udoc_address".localized(gb.lang_now)
        txt_map_image.text = "Umap_location".localized(gb.lang_now)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let sg = segue.destination as? AddAccount_VC
            sg?.accountList = accountList
        }
        if segue.identifier == "address" {
            let sg = segue.destination as? MapPreview_VC
            sg?.lat = emptyCoor(para: accountList!.cus_latitude ?? "0.0")
            sg?.lng = emptyCoor(para: accountList!.cus_longtitude ?? "0.0")
            sg?.txt_location = emptyTextfield(para: accountList!.cus_location_name ?? "-")
        }
        if segue.identifier == "ship" {
            let sg = segue.destination as? MapPreview_VC
            sg?.lat = emptyCoor(para: accountList!.ship_latitude ?? "0.0")
            sg?.lng = emptyCoor(para: accountList!.ship_longtitude ?? "0.0")
            sg?.txt_location = emptyTextfield(para: accountList!.ship_location_name ?? "-")
        }
        if segue.identifier == "doc" {
            let sg = segue.destination as? MapPreview_VC
            sg?.lat = emptyCoor(para: accountList!.doc_latitude ?? "0.0")
            sg?.lng = emptyCoor(para: accountList!.doc_longtitude ?? "0.0")
            sg?.txt_location = emptyTextfield(para: accountList!.doc_location_name ?? "-")
        }
    }
}
