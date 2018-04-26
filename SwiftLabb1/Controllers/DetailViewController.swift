//
//  DetailViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-25.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var weatherImgView: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    @IBOutlet weak var cityWindLabel: UILabel!
    @IBOutlet weak var cityHumidityLabel: UILabel!
    var dWeatherHelper = WeatherHelper()
    
    var city = City()
    
    var citiesToCompare : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(city.name)
        whatWeather()
    }
    
    func whatWeather(){
        cityNameLabel.text = city.name
        cityTempLabel.text = "\(String(city.temperature)) ・C"
        cityHumidityLabel.text = "\(String(city.humidity)) %"
        cityWindLabel.text = "\(String(city.windSpeed)) m/s"
        
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
