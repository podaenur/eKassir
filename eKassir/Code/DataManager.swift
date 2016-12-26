//
//  DataManager.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class DataManager: DataManagement {
    
    private(set) var gateway: GatewayManagement = APIGateway()
    private let mapper = Mapper()
    var cacher: CacheManagement?
    
    //MARK: - Public
    
    init() {
        cacher = ImageCacheManager()
        (cacher as! ImageCacheManager).activate()
    }
    
    func fetchOrders(completion: @escaping (FetchingResult) -> Void) {
        gateway.fetchData { [unowned self] (data, response, error) in
            guard error == nil else {
                completion(.failure(error))
                return
            }
            
            guard let _data = data else {
                let result = [OrderEntity]() as AnyObject?
                completion(.success(result))
                return
            }
            
            let result = self.mapper.parse(jsonData: _data) as AnyObject?
            completion(.success(result))
        }
    }
    
    func fetchCarImage(name: String, completion: @escaping (FetchingResult) -> Void) {
        gateway.fetchCarIcon(name: name) { [weak self] (data, response, error) in
            guard let sSelf = self else { return }
            
            let cachedImage = sSelf.cacher?.fetch(by: name)
            guard cachedImage == nil else {
                completion(.success(cachedImage))
                return
            }
            
            guard error == nil else {
                completion(.failure(error))
                return
            }
            
            guard let imageData = data else {
                let userInfo = [NSLocalizedDescriptionKey: "Картинка не загружена"]
                completion(.failure(NSError(domain: "Application.DataManager", code: 0, userInfo: userInfo) as Error))
                return
            }
            let fetchedImage = UIImage(data: imageData)
            
            if let _fetchedImage = fetchedImage {
                self?.cacher?.put(_fetchedImage, byIdentifier: name)
            }
            
            completion(.success(fetchedImage))
        }
    }
}
