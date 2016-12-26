//
//  APIMocksGateway.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 20/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class APIMocksGateway: GatewayManagement {
    
    //MARK: - GatewayManagement
    
    func fetchData(completion: @escaping APIGatewayCompletion) {
        let jsonPath = Bundle.main.path(forResource: "Mock", ofType: "json")
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath!)) else {
            completion(nil, nil, serverError())
            return
        }
        
        switch isGoodChance() {
        case true:
            completion(jsonData, nil, nil)
        case false:
            completion(nil, nil, notFoundError())
        }
    }
    
    func fetchCarIcon(name: String, completion: @escaping APIGatewayCompletion) {
        switch isGoodChance() {
        case true:
            let image = #imageLiteral(resourceName: "ic_mercedes_m-class_test")
            let representation = UIImagePNGRepresentation(image)
            completion(representation, nil, nil)
        case false:
            completion(nil, nil, notFoundError())
        }
    }
}

fileprivate func isGoodChance() -> Bool {
    return (arc4random_uniform(UInt32(1_000)) % 2) > 500
}

fileprivate func notFoundError() -> Error {
    let userInfo = [NSLocalizedDescriptionKey: "Не найдено"]
    return NSError(domain: "Application.APIMocksGateway", code: 404, userInfo: userInfo) as Error
}

fileprivate func serverError() -> Error {
    let userInfo = [NSLocalizedDescriptionKey: "Ошибка сервера"]
    return NSError(domain: "Application.APIMocksGateway", code: 500, userInfo: userInfo) as Error
}
