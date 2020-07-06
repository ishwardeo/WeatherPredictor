//
//  DetailViewController.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var sharedDetailViewModel = DetailViewModel.sharedDetailModel
    
    var detailItem: String?
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        minTempLabel.text = sharedDetailViewModel.minTempLabelText
        maxTempLabel.text = sharedDetailViewModel.maxTempLabelText
        windSpeedLabel.text = sharedDetailViewModel.windSpeedLabelText
        weatherDescLabel.text = sharedDetailViewModel.weatherDescriptionLabelText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    @IBAction func showMapOfCurrentLocation(_ sender: Any) {
        ViewManager.pushVCWithStoryboardID(StoryboardID: String(describing: UserLocationViewController.self), fromNavController: self.navigationController, animationAllowed: true)
    }
}
