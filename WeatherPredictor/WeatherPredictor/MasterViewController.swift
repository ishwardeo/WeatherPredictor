//
//  MasterViewController.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    ///view model object
    var viewModel = MasterViewModel()

    var detailViewController: DetailViewController? = nil
    var cities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupClosures()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    private func setupClosures() {
        viewModel.reloadListClosure = {
            DispatchQueue.main.async {
                let cityWeather = self.viewModel.cityWeather
                if let controller = ViewManager.getVCObjFor(storyboardID: String(describing: DetailViewController.self)) as? DetailViewController {
                    
                    var minTemp: Double?
                    var maxTemp: Double?
                    var weatherDesc: String?
                    var windSpeed: Double?

                    if let cityWeather = cityWeather {
                        var sharedModel = DetailViewModel.sharedDetailModel
                        if let weatherArray = cityWeather.weather {
                            if weatherArray.count > 0 {
                                weatherDesc = weatherArray[0].description
                            }
                        }
                        minTemp = cityWeather.main?.temp_min
                        maxTemp = cityWeather.main?.temp_max
                        windSpeed = cityWeather.wind?.speed
                        sharedModel.updateDetailModel(minTemp: minTemp, maxTemp: maxTemp, description: weatherDesc, windSpeed: windSpeed)
                        
                        controller.sharedDetailViewModel = sharedModel
                    }
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
        }
        viewModel.showErrorMessageClosure = { (message) in
        }
    }
    

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let city = cities[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel!.text = city
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        viewModel.fetchWeatherDetailsFor(cityName: city)
    }
}

