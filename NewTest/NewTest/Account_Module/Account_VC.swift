//
//  Account_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 28/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class Account_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var table_account: UITableView!
    @IBOutlet weak var info_btn: UIButton!
    
    var accountLists:AccountLists? = nil
    var accountList:AccountList? = nil
    var accountMore:AccountLists? = nil
    var table_row = 0
    var selected_row = 0
    var array_image = [UIImage]()
    var icon = UIImage()
    let searchControllerAC = UISearchController(searchResultsController: nil)
    var txt_search = ""
    var comfirm_search = ""
    var index = 0
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gb.refresh = true
        self.title = "title_account".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        gb.now_vc = "account"
        
        table_account.rowHeight = 100
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .thin, scale: .medium)
        icon = UIImage(systemName: "person.circle.fill", withConfiguration: iconConfig)!
        
        searchControllerAC.searchResultsUpdater = self
        searchControllerAC.hidesNavigationBarDuringPresentation = false
        searchControllerAC.searchBar.delegate = self
        searchControllerAC.searchBar.enablesReturnKeyAutomatically = false
//        definesPresentationContext = true
        table_account.tableHeaderView = searchControllerAC.searchBar
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table_account.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       txt_search = ""
       comfirm_search = ""
       index = 0
       showLoad()
       getAccountList()
       refreshControl.endRefreshing()
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
        getAccountList()
        searchControllerAC.isActive = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if gb.refresh {
            showLoad()
            getAccountList()
            gb.refresh = false
        }
        
    }
    func getAccountList(){
        index = 0
        let postString = "idemp=\(String((gb.user?.emp_id)!))&index=0&txt_search=\(txt_search)"
        txt_search = ""
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.accountLists = try JSONDecoder().decode(AccountLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if self.accountLists?.data != nil {
                        self.table_row = (self.accountLists?.data!.count)!
                        self.loadImage()
                    }
                    else {
                        self.table_row = 0
                        self.table_account.reloadData()
                        self.closeLoad()
                    }
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    func loadImage(){
        array_image = [UIImage]()
        for item in self.accountLists!.data! {
            if item.cus_logo != nil && item.cus_logo != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)crm/\(String(item.cus_logo!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.array_image.append(im)
                        }
                        catch{
                            self.array_image.append(UIImage())
                        }
                    }
                    else{
                        self.array_image.append(UIImage())
                    }
                }
                catch{
                    self.array_image.append(UIImage())
                }
            }
            else {
                self.array_image.append(UIImage())
            }
        }
        table_account.reloadData()
        closeLoad()
    }
    
    func moreAccount(index: Int){
        let postString = "idemp=\(String((gb.user?.emp_id)!))&index=\(String(index))&txt_search=\(comfirm_search)"
        print("More acc : \(postString)")
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACCOUNT_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.accountMore = try JSONDecoder().decode(AccountLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                do{
                    if self.accountMore?.data != nil {
                        for item in self.accountMore!.data! {
                            self.accountLists?.data?.append(item)
                        }
                        self.table_row = (self.accountLists?.data!.count)!
                        self.moreImage()
                    }
                    else {
                        self.closeLoad()
                    }
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func moreImage(){
        for item in self.accountMore!.data! {
            if item.cus_logo != nil && item.cus_logo != "" {
                var image_account_str = ""
                image_account_str = "\(Const_Var.BASE_URL)crm/\(String(item.cus_logo!.replacingOccurrences(of: "\\", with: "")))"
                image_account_str = image_account_str.replacingOccurrences(of: " ", with: "%20")
                image_account_str = image_account_str.replacingOccurrences(of: "+", with: "%2B")
                image_account_str = image_account_str.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                do{
                    let url = URL(string: image_account_str)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage()
                            self.array_image.append(im)
                        }
                        catch{
                            self.array_image.append(UIImage())
                        }
                    }
                    else{
                        self.array_image.append(UIImage())
                    }
                }
                catch{
                    self.array_image.append(UIImage())
                }
            }
            else {
                self.array_image.append(UIImage())
            }
        }
        table_account.reloadData()
        closeLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table_row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = accountLists?.data
        let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! Account_TC
        cell.selectionStyle = .none
        cell.label_name.text = data![indexPath.row].cus_name_en
        cell.label_des.text = data![indexPath.row].cus_name_th
        cell.label_location.text = "\(String(data![indexPath.row].cus_group_name ?? "-")) - \(String(data![indexPath.row].cus_type_name ?? "-"))"
        cell.image_cell?.image = array_image[indexPath.row]
        
        if indexPath.row == (self.accountLists?.data?.count)! - 1 && index < (self.accountLists?.data?.count)!{
            showLoad()
            index = (self.accountLists?.data!.count)!
            self.moreAccount(index: index)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_row = indexPath.row
        info_btn.sendActions(for: .touchUpInside)
    }
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let sg = segue.destination as? InfoAccount_VC
            sg?.accountList = accountLists?.data![selected_row]
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
