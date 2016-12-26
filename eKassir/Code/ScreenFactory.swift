//
//  ScreenFactory.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 16/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct ScreenFactory {
    
    private static var dataManager: DataManagement {
        return DataManager()
    }
    
    //MARK: - Public
    
    static func mainScreen() -> MainViewController {
        let controller = MainViewController()
        controller.viewModel = MainViewModel(dataManager: dataManager)
        return controller
    }
    
    static func detailsScreen(with viewModel: DetailsViewModel) -> DetailsViewController {
        let controller = DetailsViewController()
        controller.viewModel = viewModel
        return controller
    }
}
