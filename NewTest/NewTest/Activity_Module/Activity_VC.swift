//
//  Activity_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 28/5/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class Activity_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var table_activity: UITableView!
    @IBOutlet weak var button_info: UIButton!
    let searchControllerAC = UISearchController(searchResultsController: nil)
    var refreshControl = UIRefreshControl()
    var array_image = [UIImage]()
    var txt_search = ""
    var comfirm_search = ""
    var index = 0
    var activitysLists:ActivitysLists? = nil
    var moreActivitysLists:ActivitysLists? = nil
    var standardReturn:StandardReturn? = nil
    var emp_image = [UIImage]()
    var slt_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gb.now_vc = "activity"
        initLayout()
        table_activity.delegate = self
        table_activity.dataSource = self
        table_activity.rowHeight = 140
        getActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showLoad()
        getActivity()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        txt_search = searchController.searchBar.text!
    }
    
    func initLayout(){
        self.title = "title_activity".localized(gb.lang_now)
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        searchControllerAC.searchResultsUpdater = self
        searchControllerAC.hidesNavigationBarDuringPresentation = false
        searchControllerAC.searchBar.delegate = self
        searchControllerAC.searchBar.enablesReturnKeyAutomatically = false
        table_activity.tableHeaderView = searchControllerAC.searchBar
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table_activity.addSubview(refreshControl)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoad()
        comfirm_search = txt_search
        getActivity()
        searchControllerAC.isActive = false
    }
    
    @objc func refresh(_ sender: AnyObject) {
       showLoad()
       txt_search = ""
       comfirm_search = ""
       index = 0
       getActivity()
       refreshControl.endRefreshing()
    }
    
    func getActivity(){
        index = 0
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&index=\(String(index))&search=\(String(txt_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.activitysLists = try JSONDecoder().decode(ActivitysLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.loadImage()
            }
        }
        task.resume()
    }
    
    func moreActivity(index:Int){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&index=\(String(index))&search=\(String(comfirm_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.moreActivitysLists = try JSONDecoder().decode(ActivitysLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.moreActivitysLists?.data != nil {
                    for item in self.moreActivitysLists!.data! {
                        self.activitysLists?.data?.append(item)
                    }
                }
                self.moreImage()
            }
        }
        task.resume()
    }
    
    func loadImage(){
        emp_image = []
        if self.activitysLists != nil {
            if self.activitysLists?.data?.count ?? 0 > 0{
                for item in self.activitysLists!.data! {
                    if item.emp_pic != nil && item.emp_pic != "" {
                        var img = ""
                        img = "\(Const_Var.BASE_URL)\(String(item.emp_pic!))"
                        img = img.replacingOccurrences(of: " ", with: "%20")
                        img = img.replacingOccurrences(of: "+", with: "%2B")
                        img = img.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                        let url = URL(string: img)
                        if url != nil {
                            do{
                                let data = try Data(contentsOf: url!)
                                let im = UIImage(data: data) ?? UIImage(named:"phd_user")
                                self.emp_image.append(im!)
                            }
                            catch{
                                self.emp_image.append(UIImage(named:"phd_user")!)
                            }
                        }
                        else {
                            emp_image.append(UIImage(named:"phd_user")!)
                        }
                    }
                    else {
                        emp_image.append(UIImage(named:"phd_user")!)
                    }
                }
            }
        }
        self.table_activity.reloadData()
        closeLoad()
    }
    
    func moreImage(){
        if self.moreActivitysLists!.data != nil {
            for item in self.moreActivitysLists!.data! {
                if item.emp_pic != nil && item.emp_pic != "" {
                    var img = ""
                    img = "\(Const_Var.BASE_URL)\(String(item.emp_pic!))"
                    img = img.replacingOccurrences(of: " ", with: "%20")
                    img = img.replacingOccurrences(of: "+", with: "%2B")
                    img = img.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
                    let url = URL(string: img)
                    if url != nil {
                        do{
                            let data = try Data(contentsOf: url!)
                            let im = UIImage(data: data) ?? UIImage(named:"phd_user")
                            self.emp_image.append(im!)
                        }
                        catch{
                            self.emp_image.append(UIImage(named:"phd_user")!)
                        }
                    }
                    else {
                        emp_image.append(UIImage(named:"phd_user")!)
                    }
                }
                else {
                    emp_image.append(UIImage(named:"phd_user")!)
                }
            }
        }
        self.table_activity.reloadData()
        closeLoad()
    }
    
    func deleteActivity(activity_id:String){
        let postString = "activity_id=\(activity_id)"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.DEL_ACTIVITY)!
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
                self.getActivity()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitysLists?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = activitysLists?.data![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! Activity_TC
        cell.selectionStyle = .none
        cell.image_person.image = emp_image[indexPath.row]
        if data?.type_chage == "0" {
            cell.icon_chage.isHidden = true
        }
        else {
            cell.icon_chage.isHidden = false
        }
        cell.label_name.text = data?.activity_name ?? ""
        cell.label_company.text = "\(data?.account ?? "")(\(data?.account_th ?? ""))"
        var project_n = data?.project_name ?? ""
        project_n = project_n.replacingOccurrences(of: "&amp;", with: "&")
        cell.label_activity.text = "\(data?.first_en ?? "") \(data?.last_en ?? "") - \(project_n)"
        cell.label_datetime.text = "\(data?.start_date ?? "") \(data?.time_start ?? "") - \(data?.end_date ?? "") \(data?.time_end ?? "")"
        cell.label_status.text = data?.status
        cell.label_status.textColor = UIColor.white
        cell.label_type.text = "Type : \(data?.type_name ?? "")"
        if data?.status == "Plan" {
            cell.label_status.backgroundColor = gb.ac_plan
        }
        else if data?.status == "Close" {
            cell.label_status.backgroundColor = gb.ac_close
        }
        else if data?.status == "Approve" {
            cell.label_status.backgroundColor = gb.ac_approve
        }
        else if data?.status == "Not Approve" {
            cell.label_status.backgroundColor = gb.ac_notapprove
        }
        else if data?.status == "Need Infomation" {
            cell.label_status.backgroundColor = gb.ac_needinfo
            cell.label_status.text = "Need Info"
        }
        else if data?.status == "Leave" {
            cell.label_status.backgroundColor = gb.ac_leave
        }
        else if data?.status == "Create Project" {
            cell.label_status.backgroundColor = gb.ac_create
            cell.label_status.text = "Project"
        }
        else if data?.status == "Join" {
            cell.label_status.backgroundColor = gb.ac_join
        }
        else {
            cell.label_status.backgroundColor = gb.color_main
        }
        cell.label_status.layer.cornerRadius = 10.0
        cell.label_status.layer.masksToBounds = true
        if indexPath.row == (self.activitysLists?.data?.count)! - 1 && index < (self.activitysLists?.data?.count)!{
            showLoad()
            index = (self.activitysLists?.data!.count)!
            self.moreActivity(index: index)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slt_id = (activitysLists?.data?[indexPath.row].activity_id)!
        button_info.sendActions(for: .touchUpInside)
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            deleteActivity(activity_id: (activitysLists?.data?[indexPath.row].activity_id)!)
//        }
//    }
    
    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_add" {
            let sg = segue.destination as? AddActivity_VC
            sg!.page_type = "add"
        }
        else if segue.identifier == "segue" {
            let sg = segue.destination as? InfoActivity_VC
            sg!.slt_id = slt_id
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
