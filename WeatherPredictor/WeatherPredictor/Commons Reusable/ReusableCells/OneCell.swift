//
//  OneCell.swift
//  WeatherPredictor
//
//  Created by Mac on 06/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import UIKit

class OneCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupLabels(date dateTxt : String? , minTemp minTempText : String?, maxTemp maxTempText : String?, windSpeed windSpeedText: String?, weatherDesc weatherDescText: String?) {
        dateLabel.text = dateTxt
        minTempLabel.text = "Avg Min Temp: " + (minTempText ?? "")
        maxTempLabel.text = "Avg Max Temp: " + (maxTempText ?? "")
        windSpeed.text = "Wind Speed: " + (windSpeedText ?? "")
        weatherLabel.text = "Possible Weathers: \n" + (weatherDescText ?? "")
    }
}
