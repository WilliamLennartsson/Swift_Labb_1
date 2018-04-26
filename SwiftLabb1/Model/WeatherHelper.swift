//
//  WeatherHelper.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//
    
//Get weather method
//let SEARCH_PATH = "http://api.openweathermap.org/data/2.5/weather?q=\CityNameGoesHere&APPID=9b58a649a30afe46cd3fe20f91fdb602"
import UIKit
class WeatherHelper : NSObject, UITableViewDelegate {
    let API_KEY = "9b58a649a30afe46cd3fe20f91fdb602"
    let searchBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    let aboluteZero : Float = 273.15
    var cityList : [City] = []
    var cityName : String = ""
    var favCities : [String] = []
    var currentHomeScreenCity : City?
    
    func getWeatherForHomeScreen(cityName : String, nameLabel : UILabel, tempLabel : UILabel){
        //if let safeString = cell.cityLabel.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),

        let session = URLSession.shared
        
        let weatherRequestURL = NSURL(string: "\(searchBaseURL)?APPID=\(API_KEY)&q=\(cityName)")!
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                //Error
                print("Error:\n\(error)")
            } else {
                if let realData = data {
                    do {
                        let weather = try JSONSerialization.jsonObject(with: realData, options: .mutableContainers) as? [String : AnyObject]
                        
                        DispatchQueue.main.async {
                            let city = self.convertToCity(weather: weather!)
                            self.currentHomeScreenCity = city
                            nameLabel.text = city.name
                            tempLabel.text = "\(String(city.temperature))・C"
                            let defaults = UserDefaults.standard
                            defaults.string(forKey: "homeScreen")
                        }
                        
                    } catch let jsonError as NSError {
                        print("Nu gick det fel här med Json . \(jsonError.description)")
                    }
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    print("Data:\n\(dataString ?? "ingen data")")
                    
                }
            }
        }
        dataTask.resume()
        
        
    }
    
    func getWeatherWithCell(cityName: String, _ cell: CustomTableViewCell){
        print("Inside GetWeather function")
        let session = URLSession.shared
        let weatherRequestURL = NSURL(string: "\(searchBaseURL)?APPID=\(API_KEY)&q=\(cityName)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                //Error
                print("Error:\n\(error)")
            } else {
                if let realData = data {
                    do {
                        let weather = try JSONSerialization.jsonObject(with: realData, options: .mutableContainers) as? [String : AnyObject]

                        DispatchQueue.main.async {
                            let city = self.convertToCity(weather: weather!)
                            
                            self.updateCellInfo(city: city, cell: cell)
                        }
                        
                    } catch let jsonError as NSError {
                        print("Nu gick det fel här med Json . \(jsonError.description)")
                    }
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    print("Data:\n\(data!)")
                    print("Human-readable data:\n\(dataString!)")
                }
            }
        }
        dataTask.resume()
    }
    
    func updateCellInfo(city : City, cell : CustomTableViewCell){
        if city.name != "" {
            cell.name.text = city.name
            cell.temperature.text = "\(String(city.temperature)) C"
            cell.imgThumbNail.layer.cornerRadius = cell.imgThumbNail.frame.height / 2
            cell.imgThumbNail.image = UIImage(named: "sunset")
        } else {
            cell.name.text = "Error"
            cell.imgThumbNail.layer.cornerRadius = cell.imgThumbNail.frame.height / 2
            cell.imgThumbNail.image = UIImage(named: "errorImage")
            cell.temperature.text = ""
        }
        
    }

    func convertToCity(weather : [String : AnyObject]) -> City{
        let city = City()
        if let weatherName : String = weather["name"] as? String {
            city.name = weatherName
            let main = weather["main"] as? NSDictionary
            //print("Main dictionary \(main)")
            if let weatherTemp: NSNumber = main!["temp"] as? NSNumber {
                city.temperature = weatherTemp.floatValue - aboluteZero
            } else {
                print("weatherTemp error")
            }
            if let humidity: NSNumber = main!["humidity"] as? NSNumber {
                city.humidity = humidity.floatValue
            } else {print("Humidity error")}
            
            if let weatherMaxTemp : NSNumber = (main!["temp_max"] as? NSNumber){
                city.temp_max = weatherMaxTemp.floatValue
            } else { print("weatherMaxTemp error") }
            
            if let weatherMinTemp : NSNumber = (main!["temp_max"] as? NSNumber){
                city.temp_min = weatherMinTemp.floatValue
            } else { print("weatherMinTemp error") }
            //print(weather["wind"])
            if let wind : Float = weather["wind"]?["speed"] as? Float {
                city.windSpeed = wind
            } else {print("Windspeed error")}
            
        } else {
            print("weatherName error")
        }
        return city
    }
    
    func addCityToFavs(city:City){
        if city.name != "" {
            cityList.append(city)
            favCities.append(city.name)
            
            let defaults = UserDefaults.standard
            defaults.set(favCities, forKey: "SavedStringArray")
    
            print("CITYLIST COUNT ---- \(cityList.count)")
        }
    }
    
    func loadSavedCities (){
        let defaults = UserDefaults.standard
        favCities = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        for element in favCities {
            self.loadFavCities(cityName: element)
        }
        print(" USER DEFAULTS Å SÅNT  \(favCities)")
    
    }
    
    func loadFavCities(cityName : String){
        let session = URLSession.shared
        let weatherRequestURL = NSURL(string: "\(searchBaseURL)?APPID=\(API_KEY)&q=\(cityName)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let realData = data {
                    do {
                        let weather = try JSONSerialization.jsonObject(with: realData, options: .mutableContainers) as? [String : AnyObject]
                        DispatchQueue.main.async {
                            let city = self.convertToCity(weather: weather!)
                            self.cityList.append(city)
                        }
                        
                    } catch let jsonError as NSError {
                        print("Nu gick det fel här med Json . \(jsonError.description)")
                    }
//                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
//                    print("Data:\n\(dataString)")
                    
                }
            }
        }
        dataTask.resume()
    }
    
}

