//
//  NavigationManager.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 16/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class NavigationManager {
    
    var window: UIWindow!
    
    static let sharedManager = NavigationManager()
    
    private init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
    
    func openRootController() {
        let controller = ScreenFactory.mainScreen()
        window.rootViewController = UINavigationController(rootViewController: controller)
    }
}
