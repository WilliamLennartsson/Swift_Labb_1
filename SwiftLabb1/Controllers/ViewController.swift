//
//  ViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController , SearchCityDelegate{
    
    let weatherHelper = WeatherHelper()
    
    @IBOutlet weak var cityTempLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet var mainView: UIView!
    
    
    var currentWeahterName = ""
    var searchNameList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cityNameLbl.isHidden = true
//        cityTempLbl.isHidden = true
//        addBtn.isHidden = true
        weatherHelper.loadSavedCities()
        //addBtn.frame(x: 10, y: 50, width: 100, height: 100)
        self.searchBtn.isEnabled = false
        let queue = DispatchQueue(label: "Load JSON")
        queue.async {
            self.readJson()
        }
        
        let animationLbl = UILabel()
        animationLbl.frame = CGRect(x: 250, y: -50, width: 100, height: 100)
        animationLbl.backgroundColor = .gray
        animationLbl.text = "Hej alla"
        animationLbl.textAlignment = .center
        animationLbl.textColor = .black
        
        mainView.addSubview(animationLbl)
        
        UIView.beginAnimations("MoveAround", context: nil)
        UIView.setAnimationDuration(2.5)
        UIView.setAnimationDelay(1.0)
        UIView.setAnimationCurve( .easeIn)
        
        animationLbl.center = CGPoint(x: 250, y: 100)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func searchForaNewCity(city: String) {
        currentWeahterName = city
        weatherHelper.getWeatherForHomeScreen(cityName: city, nameLabel: cityNameLbl, tempLabel: cityTempLbl)
        cityNameLbl.isHidden = false
        cityTempLbl.isHidden = false
        addBtn.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSeg" {
            let weatherController = segue.destination as! WeatherViewController
            
                weatherHelper.cityName = currentWeahterName
            
            weatherController.weatherHelper = self.weatherHelper
        } else if segue.identifier == "searchSeg" {
            let searchController = segue.destination as! SearchViewController
            searchController.delegate = self
            searchController.cityList = self.searchNameList
            
        }
        else {
            print("No such seääg")
        }
    }
    
    func readJson(){
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                createCityArray(jsonObj: jsonObj)
                
                searchBtn.isEnabled = true
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    func createCityArray(jsonObj: JSON) {
        
        let arr = jsonObj.array!
        for index in 0..<arr.count {
            let obj = arr[index]
            let cityName = obj["name"].string!
            searchNameList.append(cityName)
            
        }
    }
    
}
