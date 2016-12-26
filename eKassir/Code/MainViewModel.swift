//
//  MainViewModel.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class MainViewModel {
    
    var dataManager: DataManagement!
    var dataDidUpdate: (() -> Void)?
    var dataDidFailUpdate: ((Error?) -> Void)?
    
    var cellIdentifier: String {
        return String(describing: MainViewCell.self)
    }
    private(set) var models: [OrderEntity]
    private let mainCellModelTransformer = OrderEntityToMainCellModelTransformer()
    
    //MARK: - Life cycle
    
    init(dataManager: DataManagement) {
        self.dataManager = dataManager
        self.models = []
    }
    
    //MARK: - Public
    
    func fetchData() {
        dataManager.fetchOrders { [unowned self] (fetchingResult) in
            switch fetchingResult {
            case let .success(result):
                self.models = self.sortByDateDescending(result as! [OrderEntity])
                self.dataDidUpdate?()
            case let .failure(error):
                self.dataDidFailUpdate?(error)
            }
        }
    }
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func cellModel(at indexPath: IndexPath) -> MainCellModel? {
        let entity = models[indexPath.row]
        let model = mainCellModelTransformer.transformedValue(entity)
        
        return model as! MainCellModel?
    }
    
    func openDetailsScreen(at indexPath: IndexPath, transition: (UIViewController) -> Void) {
        let detailsViewModel = DetailsViewModel(dataManager: dataManager, modelEntity: models[indexPath.row])
        let controller = ScreenFactory.detailsScreen(with: detailsViewModel)
        transition(controller)
    }
    
    //MARK: - Private
    
    private func sortByDateDescending(_ _models: [OrderEntity]) -> [OrderEntity] {
        return _models.sorted(by: { (left, right) -> Bool in
            return left.orderTime.ek_RFC3339Date() > right.orderTime.ek_RFC3339Date()
        })
    }
}
