//
//  TextViewController.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textViewToAcceptCityNames: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreenLayout()
        addTapGestureToCloseKeyboardWhenTappedOutside()
    }
    
    private func configureScreenLayout() {
        textViewToAcceptCityNames.layer.borderColor = UIColor.black.cgColor
        textViewToAcceptCityNames.layer.borderWidth = 1.0
    }
    
    private func addTapGestureToCloseKeyboardWhenTappedOutside() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction private func fetchWeatherDetails(_ sender: Any) {
        if let cities = getCitiesList(citiesSepByComma: textViewToAcceptCityNames.text) {
            if cities.count < 3 {
                AlertController.showAlertWith(fromVC: self, title: "Input Error", message: "Please enter minimum 3 cities separated by comma", style: .alert)
            } else if cities.count > 7 {
                AlertController.showAlertWith(fromVC: self, title: "Input Error", message: "Please enter maximum 7 cities separated by comma", style: .alert)
            } else {
                if let masterVC = ViewManager.getVCObjFor(storyboardID: String(describing: MasterViewController.self)) as? MasterViewController {
                    masterVC.cities = cities
                    self.navigationController?.pushViewController(masterVC, animated: true)
                }
            }
        } else {
            AlertController.showAlertWith(fromVC: self, title: "Input Error", message: "Please enter minimum 3 cities separated by comma", style: .alert)
        }
    }
    
    private func getCitiesList(citiesSepByComma cities: String?) -> Array<String>? {
        guard let unwrappedCities = cities else {
            return nil
        }
        
        if unwrappedCities.isEmpty {
            return nil
        }
        
        let citiesArray: Array<String> = unwrappedCities.components(separatedBy: ",")
        
        // Handle duplicacy
        let setOfCitites = Set(arrayLiteral: citiesArray)
        let distinctCitiesArray = Array(setOfCitites)
        
        return citiesArray
    }
}
