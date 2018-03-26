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
    var dWeatherHelper = WeatherHelper()
    var city = City()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(city.name)
        whatWeather()
    }

    func whatWeather(){
        cityNameLabel.text = city.name
        cityTempLabel.text = String(city.temperature)
        
        let temp = city.temperature
        
        switch temp {
        case -10...0: weatherImgView.image = #imageLiteral(resourceName: "snow")
        case 1...15: weatherImgView.image =  #imageLiteral(resourceName: "liteKallt")
        case 16...23: weatherImgView.image =  #imageLiteral(resourceName: "sol")
        case 24...100: weatherImgView.image =  #imageLiteral(resourceName: "strand")
        default:
            print("No picture")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
