//
//  CoordinateMap_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 30/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CoordinateMap_VC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var view_detail: UIView!
    @IBOutlet weak var label_latlng: UILabel!
    @IBOutlet weak var button_ok: UIButton!
    @IBOutlet weak var txt_location: UITextField!
    
    let locationManager = CLLocationManager()
    var viewPostion = CLLocationCoordinate2D()
    var nowPostion = CLLocationCoordinate2D()
    var setPosition = false
    var resultSearchController:UISearchController? = nil
    var location_name = ""
    var kb_height = 0.0
    var send_from = ""
    var selected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLoad()
        txt_location.text = location_name
        txt_location.placeholder = "mark_place".localized(gb.lang_now)
        button_ok.setTitle("pin".localized(gb.lang_now), for: .normal)
        button_ok.layer.cornerRadius = 4
        button_ok.layer.borderWidth = 2
        button_ok.layer.borderColor = UIColor.systemOrange.cgColor
        button_ok.clipsToBounds = true
        
        view_detail.layer.shadowOffset = CGSize(width: 0, height: -1)
        view_detail.layer.shadowRadius = 2
        view_detail.layer.shadowOpacity = 1
        view_detail.layer.shadowColor = UIColor.lightGray.cgColor
        view_detail.clipsToBounds = false
        view_detail.layer.masksToBounds = false
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view_detail.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view_detail.addSubview(blurEffectView)
        view_detail.bringSubviewToFront(label_latlng)
        view_detail.bringSubviewToFront(button_ok)
        view_detail.bringSubviewToFront(txt_location)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))
        panGesture.delegate = self
        mapView.addGestureRecognizer(panGesture)
        
        mapView(mapView, regionDidChangeAnimated: true)
        
        // Search bar
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "SearchLocation_TVC") as! SearchLocation_TVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "search_place".localized(gb.lang_now)
        searchBar.setPlaceholder(textColor: .white)
        searchBar.setSearchImage(color: .white)
        searchBar.setClearButton(color: .white)
        searchBar.setValue("cancle".localized(gb.lang_now), forKey: "cancelButtonText")
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = UIColor.white
        let cancelButton = UIBarButtonItem(title:"cancle".localized(gb.lang_now),style: .plain, target: self, action: #selector(cancelTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title:"done".localized(gb.lang_now),style: .done, target: self, action: #selector(doneTapped))
        cancelButton.tintColor = UIColor.systemOrange
        doneButton.tintColor = UIColor.systemOrange
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        
        txt_location.inputAccessoryView = toolBar
        txt_location.autocorrectionType = .no
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewPostion.latitude, longitude: viewPostion.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        closeLoad()
    }
    
    @objc func doneTapped(sender:UIBarButtonItem!) {
        if txt_location.isFirstResponder{
            txt_location.resignFirstResponder()
        }
    }
    @objc func cancelTapped(sender:UIBarButtonItem!) {
       if txt_location.isFirstResponder{
           txt_location.resignFirstResponder()
       }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if Double(keyboardSize.height) > kb_height{
                kb_height = Double(keyboardSize.height)
            }
            if txt_location.isFirstResponder {
                if txt_location.frame.origin.y < keyboardSize.height && self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= CGFloat(kb_height)
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        mapView(mapView, regionDidChangeAnimated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if !setPosition {
            if viewPostion.longitude == 0.0 && viewPostion.latitude == 0.0 {
                viewPostion = locValue
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewPostion.latitude, longitude: viewPostion.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
            }
            setPosition = true
        }
    }
    
    func moveView(coor:CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coor.latitude, longitude: coor.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        nowPostion = mapView.centerCoordinate
        let lat = String(format: "%.6f", nowPostion.latitude)
        let lng = String(format: "%.6f", nowPostion.longitude)
        label_latlng.text = "\(lat) , \(lng)"
    }

    @IBAction func tapChoose(_ sender: Any) {
        selected = true
        mapView(mapView, regionDidChangeAnimated: true)
        
        var location_name = txt_location.text!
        let lat = String(nowPostion.latitude)
        let lng = String(nowPostion.longitude)
        if nowPostion.latitude != 0.0 && nowPostion.longitude != 0.0 {
            if location_name == "" {
                location_name = "No place title"
            }
        }
        else {
            location_name = "No place selected"
        }

        if send_from == "field_ship" {
            gb.selected_shipLocation                                        = location_name
            gb.selected_shipLat                                             = lat
            gb.selected_shipLng                                             = lng
            gb.ship_change = true
        }
        else if send_from == "field_doc" {
            gb.selected_docLocation                                         = location_name
            gb.selected_docLat                                              = lat
            gb.selected_docLng                                              = lng
            gb.doc_change = true
        }
        else if send_from == "field_address" {
            gb.selected_cusLocation                                         = location_name
            gb.selected_cusLat                                              = lat
            gb.selected_cusLng                                              = lng
            gb.cus_change = true
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//
//
//    }
}
