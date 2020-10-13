//
//  SearchLocation_TVC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 1/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import MapKit

class SearchLocation_TVC: UITableViewController, UISearchResultsUpdating {
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight =  60
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
        let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return matchingItems.count
       }
       

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
//        cell.detailTextLabel?.text = selectedItem.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        gb.mapkit_location = selectedItem.name!
        if let pvc = self.presentingViewController as? CoordinateMap_VC {
            pvc.txt_location.text = gb.mapkit_location
            let nowPostion = selectedItem.coordinate
            let lat = String(format: "%.6f", nowPostion.latitude)
            let lng = String(format: "%.6f", nowPostion.longitude)
            pvc.label_latlng.text = "\(lat) , \(lng)"
            pvc.moveView(coor: selectedItem.coordinate)
        }
        dismiss(animated: true, completion: nil)
    }
}



