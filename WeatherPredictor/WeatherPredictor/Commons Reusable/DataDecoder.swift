
//
//  DataDecoder.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

struct DataDecoder {
    static let sharedDataManager = JSONDecoder()
    private init() {}
    
    func decode<CustomType: Codable>(apiData data: Data) throws -> CustomType? {
        let jsonDecoder = JSONDecoder.init()
        let cityWeather = try jsonDecoder.decode(CustomType.self, from: data)
        return cityWeather
    }
}

struct CityWeather: Codable {
    var coord: Coord?
   
    var weather: [OneWeather]?
    
    var base: String?
    
    var main: Main?
    
    var visibility: Int?
    
    var wind: Wind?
    
    var clouds: Clouds?
    
    var dt: Int?
    
    var sys: Sys?
    
    var name: String?
    var id: Int?
    var timezone: Int?
    var cod: Int?
}

struct Coord: Codable {
    var lat: Double?
    var lon: Double?
}

struct OneWeather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

//TODO: ("Change key names into camel case")
struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int
}

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}

struct Clouds: Codable {
    var all: Int?
}

struct Sys: Codable {
    var country: String?
    var id: Int?
    var sunrise: Int?
    var sunset: Int?
    var type: Int?
}
