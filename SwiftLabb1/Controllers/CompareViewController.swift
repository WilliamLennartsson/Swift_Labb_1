//
//  CompareViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-04-05.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit
import GraphKit

class CompareViewController: UIViewController, GKBarGraphDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var graphView1: GKBarGraph!

    @IBOutlet weak var pickerView1: UIPickerView!
    
    var weatherHelper = WeatherHelper()
    var cityList : [City] = []
    var comparingCities : [City] = []
    var city1Elements : [Int] = []
    var city2Elements : [Int] = []
    let data : [String] = ["Temp", "Windspeed", "humidity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.dataSource = self
        pickerView1.delegate = self
        graphView1.dataSource = self
        cityList = weatherHelper.cityList
        
    }
    
    func citySelected (component : Int, cityIndex : Int){
        switch component {
        case 0:
            city1Elements = []
            let city = cityList[cityIndex]
            city1Elements.append(Int(city.temperature))
            city1Elements.append(Int(city.windSpeed))
            city1Elements.append(Int(city.humidity))
            
        case 1:
            city2Elements = []
            let city = cityList[cityIndex]
            city2Elements.append(Int(city.temperature))
            city2Elements.append(Int(city.windSpeed))
            city2Elements.append(Int(city.humidity))
        default:
            return
        }
        
    }
    
    //Picker View
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        citySelected(component: component, cityIndex: row)
        if (!city1Elements.isEmpty && !city2Elements.isEmpty){
            graphView1.draw()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row].name
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    
    // Graph View    
    func numberOfBars() -> Int {
        return 6
    }
    func titleForBar(at index: Int) -> String! {
        if index >= data.count {
            return data[index - data.count]
        } else {
            return "\(data[index])"
        }
        
    }
    func valueForBar(at index: Int) -> NSNumber! {
        if index < city1Elements.count {
            return city1Elements[index] as NSNumber
        } else {
            return city2Elements[index - city1Elements.count] as NSNumber
        }
    }
    
    func valueSwitch(index : Int) -> Int {
        return 0
    }
    
}
