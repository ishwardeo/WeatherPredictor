//
//  ForecastTableVC.swift
//  WeatherPredictor
//
//  Created by Mac on 06/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import UIKit

class ForecastTableVC: UITableViewController {
    
    var fiveDaysWeather: Array<DayWeatherModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        registerCellXibs()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if let tempFiveDaysWeather = fiveDaysWeather, tempFiveDaysWeather.count > 0 {
            count = 1
        }
        return count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let tempFiveDaysWeather = fiveDaysWeather {
            count = tempFiveDaysWeather.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OneCell.self), for: indexPath) as? OneCell {
            if let tempFiveDaysWeather = fiveDaysWeather {
                let model = tempFiveDaysWeather[indexPath.row]
                cell.setupLabels(date: model.dateText, minTemp: model.avgMinTemp, maxTemp: model.avgMaxTemp, windSpeed: model.avgWindSpeed, weatherDesc: model.consolidatedWeatherDesc)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            return cell
        }
    }
    
    func registerCellXibs() {
        tableView.register(UINib.init(nibName: String(describing: OneCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OneCell.self))
       tableView.register(UINib.init(nibName: String(describing: UITableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}
