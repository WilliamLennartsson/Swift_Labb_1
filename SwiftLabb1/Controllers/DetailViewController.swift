//
//  DetailViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-25.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var weatherImgView: UIImageView!
    
    @IBOutlet weak var compareTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    var dWeatherHelper = WeatherHelper()
    
    var city = City()
    
    var citiesToCompare : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(city.name)
        whatWeather()
        compareTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        compareTableView.setNeedsDisplay()
        compareTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dWeatherHelper.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "compareCell") as! CompareCell
        
        cell.cityName.text = dWeatherHelper.cityList[indexPath.row].name
        
        return cell
    }

    
    func whatWeather(){
        cityNameLabel.text = city.name
        cityTempLabel.text = String(city.temperature)
        
        let temp = city.temperature
        switch temp {
            case -10...0:
                weatherImgView.image = #imageLiteral(resourceName: "snow")
            case 0...12:
                weatherImgView.image =  #imageLiteral(resourceName: "liteKallt")
            case 12...20:
                weatherImgView.image =  #imageLiteral(resourceName: "sol")
            case 20...35:
                weatherImgView.image =  #imageLiteral(resourceName: "strand")
            default:
                print("No picture")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
