//
//  MasterViewModel.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    /// closures for communication with View Controller
    var reloadListClosure = {() -> () in}
    var showErrorMessageClosure = {(message: String) -> () in}
        
    var cityWeather: CityWeather? {
        /// Reload list
        didSet {
            reloadListClosure()
        }
    }
    
    //MARK: - Core data Related methods
    
    ///get data from api
    func fetchWeatherDetailsFor(cityName cityFullName: String?)  {
        guard let unwrappedCityName = cityFullName else {
            return
        }
        
        // Remove white spaces
        let cityWithoutSpace = unwrappedCityName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        guard let listURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityWithoutSpace)&appid=89a0fab6c513ec54830fa1167ab2097e")else {
            return
        }
        URLSession.shared.dataTask(with: listURL) {
            (data,response,error) in
            guard let jsonData = data else { return }
            DispatchQueue.main.async {
                self.cityWeather = self.parseResponse(forData: jsonData)
            }
        }.resume()
    }
    
    ///parse response using decodable and store data
    func parseResponse(forData jsonData : Data) -> CityWeather?  {
        do {
            // Parse JSON data
            let parsedJSON: CityWeather? = try DataDecoder.sharedDataManager.decode(CityWeather.self, from: jsonData)
                print("******* parsedJSON  ******** \n\n", parsedJSON as Any)
            return parsedJSON
        } catch let error {
            print("Error ->\(error.localizedDescription)")
            self.showErrorMessageClosure(error.localizedDescription)
        }
        return nil
    }
}
