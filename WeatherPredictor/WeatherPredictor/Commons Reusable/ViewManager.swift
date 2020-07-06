
//
//  ViewManager.swift
//  WeatherPredictor
//
//  Created by Mac on 05/07/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation
import UIKit

class ViewManager {
    static func pushVCWithStoryboardID(StoryboardID sbID: String?, fromNavController navController: UINavigationController?, animationAllowed animated: Bool?) {
        let animationAllowed = animated ?? true
        
        guard let tempSbID = sbID else {
            return
        }
        guard let tempNavController = navController else {
            return
        }

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: tempSbID)
        
        if tempNavController.responds(to: #selector(UINavigationController.popViewController(animated:))) {
            tempNavController.pushViewController(viewController, animated: animationAllowed)
        }
    }
    
    static func pushVCWithStoryboardIDAndErrorMessage(StoryboardID sbID: String?, fromNavController navController: UINavigationController?, animationAllowed animated: Bool?, errorMessage : String?) {
        
        let animationAllowed = animated ?? true
        
        guard let tempSbID = sbID else {
            return
        }
        guard let tempNavController = navController else {
            return
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: tempSbID)
        
        if tempNavController.responds(to: #selector(UINavigationController.popViewController(animated:))) {
            tempNavController.pushViewController(viewController, animated: animationAllowed)
        }
    }
    
    static func getVCObjFor(storyboardID: String) -> UIViewController? {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: storyboardID)
        return viewController
    }
        
    static func popToViewControllerWithStoryboardID(vcClassName vcClass: AnyClass?, fromNavController navController: UINavigationController?) {
        guard let tempNavController = navController else {
            return
        }
    
        guard let className = vcClass else {
            return
        }

        let viewControllers = tempNavController.viewControllers
        for viewController in viewControllers {
            if viewController.isKind(of: className.self) {
                viewController.navigationController?.popToViewController(viewController, animated: false)
            }
        }
    }
}
