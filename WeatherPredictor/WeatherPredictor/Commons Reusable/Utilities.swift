//
//  Utilities.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//
import Foundation

struct Utilities {
    static func customPrint(headingString heading: String?, anyValue value: Any?) {
        let finalHeading = heading ?? "Some Data"
        let finalValue = value ?? "nil"
        print("\n\n*********** \(finalHeading) ************\n \(finalValue)")
    }
}
