//
//  DetailsViewModel.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 18/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class DetailsViewModel {
    
    var didUpdateImage: ((UIImage?) -> Void)?
    var dataManager: DataManagement
    var modelEntity: OrderEntity
    var dataModel: DetailsModel {
        return OrderEntityToDetailsModelTransformer().transformedValue(modelEntity) as! DetailsModel
    }
    
    //MARK: - Life cycle
    
    init(dataManager: DataManagement, modelEntity: OrderEntity) {
        self.dataManager = dataManager
        self.modelEntity = modelEntity
    }
    
    //MARK: - Public
    
    func updateCarIcon() {
        guard let imageName = modelEntity.vehicle.photo else { return }
        dataManager.fetchCarImage(name: imageName) { [unowned self] (result) in
            switch result {
            case let .success(image):
                self.didUpdateImage?(image as? UIImage)
            case .failure(_):
                break
            }
        }
    }
}
