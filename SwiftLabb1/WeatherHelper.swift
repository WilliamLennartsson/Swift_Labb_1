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
var searchWord : String = "Varberg"
//let SEARCH_PATH = "http://api.openweathermap.org/data/2.5/weather?q=\CityNameGoesHere&APPID=9b58a649a30afe46cd3fe20f91fdb602"


func getWeather(city: String){
    let session = URLSession.shared
    let weatherRequestURL = NSURL(string: "\(searchBaseURL)?APPID=\(API_KEY)&q=\(city)")!
    
    let dataTask = session.dataTask(with: weatherRequestURL as URL) {
        
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print("Error:\n\(error)")
        } else {
            //if let todoJSON = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            
            do {
            let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                 print("City\(String(describing: weather["name"]))")
                
            }
            catch let jsonError as NSError {
                print("Nu gick det fel här")
            
            }
            
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print("Data:\n\(data!)")
            print("Human-readable data:\n\(dataString!)")
            
        }
    }
    dataTask.resume()
}

