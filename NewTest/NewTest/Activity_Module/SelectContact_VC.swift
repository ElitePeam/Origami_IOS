//
//  SelectContact_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 30/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class SelectContact_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var table_contact: UITableView!
    
    var addActivityContacts:AddActivityContacts? = nil
    var moreActivityContacts:AddActivityContacts? = nil
    let searchControllerAC = UISearchController(searchResultsController: nil)
    var refreshControl = UIRefreshControl()
    var array_image = [UIImage]()
    var txt_search = ""
    var comfirm_search = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        initLayout()
        initData()
    }
    
    func initLayout(){
        searchControllerAC.searchResultsUpdater = self
        searchControllerAC.hidesNavigationBarDuringPresentation = false
        searchControllerAC.searchBar.delegate = self
        searchControllerAC.searchBar.enablesReturnKeyAutomatically = false
        table_contact.tableHeaderView = searchControllerAC.searchBar
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table_contact.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       txt_search = ""
       comfirm_search = ""
       index = 0
       getAddActivityContact()
       refreshControl.endRefreshing()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        txt_search = searchController.searchBar.text!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoad()
        comfirm_search = txt_search
        getAddActivityContact()
        searchControllerAC.isActive = false
    }
    
    func initData(){
        getAddActivityContact()
    }
    
    func getAddActivityContact(){
        index = 0
        let postString = "index=\(String(index))&emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&search=\(String(txt_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_CONTACT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.addActivityContacts = try JSONDecoder().decode(AddActivityContacts.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.array_image = [UIImage]()
                if self.addActivityContacts?.data != nil {
                    for item in self.addActivityContacts!.data! {
                        self.array_image.append(UIImage(named: "phd_user")!)
                        self.array_image[self.array_image.endIndex-1] = self.loadImage(image_str:item.contact_image ?? "")
//                        self.array_image.append(self.loadImage(image_str:item.contact_image ?? ""))
                    }
                    self.table_contact.reloadData()
                    self.closeLoad()
                }
                else {
                    self.table_contact.reloadData()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func moreAddActivityContact(index:Int){
        let postString = "index=\(String(index))&emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String((gb.user?.comp_id)!))&search=\(String(comfirm_search))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_CONTACT)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.moreActivityContacts = try JSONDecoder().decode(AddActivityContacts.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.moreActivityContacts?.data != nil {
                    for item in self.moreActivityContacts!.data! {
                        self.addActivityContacts?.data?.append(item)
                        self.array_image.append(UIImage(named: "phd_user")!)
                        self.array_image[self.array_image.endIndex-1] = self.loadImage(image_str:item.contact_image ?? "")
//                        self.array_image.append(self.loadImage(image_str:item.contact_image ?? ""))
                    }
                    self.table_contact.reloadData()
                    self.closeLoad()
                }
                else {
                    self.table_contact.reloadData()
                    self.closeLoad()
                }
            }
        }
        task.resume()
    }
    
    func loadImage(image_str:String)->UIImage{
        var rt_image = UIImage(named:"phd_user")!
        if image_str != "" {
            var img = ""
            img = "\(Const_Var.BASE_URL)\(image_str)"
            img = img.replacingOccurrences(of: " ", with: "%20")
            img = img.replacingOccurrences(of: "+", with: "%2B")
            img = img.replacingOccurrences(of: "../", with: "")
            img = img.replacingOccurrences(of: "/Applications/XAMPP/xamppfiles/htdocs/", with: "")
            let url = URL(string: img)
            if url != nil {
                do{
                    let data = try Data(contentsOf: url!)
                    let im = UIImage(data: data) ?? UIImage(named:"phd_user")
                    rt_image = im ?? UIImage(named:"phd_user")!
                }
                catch{

                }
            }
        }
        return rt_image
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addActivityContacts?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityContact3_TVC
        cell.selectionStyle = .none
        let data = addActivityContacts?.data?[indexPath.row]
        cell.image_contact.image = array_image[indexPath.row]
        cell.label_contact.text = "\(data?.contact_first ?? "") \(data?.contact_last ?? "")"
        cell.label_comp.text = data?.customer_en
        print("Data count : \(self.addActivityContacts?.data?.count ?? 0)  Index : \(String(indexPath.row))")
        if indexPath.row == (self.addActivityContacts?.data?.count)! - 1 && index < (self.addActivityContacts?.data?.count)!{
            self.showLoad()
            index = (self.addActivityContacts?.data!.count)!
            self.moreAddActivityContact(index: index)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = addActivityContacts?.data?[indexPath.row]
        let newOtherContact = activity_contacts.init(
            contact_id          : data?.contact_id ?? "",
            contact_first       : data?.contact_first ?? "",
            contact_last        : data?.contact_last ?? "",
            contact_image       : data?.contact_image ?? "",
            contact_account_en  : data?.customer_en ?? "",
            contact_account_th  : data?.customer_th ?? ""
        )
        gb.activityData?.other_contact.append(newOtherContact)
        self.navigationController?.popViewController(animated: true)
    }
}
