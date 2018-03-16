//
//  WeatherHelper.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//

import Foundation


let API_KEY = "9b58a649a30afe46cd3fe20f91fdb602"
let searchBaseURL = "http://api.openweathermap.org/data/2.5/weather"
let aboluteZero : Float = 273.15
var searchWord : String = "Varberg"


//let SEARCH_PATH = "http://api.openweathermap.org/data/2.5/weather?q=\CityNameGoesHere&APPID=9b58a649a30afe46cd3fe20f91fdb602"


func getWeather(cityName: String, model: Model){
    
    
    
    let session = URLSession.shared
    let weatherRequestURL = NSURL(string: "\(searchBaseURL)?APPID=\(API_KEY)&q=\(cityName)")!
    
    let dataTask = session.dataTask(with: weatherRequestURL as URL) {
        
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            //Error
            print("Error:\n\(error)")
        } else {
            
            do {
                //Det gick bra
                let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                let city = City()
                city.name = weather["name"]! as! String
                city.temperature = (weather["main"]!["temp"]!! as! Float)  - Float(aboluteZero)
                
                //print("City name =  \(city.name)")
                //print("City ntemp =  \(city.temperature)")

                print("City -> \n \(city.name) , \(city.temperature)")

                print("City\(weather["name"]!)")
                print("Temp -> \n \(weather["main"]!["temp"]!!)")
                print("Humidity -> \n \(weather["main"]!["humidity"]!!)")
                
            } catch let jsonError as NSError {
                print("Nu gick det fel här med Json . \(jsonError.description)")
            }
            
        let dataString = String(data: data!, encoding: String.Encoding.utf8)
        print("Data:\n\(data!)")
        print("Human-readable data:\n\(dataString!)")
            
        }
    }
    dataTask.resume()
}
