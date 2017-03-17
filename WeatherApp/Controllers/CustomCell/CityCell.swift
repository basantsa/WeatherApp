//
//  CityCell.swift
//  WeatherApp
//
//  Created by Basant Sarda on 18/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var latLabel:UILabel!
    @IBOutlet weak var longLabel:UILabel!

    var bookmarkedCity:BookMarkedCity!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designCell() {
        self.cityName.text = bookmarkedCity.cityName!
        self.latLabel.text = "lat: " + bookmarkedCity.latitude!
        self.longLabel.text = "long: " + bookmarkedCity.longitude!
    }

}
