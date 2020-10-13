
import UIKit
import Foundation
import CommonCrypto
import SVProgressHUD
import SCLAlertView
import SideMenu
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    @IBOutlet weak var username_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    @IBOutlet weak var version_txt: UILabel!
    @IBOutlet weak var trig_login: UIButton!
    @IBOutlet weak var loading_icon: NVActivityIndicatorView!
    @IBOutlet weak var loading_bg: UIView!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var button_login: RoundButton!
    var user:UserLoginDao? = nil
    var menuLists:MenuLists? = nil
    var have_user = false
    var have_pass = false
    var versionInfo = ""
    var from_logout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        navigationController?.isNavigationBarHidden = true
        gb.user = nil
        let defaults = UserDefaults.standard
        if let lang = defaults.string(forKey: gb.key_lang) {
            gb.lang_now = lang
        }
        else{
            gb.lang_now = "en"
            defaults.set(gb.lang_now, forKey: gb.key_lang)
        }
    
        button_login.setTitle("button_login".localized(gb.lang_now), for: .normal)
        username_text.attributedPlaceholder = NSAttributedString(string: "place_email".localized(gb.lang_now),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password_text.attributedPlaceholder = NSAttributedString(string: "place_pass".localized(gb.lang_now),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        if let ss_username = defaults.string(forKey: gb.key_username) {
            username_text.text = ss_username
            have_user = true
        }
        
        if let ss_password = defaults.string(forKey: gb.key_password) {
            password_text.text = ss_password
            have_pass = true
        }
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        version_txt.text = "v \(appVersion ?? "0.0.0")"
        
        DispatchQueue.global().async {
            do {
                let update = try self.isUpdateAvailable()
                DispatchQueue.main.async {
                    
                    if update {
                        self.popupUpdateDialogue()
                    }
                    else{
                        if self.have_user && self.have_pass && !self.from_logout {
                            self.button_login.sendActions(for: .touchUpInside)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }

//    let url = URL(string: "itunes.apple.com/lookup?bundleId=allable.origami.2020")!
    func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            
            let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw VersionError.invalidResponse
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            versionInfo = currentVersion
            print("Version store \(version) : Version now \(currentVersion)")
            print("https://itunes.apple.com/lookup?bundleId=\(identifier)")
            return version != currentVersion
        }
        throw VersionError.invalidResponse
    }
    
    func popupUpdateDialogue(){
       let alertMessage = "\("new_ver_avail_txt".localized(gb.lang_now)) \(versionInfo)";
       let alert = UIAlertController(title: "new_ver_avail".localized(gb.lang_now), message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "update".localized(gb.lang_now), style: .default, handler: {(_ action: UIAlertAction) -> Void in
           if let url = URL(string: "itms-apps://itunes.apple.com/us/app/origami-life/id1508681872"),
               UIApplication.shared.canOpenURL(url){
               if #available(iOS 10.0, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
           }
       })
        let noBtn = UIAlertAction(title:"later".localized(gb.lang_now) , style: .cancel, handler: nil)
       alert.addAction(noBtn)
       alert.addAction(okBtn)
       self.present(alert, animated: true, completion: nil)
    }
    
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
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

    @IBAction func tap_login(_ sender: Any) {
        isShowLoading(isShow: true)
        var username = username_text.text!
        let password = password_text.text!
        var encrytPass = password.md5
//        username = "dhavisa@trandar.com"
//        encrytPass = "81dc9bdb52d04dc20036dbd8313ed055"
//        if(username != "" && password != ""){
        if(username == "" || password == "") {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "require_user_pass".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            isShowLoading(isShow: false)
        }
        else{
            let postString = "user=" + username + "&password=" + encrytPass + "&register_id=0"
            let url = URL(string: Const_Var.BASE_URL + "api/checkUser.php")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {
                        print("error", error ?? "Unknown error")
                    return
                }

                guard (200 ... 299) ~= response.statusCode else {
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                do{
                    let tmpData = try JSONDecoder().decode(UserLoginDao.self, from: data)
                    self.user = tmpData
                    
                }catch let err{
                    print("User_Data_Error",err)
                }
                
                DispatchQueue.main.async {
                    if self.user?.action == nil{
                        SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "user_not_found".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                        self.isShowLoading(isShow: false)
                    }else{
                        let defaults = UserDefaults.standard
                        defaults.set(username, forKey: gb.key_username)
                        defaults.set(password, forKey: gb.key_password)
                        gb.user = self.user
                        
                        if gb.menu_list == nil {
                            gb.newMenuList()
                            self.getMenu()
                        }
                        else {
                            self.trig_login.sendActions(for: .touchUpInside)
                            self.isShowLoading(isShow: false)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getMenu(){
        let postString = "emp_id=\(String((gb.user?.emp_id)!))&comp_id=\(String(gb.user?.comp_id ?? ""))&role=\(String(gb.user?.acrp_id ?? ""))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_MENU)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.menuLists = try JSONDecoder().decode(MenuLists.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.menuLists?.data != nil {
                    for item in self.menuLists!.data! {
                        if item.path == "work/request_ot.php" {
                            gb.menu_list?.request_ot = "active"
                        }
                        else if item.path == "work/index.php" {
                            gb.menu_list?.work = "active"
                            gb.menu_list?.approval = "active"
                        }
                        else if item.path == "need/index.php" {
                            gb.menu_list?.need = "active"
                            gb.menu_list?.approval = "active"
                        }
                        else if item.path == "crm/stk_customer.php" {
                            gb.menu_list?.account = "active"
                        }
                        else if item.path == "crm/stk_activity.php" {
                            gb.menu_list?.activity = "active"
                        }
                    }
                    print("Set permission menu complete!")
                }
                self.trig_login.sendActions(for: .touchUpInside)
                self.isShowLoading(isShow: false)
            }
        }
        task.resume()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "to_home"  {
           let navVC = segue.destination as? UINavigationController
           let tableVC = navVC?.viewControllers.first as! Home_VC
//           tableVC.user = self.user
       }
    }
}


