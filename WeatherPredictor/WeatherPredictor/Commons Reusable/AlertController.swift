//
//  AlertController.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation
import UIKit

struct AlertController {
    static func showAlertWith(fromVC vc: UIViewController, title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
            vc.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        vc.present(alertController, animated: true, completion: nil)
    }
}
