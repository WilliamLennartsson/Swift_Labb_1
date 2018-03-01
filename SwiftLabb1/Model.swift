//
//  Model.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class Model: NSObject {
    let list : [(cityName: String, temprature:  Int)] = [("Rome", -1), ("Vaabäj", -13), ("Fakenbäj", -25), ("Nufjiri hazikan", 23), ("Göteborg", -100),("Mumindalen", 12), ("Hjällbo", 25)]
    
    func spawnCity (i : Int) -> City{
        var j = i
        if i >= list.count{
            j -= list.count
        }
        
        let city = City(temperature: list[j].temprature, name: list[j].cityName, infoText: "")
        return city
    }
    
    func getCityList () -> [City]{
        var cityList = [City]()
        for index in 1...list.count {
            let city = spawnCity(i: index)
            cityList.append(city)
        }
        return cityList
    }
}
