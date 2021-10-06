//
//  AppsharedData.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 03/09/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import Foundation
import UIKit


class AppsharedData {
    
    
   static let sharedInstance = AppsharedData()
    
    func showAlertControllerWith(title : String, andMessage:String)  {
        let viewcontroller = self.getVisibleViewController(nil)
        let otherAlert = UIAlertController(title: title, message: andMessage, preferredStyle: UIAlertController.Style.alert)
        
        
        let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(dismiss)
        
        viewcontroller?.present(otherAlert, animated: true, completion: nil)
    }
    
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
    
}
