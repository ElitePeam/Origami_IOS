//
//  Slide_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 30/3/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

class Slide_VC : UITableViewController{
    
    var user:UserLoginDao? = nil
    
    let menuList: [String] = ["Time Stamp","Leave","Logout"]
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        let email_txt = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        email_txt.textColor = UIColor.white
        email_txt.text = gb.user?.emp_username
        
        let image = UIImage(named: "bg.png")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
        let imageString = "\(Const_Var.BASE_URL)\(String((gb.user?.emp_pic!.replacingOccurrences(of: "\\", with: ""))!))"
        let imageViewUser = UIImageView()
        imageViewUser.downloaded(from: "\(imageString)")
        imageViewUser.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        headerView.addSubview(imageView)
        headerView.addSubview(imageViewUser)
        headerView.addSubview(email_txt)
        tableView.tableHeaderView = headerView
        
        email_txt.translatesAutoresizingMaskIntoConstraints = false
        imageViewUser.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewUser.layer.masksToBounds = false
        imageViewUser.layer.cornerRadius = imageViewUser.frame.height/2
        imageViewUser.clipsToBounds = true
        imageViewUser.backgroundColor = UIColor.white
        email_txt.font = email_txt.font.withSize(20)
        
        let center_x_user = NSLayoutConstraint(item: imageViewUser, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let center_y_user = NSLayoutConstraint(item: imageViewUser, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: -10)
        
        let widthConstraint = NSLayoutConstraint(item: imageViewUser, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)

        let heightConstraint = NSLayoutConstraint(item: imageViewUser, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        
        let center_x_email = NSLayoutConstraint(item: email_txt, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let top_email = NSLayoutConstraint(item: email_txt, attribute: .top, relatedBy: .equal, toItem: imageViewUser, attribute: .bottom, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activate([center_x_email, top_email, center_x_user, center_y_user, widthConstraint, heightConstraint])

    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.menuList.count
//    }
////
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
//        cell.textLabel?.text = self.menuList[indexPath.row]
//        cell.backgroundColor = UIColor(red: 0.949, green: 0.5922, blue: 0.1294, alpha: 1.0)
//        cell.textLabel?.textColor = UIColor.white
//        return cell
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
}

//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
