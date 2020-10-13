//
//  SelectAddress_TVC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 10/7/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class SelectAddress_TVC: UITableViewController, UISearchResultsUpdating, UINavigationControllerDelegate {
    
    var country:[Country]? = []
    var province:[Province]? = []
    var district:[District]? = []
    var sub_district:[Sub_District]? = []
    var postcode:[Postcode]? = []
    var type = ""
    var filteredCountry: [Country] = []
    var filteredProvince: [Province] = []
    var filteredDistrict: [District] = []
    var filteredSub_district: [Sub_District] = []
    var filteredPostcode: [Postcode] = []
    let searchController = UISearchController(searchResultsController: nil)
    var selected_country_id = ""
    var selected_country_name = ""
    var selected_province_id = ""
    var selected_province_name = ""
    var selected_distict_id = ""
    var selected_distict_name = ""
    var selected_sub_distict_id = ""
    var selected_sub_distict_name = ""
    var selected_postcode_id = ""
    var district_from_sub = ""
    var selected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        tableView.register(Address_TC.self, forCellReuseIdentifier: "tc")
        tableView.rowHeight = 60
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        searchController.searchBar.setPlaceholder(textColor: .lightGray)
        searchController.searchBar.setSearchImage(color: .lightGray)

        let searchField = searchController.searchBar.searchTextField
        searchField.tintColor = .lightGray
        searchField.backgroundColor = .white
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if type == "country" {
            filteredCountry = country!.filter { (ct: Country) -> Bool in
                return ct.country_name!.lowercased().contains(searchText.lowercased())
            }
        }
        if type == "province" {
            filteredProvince = province!.filter { (ct: Province) -> Bool in
                return ct.province_name!.lowercased().contains(searchText.lowercased())
            }
        }
        if type == "distict" {
            filteredDistrict = district!.filter { (ct: District) -> Bool in
                return ct.district_name!.lowercased().contains(searchText.lowercased())
            }
        }
        if type == "sub_distict" {
            filteredSub_district = sub_district!.filter { (ct: Sub_District) -> Bool in
                return ct.sub_district_name!.lowercased().contains(searchText.lowercased())
            }
        }
        if type == "postcode" {
            filteredPostcode = postcode!.filter { (ct: Postcode) -> Bool in
                return ct.post_code!.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "country" {
            if isFiltering {
              return filteredCountry.count
            }
            if country == nil {
                return 0
            }
            return country!.count
        }
        if type == "province" {
            if isFiltering {
              return filteredProvince.count
            }
            if province == nil {
                return 0
            }
            return province!.count
        }
        if type == "distict" {
            if isFiltering {
              return filteredDistrict.count
            }
            if district == nil {
                return 0
            }
            return district!.count
        }
        if type == "sub_distict" {
            if isFiltering {
              return filteredSub_district.count
            }
            if sub_district == nil {
                return 0
            }
            return sub_district!.count
        }
        if type == "postcode" {
            if isFiltering {
              return filteredPostcode.count
            }
            if postcode == nil {
                return 0
            }
            return postcode!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tc", for: indexPath) as! Address_TC
        cell.selectionStyle = .none
        if type == "country" {
            let ct : Country
            if isFiltering {
              ct = filteredCountry[indexPath.row]
            } else {
            ct = country![indexPath.row]
            }
            cell.textLabel!.text = ct.country_name
        }
        if type == "province" {
           let ct : Province
           if isFiltering {
             ct = filteredProvince[indexPath.row]
           } else {
             ct = province![indexPath.row]
           }
           cell.textLabel!.text = ct.province_name
        }
        
        if type == "distict" {
           let ct : District
           if isFiltering {
             ct = filteredDistrict[indexPath.row]
           } else {
             ct = district![indexPath.row]
           }
            cell.textLabel!.text = ct.district_name
        }
        if type == "sub_distict" {
           let ct : Sub_District
           if isFiltering {
             ct = filteredSub_district[indexPath.row]
           } else {
             ct = sub_district![indexPath.row]
           }
            cell.textLabel!.text = ct.sub_district_name
        }
        if type == "postcode" {
           let ct : Postcode
           if isFiltering {
             ct = filteredPostcode[indexPath.row]
           } else {
             ct = postcode![indexPath.row]
           }
            cell.textLabel!.text = ct.post_code
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "country" {
            let ct:Country
            if isFiltering {
              ct = filteredCountry[indexPath.row]
            } else {
              ct = country![indexPath.row]
            }
            selected_country_id = ct.country_id!
            selected_country_name = ct.country_name!
        }
        if type == "province" {
            let ct:Province
            if isFiltering {
              ct = filteredProvince[indexPath.row]
            } else {
              ct = province![indexPath.row]
            }
            selected_province_id = ct.province_id!
            selected_province_name = ct.province_name!
        }
        if type == "distict" {
            let ct:District
            if isFiltering {
              ct = filteredDistrict[indexPath.row]
            } else {
              ct = district![indexPath.row]
            }
            selected_distict_id = ct.district_id!
            selected_distict_name = ct.district_name!
        }
        if type == "sub_distict" {
            let ct:Sub_District
            if isFiltering {
              ct = filteredSub_district[indexPath.row]
            } else {
              ct = sub_district![indexPath.row]
            }
            selected_sub_distict_id = ct.sub_district_id!
            selected_sub_distict_name = ct.sub_district_name!
            district_from_sub = ct.district_id!
        }
        if type == "postcode" {
            let ct:Postcode
            if isFiltering {
              ct = filteredPostcode[indexPath.row]
            } else {
              ct = postcode![indexPath.row]
            }
            selected_postcode_id = ct.post_code!
        }
        selected = true
        navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if type == "country" {
            (viewController as? AddAccount_VC)?.selected_country_id     = selected_country_id
            (viewController as? AddAccount_VC)?.selected_country_name   = selected_country_name
            (viewController as? AddAccount_VC)?.txt_country.text        = selected_country_name
            (viewController as? AddAccount_VC)?.filterProvince(country_id: selected_country_id)
            if selected {(viewController as? AddAccount_VC)?.setSeq(seq: 1)}
            (viewController as? AddAccount_VC)?.setThailand(country_id: selected_country_id)
        }
        if type == "province" {
            (viewController as? AddAccount_VC)?.selected_province_id    = selected_province_id
            (viewController as? AddAccount_VC)?.selected_province_name  = selected_province_name
            (viewController as? AddAccount_VC)?.txt_province.text       = selected_province_name
            (viewController as? AddAccount_VC)?.filterDistict(province_id: selected_province_id)
            if selected {(viewController as? AddAccount_VC)?.setSeq(seq: 2)}
        }
        if type == "distict" {
            (viewController as? AddAccount_VC)?.selected_district_id    = selected_distict_id
            (viewController as? AddAccount_VC)?.selected_district_name  = selected_distict_name
            (viewController as? AddAccount_VC)?.txt_district.text       = selected_distict_name
            (viewController as? AddAccount_VC)?.filterSubDistict(distict_id: selected_distict_id)
            if selected {(viewController as? AddAccount_VC)?.setSeq(seq: 3)}
        }
        if type == "sub_distict" {
            (viewController as? AddAccount_VC)?.selected_subdistrict_id    = selected_sub_distict_id
            (viewController as? AddAccount_VC)?.selected_subdistrict_name  = selected_sub_distict_name
            (viewController as? AddAccount_VC)?.txt_subdistrict.text       = selected_sub_distict_name
            (viewController as? AddAccount_VC)?.filterPost(distict_id: district_from_sub)
            if selected {(viewController as? AddAccount_VC)?.setSeq(seq: 4)}
        }
        if type == "postcode" {
            (viewController as? AddAccount_VC)?.selected_postcode = selected_postcode_id
            (viewController as? AddAccount_VC)?.txt_postcode.text = selected_postcode_id
        }
    }
}

//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = gb.color_main
//        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
