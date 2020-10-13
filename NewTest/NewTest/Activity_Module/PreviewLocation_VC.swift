//
//  PreviewLocation_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 25/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PreviewLocation_VC: UIViewController {

    var mapView = GMSMapView()
    var coor = CLLocationCoordinate2D()
    var lat = "0.0"
    var lng = "0.0"
    var from_page = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        
        let camera = GMSCameraPosition.camera(withLatitude: coor.latitude, longitude: coor.longitude, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = coor
        marker.title = "Selected Place"
        marker.map = mapView
        
    }
    
    func initLayout(){
        self.title = "preview_map".localized(gb.lang_now)
        coor.latitude  = Double(lat)!
        coor.longitude = Double(lng)!
    }
}
