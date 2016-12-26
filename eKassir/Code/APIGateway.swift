//
//  APIGateway.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

class APIGateway: GatewayManagement {
    
    private var session: URLSession!
    
    //MARK: - Life cycle
    
    init() {
        setupSession()
    }
    
    private func setupSession() {
        let gatewayQueue = OperationQueue()
        gatewayQueue.name = "com.zhurov.eKassir-taxi.gatewayQueue"
        gatewayQueue.qualityOfService = .background
        
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration,
                             delegate: nil,
                             delegateQueue: gatewayQueue)
    }
    
    //MARK: - GatewayManagement
    
    func fetchData(completion: @escaping APIGatewayCompletion) {
        let task = session.dataTask(with: APIRequestFactory.requestData(), completionHandler: completion)
        task.resume()
    }
    
    func fetchCarIcon(name: String, completion: @escaping APIGatewayCompletion) {
        let task = session.dataTask(with: APIRequestFactory.requestIcon(name: name), completionHandler: completion)
        task.resume()
    }
}
