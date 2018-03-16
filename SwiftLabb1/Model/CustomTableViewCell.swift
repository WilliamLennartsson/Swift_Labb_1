//
//  CustomTableViewCell.swift
//  SwiftLabb1
//
//  Created by will on 2018-02-28.
//  Copyright © 2018 will. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet  var name: UILabel!
    @IBOutlet weak var imgThumbNail: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
