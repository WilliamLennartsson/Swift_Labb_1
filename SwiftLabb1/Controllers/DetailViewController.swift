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
    
    @IBOutlet weak var tipLabel: UILabel!
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
        //String(format: "%.1f", city.temperature)
        cityTempLabel.text = "\(String(format: "%.1f", city.temperature)) ・C"
        cityHumidityLabel.text = "\(String(format: "%.1f", city.humidity)) %"
        cityWindLabel.text = "\(String(format: "%.1f", city.windSpeed)) m/s"
        
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
        tipLabel.text = "Hej"
        let windSpeed: Float = city.windSpeed
        switch windSpeed {
        case 0...4:
            tipLabel.text = "The weather is calm as a cucumber"
        case 4...8:
            tipLabel.text = "Light breeze. It's all good"
        case 8...14:
            tipLabel.text = "Perfect wind for surfing!"
        case 14...20:
            tipLabel.text = "Windcoat is a good idea"
        case 20...26:
            tipLabel.text = "Caution! Rough wind!"
        case 26...100:
            tipLabel.text = "STAY INSIDE"
        default:
            tipLabel.text = "No recommendation"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
