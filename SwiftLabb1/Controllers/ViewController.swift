//
//  ViewController.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSeg" {
            let weatherController = segue.destination as! WeatherViewController
            weatherController.loadCities()
            
        } else {
            
        }
    }
}

