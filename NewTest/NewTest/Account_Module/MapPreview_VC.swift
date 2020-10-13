//
//  MapPreview_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 4/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPreview_VC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var view_bottom_tab: UIView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var label_coor: UILabel!
    
    let locationManager = CLLocationManager()
    var viewPostion = CLLocationCoordinate2D()
    var lat = ""
    var lng = ""
    var txt_location = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "preview_map".localized(gb.lang_now)
        viewPostion.latitude = Double(lat)!
        viewPostion.longitude = Double(lng)!
        label_location.text = txt_location
        label_coor.text = "\(String(lat)) , \(String(lng))"
        
        view_bottom_tab.layer.shadowOffset = CGSize(width: 0, height: -1)
        view_bottom_tab.layer.shadowRadius = 2
        view_bottom_tab.layer.shadowOpacity = 1
        view_bottom_tab.layer.shadowColor = UIColor.lightGray.cgColor
        view_bottom_tab.clipsToBounds = false
        view_bottom_tab.layer.masksToBounds = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view_bottom_tab.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view_bottom_tab.addSubview(blurEffectView)
        view_bottom_tab.bringSubviewToFront(label_location)
        view_bottom_tab.bringSubviewToFront(label_coor)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = viewPostion
        annotation.title = txt_location
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewPostion.latitude, longitude: viewPostion.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
}
