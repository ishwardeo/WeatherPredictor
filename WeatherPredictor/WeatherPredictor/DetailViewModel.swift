//
//  DetailViewModel.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

fileprivate let minTempTitle = "Minimum Temperature: "
fileprivate let maxTempTitle = "Maximum Temperature: "
fileprivate let weatherDescriptionTitle = "Weather Description: "
fileprivate let windSpeedTitle = "Wind Speed: "

struct DetailViewModel {
    static var sharedDetailModel: DetailViewModel {
        return DetailViewModel()
    }
    
    private init() {}
    
    var minTempLabelText: String?
    var maxTempLabelText: String?
    var weatherDescriptionLabelText: String?
    var windSpeedLabelText: String?
    
    mutating func updateDetailModel(minTemp min: Double?, maxTemp max: Double?, description desc: String?, windSpeed speed: Double?) {
        let minimumTemp = min ?? 0
        let maxmumTemp = max ?? 0
        let weatherDesc = desc ?? ""
        let windSpeed = speed ?? 0
        
        minTempLabelText = minTempTitle + String(minimumTemp)
        maxTempLabelText = maxTempTitle + String(maxmumTemp)
        weatherDescriptionLabelText = weatherDescriptionTitle + weatherDesc
        windSpeedLabelText = windSpeedTitle + String(windSpeed)
    }
}
