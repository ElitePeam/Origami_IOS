//
//  Menu_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 6/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//
import Foundation
import UIKit
import SideMenu

class Menu_VC: UITableViewController {
    
    @IBOutlet weak var cell_time: UITableViewCell!
    @IBOutlet weak var cell_work: UITableViewCell!
    @IBOutlet weak var cell_need: UITableViewCell!
    @IBOutlet weak var cell_approve: UITableViewCell!
    @IBOutlet weak var cell_request_ot: UITableViewCell!
    @IBOutlet weak var cell_account: UITableViewCell!
    @IBOutlet weak var cell_contact: UITableViewCell!
    @IBOutlet weak var cell_project: UITableViewCell!
    @IBOutlet weak var cell_activity: UITableViewCell!
    @IBOutlet weak var cell_setting: UITableViewCell!
    @IBOutlet weak var cell_logout: UITableViewCell!
    @IBOutlet weak var txt_time: UILabel!
    @IBOutlet weak var txt_request_ot: UILabel!
    @IBOutlet weak var txt_work: UILabel!
    @IBOutlet weak var txt_need: UILabel!
    @IBOutlet weak var txt_approve: UILabel!
    @IBOutlet weak var txt_account: UILabel!
    @IBOutlet weak var txt_contact: UILabel!
    @IBOutlet weak var txt_project: UILabel!
    @IBOutlet weak var txt_activity: UILabel!
    @IBOutlet weak var txt_setting: UILabel!
    @IBOutlet weak var txt_logout: UILabel!
    
    var user:UserLoginDao? = nil
    let imageViewUser = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        txt_time.text = "title_time".localized(gb.lang_now)
        txt_request_ot.text = "title_request_ot".localized(gb.lang_now)
        txt_work.text = "title_work".localized(gb.lang_now)
        txt_need.text = "title_need".localized(gb.lang_now)
        txt_approve.text = "title_approve".localized(gb.lang_now)
        txt_account.text = "title_account".localized(gb.lang_now)
        txt_contact.text = "title_project".localized(gb.lang_now)
        txt_project.text = "title_contact".localized(gb.lang_now)
        txt_activity.text = "title_activity".localized(gb.lang_now)
        txt_setting.text = "title_setting".localized(gb.lang_now)
        txt_logout.text = "title_logout".localized(gb.lang_now)
        
        cell_time.backgroundColor = UIColor.clear
        cell_work.backgroundColor = UIColor.clear
        cell_need.backgroundColor = UIColor.clear
        cell_approve.backgroundColor = UIColor.clear
        cell_request_ot.backgroundColor = UIColor.clear
        cell_account.backgroundColor = UIColor.clear
        cell_contact.backgroundColor = UIColor.clear
        cell_project.backgroundColor = UIColor.clear
        cell_activity.backgroundColor = UIColor.clear
        cell_setting.backgroundColor = UIColor.clear
        cell_time.selectionStyle = .none
        cell_work.selectionStyle = .none
        cell_need.selectionStyle = .none
        cell_approve.selectionStyle = .none
        cell_request_ot.selectionStyle = .none
        cell_account.selectionStyle = .none
        cell_contact.selectionStyle = .none
        cell_project.selectionStyle = .none
        cell_activity.selectionStyle = .none
        cell_setting.selectionStyle = .none
        cell_logout.selectionStyle = .none
        cell_time.isUserInteractionEnabled = true
        cell_work.isUserInteractionEnabled = true
        cell_need.isUserInteractionEnabled = true
        cell_approve.isUserInteractionEnabled = true
        cell_request_ot.isUserInteractionEnabled = true
        cell_account.isUserInteractionEnabled = true
        cell_contact.isUserInteractionEnabled = true
        cell_project.isUserInteractionEnabled = true
        cell_activity.isUserInteractionEnabled = true
        cell_setting.isUserInteractionEnabled = true
        
        if gb.now_vc == "time" {
            cell_time.isUserInteractionEnabled = false
            cell_time.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "work" {
            cell_work.isUserInteractionEnabled = false
            cell_work.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "need" {
            cell_need.isUserInteractionEnabled = false
            cell_need.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "approve" {
            cell_approve.isUserInteractionEnabled = false
            cell_approve.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "request_ot" {
            cell_request_ot.isUserInteractionEnabled = false
            cell_request_ot.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "account" {
            cell_account.isUserInteractionEnabled = false
            cell_account.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "contact" {
            cell_contact.isUserInteractionEnabled = false
            cell_contact.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "project" {
            cell_project.isUserInteractionEnabled = false
            cell_project.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "activity" {
            cell_activity.isUserInteractionEnabled = false
            cell_activity.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if gb.now_vc == "setting" {
            cell_setting.isUserInteractionEnabled = false
            cell_setting.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 140)
        
        var imageString = ""
        if gb.user?.emp_pic == nil {
            imageString = "\(Const_Var.BASE_URL)images/default.png"
        }
        else{
             imageString = "\(Const_Var.BASE_URL)\(String((gb.user?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!))"
        }
       
        imageString = imageString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        imageViewUser.contentMode = .scaleAspectFit
        imageViewUser.downloaded(from: "\(imageString)")
        imageViewUser.frame = CGRect(x: 0, y: 0, width: 80, height: 80)

        imageViewUser.layer.borderColor = UIColor(red: 0.90, green: 0.49, blue: 0.13, alpha: 0.70).cgColor
        imageViewUser.layer.borderWidth = 3
        
        headerView.addSubview(imageViewUser)
        tableView.tableHeaderView = headerView
        imageViewUser.translatesAutoresizingMaskIntoConstraints = false
        imageViewUser.layer.masksToBounds = false
        imageViewUser.layer.cornerRadius = imageViewUser.frame.height/2
        imageViewUser.clipsToBounds = true
        imageViewUser.backgroundColor = UIColor.white
        
        let center_x_user = NSLayoutConstraint(item: imageViewUser, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0)
        let center_y_user = NSLayoutConstraint(item: imageViewUser, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: imageViewUser, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        let heightConstraint = NSLayoutConstraint(item: imageViewUser, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        NSLayoutConstraint.activate([center_x_user, center_y_user, widthConstraint, heightConstraint])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//        index 0 = time
//        index 1 = request_ot
//        index 2 = work
//        index 3 = need
//        index 4 = approval
//        index 5 = account
//        index 6 = activity
        if indexPath.row == 0 && gb.menu_list?.time == "inactive" {
            return 0
        }
        else if indexPath.row == 1 && gb.menu_list?.request_ot == "inactive" {
            return 0
        }
        else if indexPath.row == 2 && gb.menu_list?.work == "inactive" {
            return 0
        }
        else if indexPath.row == 3 && gb.menu_list?.need == "inactive" {
            return 0
        }
        else if indexPath.row == 4 && gb.menu_list?.approval == "inactive" {
            return 0
        }
        else if indexPath.row == 5 && gb.menu_list?.account == "inactive" {
            return 0
        }
        else if indexPath.row == 6 && gb.menu_list?.activity == "inactive"{
            return 0
        }
        else {
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell_time.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 1 {
            cell_work.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 2 {
            cell_need.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 3 {
            cell_approve.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 4 {
            cell_request_ot.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 5 {
            cell_account.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 6 {
            cell_contact.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 7 {
            cell_project.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 8 {
            cell_activity.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 9 {
            cell_setting.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.15)
        }
        else if indexPath.row == 10 {
            cell_logout.backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 0.15)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout" {
            gb.menu_list = nil
            let sg = segue.destination as? ViewController
            sg!.from_logout = true
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}
