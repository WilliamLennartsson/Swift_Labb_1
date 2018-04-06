//
//  SearchViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-04-04.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

protocol SearchCityDelegate {
    func searchForaNewCity(city: String)
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate : SearchCityDelegate?
    
    var cityList: [String] = []
    
    var serachController : UISearchController!
    
    var searchResult : [String] = []
    
    var displayedList : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        definesPresentationContext = true
        serachController = UISearchController(searchResultsController: nil)
        serachController.searchResultsUpdater = self
        serachController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = serachController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = serachController.searchBar.text?.lowercased() {
            searchResult = cityList.filter({ $0.lowercased().contains(text) })
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        if let text = serachController.searchBar.text {
            if text.isEmpty {
                return false
            } else {
                return serachController.isActive
            }
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return cityList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchCell
        
        
        if shouldUseSearchResult {
            displayedList = searchResult
        } else {
            displayedList = cityList
        }
        let cityName = displayedList[indexPath.row]
        
        cell.cityNameLbl.text = cityName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected row #\(indexPath.row)! ")
        let city = displayedList[indexPath.row]
        print(city)
        delegate?.searchForaNewCity(city: city)
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    

}
