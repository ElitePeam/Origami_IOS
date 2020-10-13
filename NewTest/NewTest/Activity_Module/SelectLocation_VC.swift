//
//  SelectLocation_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 24/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SelectLocation_VC: UIViewController, GMSMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txt_location: UITextField!
    @IBOutlet weak var view_map: UIView!
    
    var mapView = GMSMapView()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var toolBar : UIToolbar = UIToolbar()
    var btnDone = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem()
    var camera: GMSCameraPosition? = nil
    var marker = GMSMarker()
    var zoom = Float(17.0)
    var df_loc = CLLocationCoordinate2D(latitude: 13.7341051, longitude: 100.6271086)
    var page_type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_location.placeholder = ""
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.placeholder = "search_place".localized(gb.lang_now)
        searchController?.searchBar.setPlaceholder(textColor: .white)
        searchController?.searchBar.setSearchImage(color: .white)
        searchController?.searchBar.setClearButton(color: .white)
        searchController?.searchBar.setValue("cancle".localized(gb.lang_now), forKey: "cancelButtonText")
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        btnDone = UIBarButtonItem(title:"done".localized(gb.lang_now),
                                       style: .done,
                                       target: self,
                                       action: #selector(doneKey))
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil,
                                       action: nil)
        toolBar.items = [flexibleSpace,flexibleSpace,btnDone]
        txt_location.delegate = self
        txt_location.inputAccessoryView = toolBar
        
        camera  = GMSCameraPosition.camera(withLatitude: df_loc.latitude, longitude: df_loc.longitude, zoom: zoom)
        mapView = GMSMapView.map(withFrame: view_map.frame, camera: camera!)
        mapView.delegate = self
        view_map.addSubview(mapView)
        
        if page_type == "from_add" {
            if (gb.activityData?.location_lat == "" || gb.activityData?.location_lat == nil) && (gb.activityData?.location_long == "" || gb.activityData?.location_long == nil) {
                mapView.animate(toLocation: CLLocationCoordinate2D(latitude: df_loc.latitude, longitude: df_loc.longitude))
                mapView.animate(toZoom: zoom)
                txt_location.isEnabled = false
                txt_location.backgroundColor = gb.color_phd
            }
            else {
                txt_location.isEnabled = true
                txt_location.backgroundColor = UIColor.white
                txt_location.text = gb.activityData?.location
                mapView.animate(toLocation: CLLocationCoordinate2D(latitude: Double(gb.activityData!.location_lat)!, longitude: Double(gb.activityData!.location_long)!))
                mapView.animate(toZoom: zoom)
                marker.position = CLLocationCoordinate2D(latitude: Double(gb.activityData!.location_lat)!, longitude: Double(gb.activityData!.location_long)!)
                marker.title = gb.activityData?.location
                marker.map = mapView
            }
        }
        else {
            if (gb.activityData?.skoop_lat == "" || gb.activityData?.skoop_lat == nil) && (gb.activityData?.skoop_lng == "" || gb.activityData?.skoop_lng == nil) {
                mapView.animate(toLocation: CLLocationCoordinate2D(latitude: df_loc.latitude, longitude: df_loc.longitude))
                mapView.animate(toZoom: zoom)
                txt_location.isEnabled = false
                txt_location.backgroundColor = gb.color_phd
            }
            else {
                txt_location.isEnabled = true
                txt_location.backgroundColor = UIColor.white
                txt_location.text = gb.activityData?.skoop_location
                mapView.animate(toLocation: CLLocationCoordinate2D(latitude: Double(gb.activityData!.skoop_lat)!, longitude: Double(gb.activityData!.skoop_lng)!))
                mapView.animate(toZoom: zoom)
                marker.position = CLLocationCoordinate2D(latitude: Double(gb.activityData!.skoop_lat)!, longitude: Double(gb.activityData!.skoop_lng)!)
                marker.title = gb.activityData?.skoop_location
                marker.map = mapView
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_location {
            if page_type == "from_add" {
                gb.activityData?.location = textField.text ?? ""
            }
            else {
                gb.activityData?.skoop_location = textField.text ?? ""
            }
        }
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if page_type == "from_add" {
            gb.activityData?.location_lat = String(coordinate.latitude)
            gb.activityData?.location_long = String(coordinate.longitude)
        }
        else{
            gb.activityData?.skoop_lat = String(coordinate.latitude)
            gb.activityData?.skoop_lng = String(coordinate.longitude)
        }
        
        mapView.clear()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = txt_location.text
        marker.map = mapView
    }
    
    @objc func doneKey(sender:UIBarButtonItem!) {
        txt_location.resignFirstResponder()
    }
}


extension SelectLocation_VC: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    if page_type == "from_add" {
        gb.activityData?.location = place.name ?? ""
        gb.activityData?.location_lat = String(place.coordinate.latitude)
        gb.activityData?.location_long = String(place.coordinate.longitude)
    }
    else {
        gb.activityData?.skoop_location = place.name ?? ""
        gb.activityData?.skoop_lat = String(place.coordinate.latitude)
        gb.activityData?.skoop_lng = String(place.coordinate.longitude)
    }
    
    txt_location.text = place.name
    txt_location.isEnabled = true
    txt_location.backgroundColor = UIColor.white
    searchController?.isActive = false
//    mapView.clear()
    mapView.animate(toLocation: CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude))
    mapView.animate(toZoom: zoom)
    marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    marker.title = place.name
    marker.map = mapView
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    print("Error: ", error.localizedDescription)
  }

  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
