//
//  WeatherViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let model = Model()
    var cityList = [City]()

    @IBAction func searchBtnPressed(_ sender: Any) {
        if let searchInput :String =
            searchText.text!{
            //Lägg searchen på en annan thread? -Que
            model.searchCity(city: searchInput)
        } else {
            print("searchText empty")
        }
        //let que = DispatchQueue.
        tableView.reloadData()
        loadViewIfNeeded()
    }
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        model.loadCities()
        cityList = model.cityList
        loadViewIfNeeded()
    }
    @IBOutlet weak var btnPressed: UIButton!

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        
        
        if cityList.count  > indexPath.row{
            let city = cityList[indexPath.row]
            print("\(city.name)")
            
            //cell.imgThumbNail.layer.cornerRadius = cell.imgThumbNail.frame.height / 2
            cell.imgThumbNail.image = UIImage(named: "sunset")
            cell.name.text = city.name
            cell.temperature.text = "\(city.temperature) ◦C"
        }
        
        return cell
    }
}
