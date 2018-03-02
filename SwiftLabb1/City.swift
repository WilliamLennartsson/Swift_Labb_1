//
//  City.swift
//  SwiftLabb1
//
//  Created by will on 2018-03-01.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class City: NSObject {
    var temperature : Int
    var name : String
    var infoText : String
    var temp_min = Float()
    var temp_max = Float()
    
    
    init ( temperature : Int, name : String, infoText : String) {
        self.temperature = temperature
        self.name = name
        self.infoText = infoText
    }
    
}
