//
//  AppDelegate.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 16/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        NavigationManager.sharedManager.openRootController()
        
        return true
    }
}
