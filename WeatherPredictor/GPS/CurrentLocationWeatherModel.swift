//
//  CurrentLocationWeatherModel.swift
//  WeatherPredictor
//
//  Created by Mac on 06/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

class CurrentLocationWeatherModel {
    
    /// closures for communication with View Controller
    var reloadListClosure = {() -> () in}
    var showErrorMessageClosure = {(message: String) -> () in}
        
    var fiveDaysWeather: Array<DayWeatherModel>? {
        /// Reload list
        didSet {
            reloadListClosure()
        }
    }
    
    //MARK: - Core data Related methods
    
    ///get data from api
    func getFiveDaysWeather(cityName cityFullName: String?)  {
        guard let unwrappedCityName = cityFullName else {
            return
        }
        
        // Remove white spaces
        let cityWithoutSpace = unwrappedCityName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        guard let listURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityWithoutSpace)&appid=89a0fab6c513ec54830fa1167ab2097e")else {
            return
        }

        URLSession.shared.dataTask(with: listURL) {
            (data,response,error) in
            guard let jsonData = data else { return }
            DispatchQueue.main.async {
                _ = self.parseResponse(forData: jsonData)
            }
        }.resume()
    }
    
    ///parse response using decodable and store data
    func parseResponse(forData jsonData : Data) -> ForecastModel?  {
        do {
            // Parse JSON data
            let customModel: ForecastModel? = try DataDecoder.sharedDataManager.decode(ForecastModel.self, from: jsonData)
            print("******* customModel  ******** \n\n", customModel as Any)
            
            groupListByDate(model: customModel)
            
            return customModel
        } catch let error {
            print("Error ->\(error.localizedDescription)")
            self.showErrorMessageClosure(error.localizedDescription)
        }
        return nil
    }
    
    private func groupListByDate(model: ForecastModel?) {
        guard let tempModel = model else {
            return
        }
        if let list = tempModel.list {
            // Step 1 - Transform the list by keeping only date and remvoing hh,mm, ss
            let tempArray = list.map({(obj: List1) -> List1 in
                var tempObj = obj
                if let dateString = obj.dt_txt {
                    if dateString.count >= 10 {
                        let prefix = dateString.prefix(10)
                        tempObj.dt_txt = String(prefix)
                    }
                }
                return tempObj
            })
            
            // Step2 - Group the list by date
            let datewiseGrouped = Dictionary(grouping: tempArray, by: {$0.dt_txt})
            print("datewiseGrouped: \(datewiseGrouped)")
            
            // Form datasource for 5 day forecast
            prepareModelForForeCastVC(dict: datewiseGrouped as? Dictionary<String, [List1]>)
        }
    }
    
    private func prepareModelForForeCastVC(dict: Dictionary<String, [List1]>?) {
        guard let tempDict = dict else {
            fiveDaysWeather = nil
            return
        }
        
        var arrayOfWeatherCasts = Array<DayWeatherModel>()
        
        for (dateAsKey, oneDaterray) in tempDict {
            var oneModel = DayWeatherModel()
            oneModel.dateText = dateAsKey
            
            var min = 0.0
            var max = 0.0
            var weatherDesc = ""
            var speed = 0.0
            for list in oneDaterray {
                let tempList = list
                    
                // Process main
                let main = tempList.main
                if let tempMin = main?.temp_min {
                    min += tempMin
                }
                
                if let tempMax = main?.temp_max {
                    max += tempMax
                }
                
                // Process weather
                if let weather = tempList.weather {
                    if weather.count > 0 {
                        let oneWeather = weather[0]
                        if let desc = oneWeather.description {
                            weatherDesc  = weatherDesc + ", " + desc
                        }
                    }
                }
                
                // Process wind
                if let wind = tempList.wind {
                    if let tempSpeed = wind.speed {
                        speed += tempSpeed
                    }
                }
            }
            let count = oneDaterray.count
            if count > 0 {
                oneModel.avgMaxTemp = String(max/Double(count))
                max = 0.0
                
                oneModel.avgMinTemp = String(min/Double(count))
                min = 0.0

                oneModel.consolidatedWeatherDesc = weatherDesc
                weatherDesc = ""
                
                oneModel.avgWindSpeed = String(speed/Double(count))
            }
            
            arrayOfWeatherCasts.append(oneModel)
        }
        fiveDaysWeather = arrayOfWeatherCasts
    }
}
