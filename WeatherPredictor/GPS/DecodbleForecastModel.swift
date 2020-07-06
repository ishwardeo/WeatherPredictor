//
//  DecodbleForecastModel.swift
//  WeatherPredictor
//
//  Created by Mac on 06/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

struct ForecastModel: Codable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    
    var list: [List1]?
    var city: City1?
}

struct List1: Codable {
    var dt: Int?
    var main: Main1?
    var weather: [OneWeather1]?
    var clouds: Clouds?
    var wind: Wind?
    var sys: Sys1?
    var dt_txt: String?
}

//TODO: ("Change key names into camel case")
struct Main1: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int
    
    var sea_level: Int?
    var grnd_level: Int?
    var temp_kf: Double?
}

struct OneWeather1: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Sys1: Codable {
    var pod: String?
}


struct City1: Codable {
    var name: String?
    var id: Int?
    var coord: Coord?

    var country: String?
    var population: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
}
