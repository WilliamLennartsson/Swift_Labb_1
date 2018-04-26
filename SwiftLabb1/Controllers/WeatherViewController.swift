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
    var cityList = [City]()
    var weatherHelper = WeatherHelper()
    let model = Model()
    
    @IBOutlet weak var compareBtn: UIButton!
    struct CityDecoded : Decodable{
        let humidity : Float
        let temp : Float
        let name : String
        //var infoText = String()
        let temp_min = Float()
        let temp_max = Float()
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        refresh()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        refresh()
        
    }
    
    func refresh(){
        cityList = weatherHelper.cityList
        tableView.reloadData()
        print(cityList)
    }
    
    @IBOutlet weak var btnPressed: UIButton!

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let homeScreenCity = weatherHelper.currentHomeScreenCity {
            if weatherHelper.cityList.contains(homeScreenCity){
                return weatherHelper.cityList.count
            } else {
                weatherHelper.addCityToFavs(city: homeScreenCity)
                
            }
        }
        
        return weatherHelper.cityList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
            weatherHelper.getWeatherWithCell(cityName: weatherHelper.cityList[indexPath.row].name, cell)
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeg" {
            let detailController = segue.destination as! DetailViewController
            let cityList = weatherHelper.cityList
            if let cell = sender as? CustomTableViewCell{
                let indexOfCell : Int = tableView.indexPath(for: cell)!.row
                let cellCity : City = cityList[indexOfCell]
                detailController.city = cellCity
                detailController.dWeatherHelper = weatherHelper
            }
        }
        if segue.identifier == "compareSeg"{
            let controller = segue.destination as! CompareViewController
            controller.weatherHelper = self.weatherHelper
        }
    }
}


