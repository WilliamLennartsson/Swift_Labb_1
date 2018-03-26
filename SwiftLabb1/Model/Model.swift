//
//  Model.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class Model {
    let API_KEY = "9b58a649a30afe46cd3fe20f91fdb602"
    let searchBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    let aboluteZero : Float = 273.15
    var searchWord : String = "Varberg"
    var cityList : [City] = []
    
    func addCity(city: City){
        cityList.append(city)
    }
}
