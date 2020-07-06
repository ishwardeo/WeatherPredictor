//
//  UserLocationViewController.swift
//  WeatherPredictor
//
//  Created by Mac on 06/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation
import MapKit

class UserLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    
    let currentLocationWeatherModel = CurrentLocationWeatherModel()
    
    @IBAction func forecastForNextFiveDays(_ sender: Any) {
        currentLocationWeatherModel.getFiveDaysWeather(cityName: LatestCurrentLocation.city)
    }
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClosures()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        activityIndicatorView.startAnimating()
        self.view.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        
        saveLatestUserLocation(location: lastLocation)
        
        animateMap(lastLocation)
    }
    
    func animateMap(_ location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func saveLatestUserLocation(location: CLLocation?) {
        guard let tempLoc = location else {
            return
        }
        
        LatestCurrentLocation.latitude = tempLoc.coordinate.latitude
        LatestCurrentLocation.longitude = tempLoc.coordinate.longitude
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(tempLoc) { placemarks, _ in
            if let place = placemarks?.first {
                let city = place.subAdministrativeArea
//                print("city \(city)")
                LatestCurrentLocation.city = city
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
        //self.view.isUserInteractionEnabled = true

        self.activityIndicatorView.stopAnimating()
    }
    
    private func setupClosures() {
        currentLocationWeatherModel.reloadListClosure = {
            DispatchQueue.main.async {
                    if let forecastTableVC = ViewManager.getVCObjFor(storyboardID: String(describing: ForecastTableVC.self)) as? ForecastTableVC {
                    forecastTableVC.fiveDaysWeather = self.currentLocationWeatherModel.fiveDaysWeather
                    self.navigationController?.pushViewController(forecastTableVC, animated: true)
                }
            }
        }
        currentLocationWeatherModel.showErrorMessageClosure = { (message) in
        }
    }
}

extension UserLocationViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        locationManager.startUpdatingLocation()
        saveLatestUserLocation(location: mapView.userLocation.location)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            locationManager.startUpdatingLocation()
        saveLatestUserLocation(location: mapView.userLocation.location)
    }
}
