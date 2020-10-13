//
//  Home_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 13/3/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit
import SCLAlertView
import SideMenu
import NVActivityIndicatorView

class Home_VC : UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var user:UserLoginDao? = nil
    var userTimeLoad:TimeLoadDao? = nil
    var BranchAlls:BranchAll? = nil
    var ActivityAlls:ActivityAll? = nil
    var ActivityList:ActivityLists? = nil
    var returnStatus:timeStampResult? = nil
    @IBOutlet weak var txt_curent_time: UILabel!
    @IBOutlet weak var view_head: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txt_in: UILabel!
    @IBOutlet weak var txt_out: UILabel!
    @IBOutlet weak var btn_stamp: RoundButton!
    @IBOutlet weak var txt_branch_name: UILabel!
    @IBOutlet weak var txt_location_name: UILabel!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var popup_close: UIButton!
    @IBOutlet weak var popup_bg: UIView!
    @IBOutlet weak var popup_label: UILabel!
    @IBOutlet weak var popup_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var loading_icon: NVActivityIndicatorView!
    @IBOutlet weak var table_activity: UITableView!
    @IBOutlet weak var table_branch: UITableView!
    @IBOutlet weak var image_top: UIImageView!
    @IBOutlet weak var image_bottom: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var mapLocationManager = CLLocationManager()
    var selectedLocation = CLLocationCoordinate2D()
    let username = "origami"
    let password = "ori20#17gami"
    var region_color = "red"
    var last_region_color = ""
    var status_stamp = "-"
    var userInRange = false
    var timer = Timer()
    var user_lat = 0.0
    var user_lng = 0.0
    var time_in = ""
    var time_out = ""
    var branch_id = ""
    var branch_name = ""
    var comp_name = ""
    var comp_radius = 0
    var popup_row = 0
    var activity_row = 0
    var lat = 0.0
    var lng = 0.0
    var select_table = 0
    var activity_id = 0
    var selected_activity_name = ""
    var selected_activity_cust = ""
    var base64_image = ""
    var current_branch = ""
    let overlay = UIVisualEffectView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        user = gb.user
        gb.now_vc = "time"
        table_branch.delegate = self
        table_branch.dataSource = self
        table_activity.delegate = self
        table_activity.dataSource = self
        
        popup.isHidden = true
        popup_bg.isHidden = true
        popup.layer.cornerRadius = 5
        popup.layer.masksToBounds = true
        popup.alpha = 0.0
        
        initLayout()
        getUserTimeStamp()
        getBranchList()
        getActivityList()
        
        popup_close.setTitle("close".localized(gb.lang_now), for: .normal)
        self.title = "title_time".localized(gb.lang_now)
        var nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func isShowLoading(isShow:Bool) {
        if isShow {
            popup_bg.backgroundColor = UIColor.black
            popup_bg.isHidden = false
            loading_icon.startAnimating()
        }
        else{
            popup_bg.isHidden = true
            loading_icon.stopAnimating()
        }
    }
    
   internal func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
           for annotationView in views {
               if annotationView.annotation is MKUserLocation {
                annotationView.bringSubviewToFront(view)
                   return
               }
            annotationView.sendSubviewToBack(view)
           }
    }

    @IBAction func tap_stamp(_ sender: Any) {
        if activity_id == 0 {
            if userInRange {
                imagePicker =  UIImagePickerController()
                imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
                imagePicker.sourceType = .camera
                present(imagePicker, animated: true, completion: nil)
            }
            else{
                SCLAlertView().showWarning("fail".localized(gb.lang_now), subTitle: "cant_stamp_area".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            }
        }
        else{
            sendTimeStamp()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isShowLoading(isShow: true)
        imagePicker.dismiss(animated: true, completion: nil)
        var capture_image = UIImage()
        capture_image = (info[.originalImage] as? UIImage)!
        capture_image = capture_image.resizeWithWidth(width: 300)!
        let image_data = capture_image.jpegData(compressionQuality: 0.5)
        base64_image = image_data!.base64EncodedString()
        base64_image = base64_image.replacingOccurrences(of: "+", with: "%2B")
        sendTimeStamp()
        base64_image = ""
    }
    
    func sendTimeStamp(){
        if (user_lat == 0.0) && (user_lng == 0.0) {
            SCLAlertView().showWarning("warning".localized(gb.lang_now), subTitle: "wrong_location".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
            self.isShowLoading(isShow: false)
        }
        else {
            let postString = "user=\(username)&pass=\(password)&emp_code=\(String((user?.emp_code)!))&comp_id=\(String((user?.comp_id!)!))&status=\(String(status_stamp))&activity_id=\(String(activity_id))&lat=\(String(user_lat))&beanch_id=\(String(branch_id))&lng=\(String(user_lng))&img=\(String(base64_image))&img_exif=\(String(1))&device=IOS"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.POST_TIME_STAMP)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                _ = String(data: data!, encoding: .utf8)
                do{
                    self.returnStatus = try JSONDecoder().decode(timeStampResult.self, from: data!)
                }catch let err{
                    print("User_Data_Error : ",err)
                }
                
                DispatchQueue.main.async {
                    if self.returnStatus!.status == 1{
                        SCLAlertView().showSuccess("success".localized(gb.lang_now), subTitle: "stamp_success".localized(gb.lang_now), closeButtonTitle:"close".localized(gb.lang_now),animationStyle: .noAnimation)
                        if self.activity_id == 0 {
                            self.getBranchListForCurrentBranch()
                            self.popup_row = (self.BranchAlls?.data!.count)!
                            self.table_branch.reloadData()
                        }
                        else {
                            self.getActivityList()
                        }
                    }
                    else {
                        SCLAlertView().showError("fail".localized(gb.lang_now), subTitle: "stamp_fail".localized(gb.lang_now))
                        self.isShowLoading(isShow: false)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getUserTimeStamp(){
        let postString = "user=origami&pass=ori20#17gami&emp_id=\(String((user?.emp_id)!))&comp_id=\(String((user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_TIME_STAMP)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.userTimeLoad = try JSONDecoder().decode(TimeLoadDao.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.time_in = String(self.userTimeLoad!.stamp_in ?? "")
                self.time_out = String(self.userTimeLoad!.stamp_out ?? "")
                self.comp_name = String(self.userTimeLoad!.comp_name ?? "")
                self.branch_id = String(self.userTimeLoad!.branch_id ?? "")
                self.branch_name = String(self.userTimeLoad!.branch_name ?? "")
                self.comp_radius = Int(String(self.userTimeLoad!.comp_circumference!))!
                self.selectedLocation = CLLocationCoordinate2D(latitude: Double(self.userTimeLoad!.lat!)!, longitude: Double(self.userTimeLoad!.lng!)!)
                self.setBranchName()
                self.setStampTime()
                self.setStampButton()
                self.initMap()
                self.current_branch = self.branch_id
            }
        }
        task.resume()
    }
    
    func getBranchList(){
        let postString = "user=origami&pass=ori20#17gami&emp_id=\(String((user?.emp_id)!))&comp_id=\(String((user?.comp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_BRANCH_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.BranchAlls = try JSONDecoder().decode(BranchAll.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                self.popup_row = (self.BranchAlls?.data!.count)!
                self.table_branch.reloadData()
            }
        }
        task.resume()
    }
    
    func getBranchListForCurrentBranch(){
            let postString = "user=origami&pass=ori20#17gami&emp_id=\(String((user?.emp_id)!))&comp_id=\(String((user?.comp_id)!))"
            let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_BRANCH_LIST)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                _ = String(data: data!, encoding: .utf8)
                do{
                    self.BranchAlls = try JSONDecoder().decode(BranchAll.self, from: data!)
                }catch let err{
                    print("User_Data_Error : ",err)
                }
                
                DispatchQueue.main.async {
                    for branch in (self.BranchAlls?.data!)! {
                        if branch.branch_id == self.current_branch {
                            var tmp_in = ""
                            var tmp_out = ""
                            if branch.stamp_in == nil{tmp_in = "-"}else{tmp_in = branch.stamp_in!}
                            if branch.stamp_out == nil{tmp_out = "-"}else{tmp_out = branch.stamp_out!}
                            self.time_in = tmp_in
                            self.time_out = tmp_out
                            self.comp_name = (branch.comp_name)!
                            self.branch_id = (branch.branch_id)!
                            self.branch_name = (branch.branch_name)!
                            self.comp_radius = Int(branch.comp_circumference!)!
                            self.lat = Double((branch.lat)!)!
                            self.lng = Double((branch.lng)!)!
                            self.selectedLocation = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                            
                            self.current_branch = self.branch_id
                            self.setBranchName()
                            self.setStampTime()
                            self.setStampButton()
                            self.resetOverlay()
                            self.initMap()
                            self.isUserInRange()
                            break
                        }
                    }
                    self.isShowLoading(isShow: false)
                }
            }
            task.resume()
        }
    
    func getActivityList(){
        self.table_branch.reloadData()
        let postString = "user=origami&pass=ori20#17gami&emp_id=\(String((user?.emp_id)!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_ACTIVITY_LIST)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = String(data: data!, encoding: .utf8)
            do{
                self.ActivityAlls = try JSONDecoder().decode(ActivityAll.self, from: data!)
            }catch let err{
                print("User_Data_Error : ",err)
            }
            
            DispatchQueue.main.async {
                if self.ActivityAlls?.data != nil {
                    self.getActiveActivity()
                    self.activity_row = (self.ActivityAlls?.data!.count)!
                }
                else{
                    self.activity_row = 0
                }
                self.table_activity.reloadData()
            }
        }
        task.resume()
    }
    
    func getActiveActivity(){
        for ac in (ActivityAlls?.data)! {
            if activity_id == Int(ac.id!) {
                time_in = ac.stamp_in!
                time_out = ac.stamp_out!
                setStampTime()
                setStampButton()
                break
            }
        }
    }
    
    func setStampButton(){
        btn_stamp.isEnabled = true
        if activity_id == 0 {
            if time_in == "-" || time_in == ""{
                status_stamp = "in"
                btn_stamp.setImage(UIImage(named: "stamp_button_in.png"), for: UIControl.State.normal)
            }
            else if time_out == "-" || time_out == ""{
                status_stamp = "out"
                btn_stamp.setImage(UIImage(named: "stamp_button_out.png"), for: UIControl.State.normal)
            }
            else{
                btn_stamp.isEnabled = false
                btn_stamp.setImage(UIImage(named: "stamp_button_disable.png"), for: UIControl.State.normal)
            }
        }
        else {
            if time_in == "-" || time_in == ""{
                status_stamp = "in"
            }
            else if time_out == "-" || time_out == ""{
                status_stamp = "out"
            }
            else{
                status_stamp = "out"
            }
            btn_stamp.setImage(UIImage(named: "button_stamp_2.png"), for: UIControl.State.normal)
        }
    }
    
    func setStampTime(){
        txt_in.text = "\("in".localized(gb.lang_now)) : \(time_in)"
        if time_in == time_out {
            time_out = "-"
            txt_out.text = "\("out".localized(gb.lang_now)) : -"
        }
        else {
            txt_out.text = "\("out".localized(gb.lang_now)) : \(time_out)"
        }
    }
    
    func setBranchName(){
        image_top.image = UIImage(systemName:"mappin.and.ellipse")
        image_bottom.image = UIImage(systemName:"arrow.branch")
        txt_branch_name.text = "\(comp_name)"
        txt_location_name.text = "\(branch_name)"
    }
    
    func setActivityName(){
        image_top.image = UIImage(systemName:"doc.text")
        image_bottom.image = UIImage(systemName:"person")
        txt_branch_name.text = "\(selected_activity_name)"
        txt_location_name.text = "\(selected_activity_cust)"
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            user_lat = locValue.latitude
            user_lng = locValue.longitude
            isUserInRange()
            GoToCenterLocation()
        }
    
    func isUserInRange(){
        let coordinate1 = CLLocation(latitude: user_lat, longitude: user_lng)
        let coordinate2 = CLLocation(latitude: selectedLocation.latitude, longitude:  selectedLocation.longitude)
        let distanceInMeters = coordinate1.distance(from: coordinate2)
        
        if comp_radius == 0 {
            userInRange = true
            resetOverlay()
        }
        else {
            if(distanceInMeters > CLLocationDistance(comp_radius)){
                region_color = "red"
                userInRange = false
                if last_region_color != region_color {
                   resetOverlay()
                }
            }
            else{
                region_color = "green"
                userInRange = true
                if last_region_color != region_color {
                   resetOverlay()
                }
            }
            last_region_color = region_color
        }
    }
        
    func resetOverlay() {
        for overlays in mapView.overlays {
            mapView.removeOverlay(overlays)
        }
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        mapView.addOverlay(MKCircle(center: selectedLocation, radius: CLLocationDistance(comp_radius)))
    }
    
    func GoToCenterLocation() {
        if mapLocationManager.location != nil {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: user_lat, longitude: user_lng), latitudinalMeters: 200, longitudinalMeters: 200)
                mapView.setRegion(region, animated: true)
        }
    }
    
    func initMap(){
        mapLocationManager.delegate = self
        mapLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapLocationManager.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse && CLLocationManager.authorizationStatus() != . authorizedAlways {
        mapLocationManager.requestWhenInUseAuthorization()
        }
        mapView.showsUserLocation = true
        mapLocationManager.startUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.title = "\(comp_name)\n(\(branch_name))"
        annotation.subtitle = "\(comp_name)\n(\(branch_name))"
        annotation.coordinate = selectedLocation
        mapView.addAnnotation(annotation)
        GoToCenterLocation()
    }
    
    func initLayout() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    @objc func tick() {
        var current_time = DateFormatter.localizedString(from: Date(),dateStyle: .none,timeStyle: .short)
        
        if(current_time.suffix(2) == "AM" || current_time.suffix(2) == "PM"){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"

            let date = dateFormatter.date(from: current_time)
            dateFormatter.dateFormat = "HH:mm"
            let Date24 = dateFormatter.string(from: date!)
            current_time = Date24
        }
        txt_curent_time.text = current_time
    }
    
    @IBAction func tapSwitchBranch(_ sender: Any) {
        table_branch.reloadData()
        popup.isHidden = false
//        popup_bg.isHidden = false
        popup_label.text = "switch_branch".localized(gb.lang_now)
        table_branch.isHidden = false
        table_activity.isHidden = true
        
        overlay.frame = self.view_head.bounds
        overlay.tag = 100
        self.view_head.addSubview(overlay)
        UIView.animate(withDuration: 0.3) {
            self.overlay.effect = UIBlurEffect(style: .dark)
            self.popup.alpha = 1.0
        }
        
        let newConstraint = popup_height_constraint.constraintWithMultiplier(0.75)
        view.removeConstraint(popup_height_constraint)
        view.addConstraint(newConstraint)
        view.layoutIfNeeded()
        popup_height_constraint = newConstraint
    }
    
    @IBAction func tapSwitchActivity(_ sender: Any) {
        getActivityList()
        popup.isHidden = false
//        popup_bg.isHidden = false
        popup_label.text = "switch_activity".localized(gb.lang_now)
        table_branch.isHidden = true
        table_activity.isHidden = false
        
        overlay.frame = self.view_head.bounds
        overlay.tag = 100
        self.view_head.addSubview(overlay)
        UIView.animate(withDuration: 0.3) {
            self.overlay.effect = UIBlurEffect(style: .dark)
            self.popup.alpha = 1.0
        }
        
        let newConstraint = popup_height_constraint.constraintWithMultiplier(0.75)
        view.removeConstraint(popup_height_constraint)
        view.addConstraint(newConstraint)
        view.layoutIfNeeded()
        popup_height_constraint = newConstraint
    }
    
    @IBAction func tapClosePopup(_ sender: Any) {
        popup_bg.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.overlay.effect = nil
            self.popup.alpha = 0.0
        }) { finished in
            if let viewWithTag = self.view_head.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
                self.popup.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
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
//        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.2)
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

class LocationView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation?{
        willSet{
            if let _ = newValue{
                self.displayPriority = .required
            }
        }
    }
}

extension Home_VC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        time_in = ""
        time_out = ""
        
        UIView.animate(withDuration: 0.3, animations: {
            self.overlay.effect = nil
            self.popup.alpha = 0.0
        }) { finished in
            if let viewWithTag = self.view_head.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
                self.popup.isHidden = true
            }
        }
        
        switch tableView {
        case table_branch:
            activity_id = 0
            var b = BranchAlls?.data![indexPath.row]
            if b?.stamp_in == nil{b?.stamp_in = "-"}
            if b?.stamp_out == nil{b?.stamp_out = "-"}
            time_in = (b?.stamp_in)!
            time_out = (b?.stamp_out)!
            comp_name = (b?.comp_name)!
            branch_id = (b?.branch_id)!
            branch_name = (b?.branch_name)!
            comp_radius = Int(b!.comp_circumference!)!
            lat = Double((b?.lat)!)!
            lng = Double((b?.lng)!)!
            selectedLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            current_branch = branch_id
            setBranchName()
            setStampTime()
            setStampButton()
            resetOverlay()
            initMap()
            isUserInRange()
        case table_activity:
            var a = ActivityAlls?.data![indexPath.row]
            if a?.stamp_in == nil{a?.stamp_in = "-"}
            if a?.stamp_out == nil{a?.stamp_out = "-"}
            if a?.activity_name != nil {
                selected_activity_name = (a?.activity_name!)!
            }
            else {
                selected_activity_name = "no_activity".localized(gb.lang_now)
            }
            if a?.activity_cust != nil {
                selected_activity_cust = (a?.activity_cust!)!
            }
            else {
                selected_activity_cust = "no_customer".localized(gb.lang_now)
            }
            time_in = (a?.stamp_in)!
            time_out = (a?.stamp_out)!
            activity_id = Int(a!.id!)!
            comp_radius = 0
            resetOverlay()
            initMap()
            setActivityName()
            setStampTime()
            setStampButton()
        default:
            print("Some things wrong!!")
        }
        
        popup_bg.isHidden = true
    }
}

extension Home_VC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        switch tableView {
        case table_branch:
            row = popup_row
        case table_activity:
            row = activity_row
        default:
            print("Some things wrong!!")
        }
        return row
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case table_branch:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_branch", for: indexPath)
            let b = BranchAlls?.data![indexPath.row]
            cell.textLabel?.text = "\(String((b?.comp_name)!))(\(String((b?.branch_name)!)))"
            cell.textLabel?.textColor = UIColor.darkGray
            return cell
        case table_activity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_activity", for: indexPath)
            let a = ActivityAlls?.data![indexPath.row]
            let activity_name = a?.activity_name
            let activity_cust = a?.activity_cust
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "\("topic".localized(gb.lang_now)) : \(activity_name ?? "-")\n\("customer".localized(gb.lang_now)) : \(activity_cust ?? "-")\n\("start".localized(gb.lang_now)) : \(String((a?.start_time)!))\n\("end".localized(gb.lang_now)) : \(String((a?.end_time)!))"
            cell.textLabel?.textColor = UIColor.darkGray
            return cell
        default:
            print("Some things wrong!!")
            return UITableViewCell()
        }
    }
}

extension Home_VC{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        var circleRenderer = MKCircleRenderer()
        if let overlay = overlay as? MKCircle {
            circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.lineWidth = 1.5
            if(region_color == "red"){
                circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.3)
                circleRenderer.strokeColor = .red
            }
            else{
                circleRenderer.fillColor = UIColor.green.withAlphaComponent(0.3)
                circleRenderer.strokeColor = .green
            }
        }
        return circleRenderer
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
