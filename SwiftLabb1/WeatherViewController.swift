//
//  WeatherViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var model = Model()
    var cityList = [City]()

    override func viewDidLoad() {
        cityList = model.getCityList()
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        //var city = City(temperature: -5, name: "Humlegården", infoText: "Fint ställe med många cyklar")
        //var cityList : [City] = 
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        
        let city = cityList[indexPath.row]
        
        
        //cell.imgThumbNail.layer.cornerRadius = cell.imgThumbNail.frame.height / 2
        cell.imgThumbNail.image = UIImage(named: "sunset")
        cell.name.text = city.name
        cell.temperature.text = "\(city.temperature) ◦C"
        
        
        return cell
    }
}
