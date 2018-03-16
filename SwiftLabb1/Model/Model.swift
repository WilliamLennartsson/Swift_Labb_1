//
//  Model.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class Model: NSObject {
    var cityList : [City] = []
    override init() {
        let city = City(temperature: 11, name: "Varberg", infoText: "Tjo boråsare")
        let city2 = City(temperature: 15, name: "Halmstad", infoText: "Haaaaaalmstad")
        cityList.append(city)
        cityList.append(city2)
        
    }
    
    func addCity (city: City) {
        cityList.append(city)
        print ("City Added \(city)")
    }
    
    func searchCity (city: String) {
         getWeather(cityName: city, model: self)
    }

    
    func loadCities (){
        let list = ["Gothenburg", "Varberg", "Boras",]
        for i in list {
            //let city : City =
            getWeather(cityName: i, model: self)
            //cityList.append(city)
        }
    }

}
