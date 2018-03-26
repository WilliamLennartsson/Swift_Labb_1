//
//  WeatherViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var cityList = [City]()
    var weatherHelper = WeatherHelper()
    let model = Model()
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        getWeather(cityName: "Halmstad")
        refresh()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        refresh()
    }
    
    func refresh(){
        cityList = model.cityList
        tableView.reloadData()
        print(cityList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    @IBOutlet weak var btnPressed: UIButton!

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        
        
        if cityList.count  > indexPath.row{
            let city = cityList[indexPath.row]
            print("\(city.name)")
            
            //cell.imgThumbNail.layer.cornerRadius = cell.imgThumbNail.frame.height / 2
            cell.imgThumbNail.image = UIImage(named: "sunset")
            cell.name.text = city.name
            cell.temperature.text = "\(city.temperature) ◦C"
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSeg" {
            let detailController = segue.destination as! DetailViewController
            if let cell = sender as? UITableViewCell{
                let indexOfCell : Int = tableView.indexPath(for: cell)!.row
                let cellCity = self.cityList[indexOfCell]
                detailController.city = cellCity
                detailController.dWeatherHelper = weatherHelper
            }
            
        }
    }
    func updateUI(){
        self.cityList = model.cityList
    }
}

extension WeatherViewController {
    
    func getWeather(cityName: String){
        
        
        let session = URLSession.shared
        let weatherRequestURL = NSURL(string: "\(model.searchBaseURL)?APPID=\(model.API_KEY)&q=\(cityName)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                //Error
                print("Error:\n\(error)")
            } else {
                do {
                    //Det gick bra men inte så fort
                    let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    let city = City()
                    city.name = weather["name"]! as! String
                    city.temperature = (weather["main"]!["temp"]!! as! Float)  - Float(self.model.aboluteZero)
                    city.temp_max = (weather["main"]!["temp_max"] as! Float)
                    city.temp_min = (weather["main"]!["temp_min"] as! Float)
                    self.model.addCity(city: city)
                    self.updateUI()
                    print("City -> \n \(city.name) , \(city.temperature)")
                    print("City\(weather["name"]!)")
                    print("Temp -> \n \(weather["main"]!["temp"]!!)")
                    print("Humidity -> \n \(weather["main"]!["humidity"]!!)")
                    
//                    DispatchQueue.main.async {
//                        cell.degreeLabel.text = String(weatherResponse.main.temp - 273.15)
//                    }
                    
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
    func loadCities (){
        let list = ["Gothenburg", "Varberg", "Bangkok", "London"]
        for i in list {
            getWeather(cityName: i)
        }
    }
}


