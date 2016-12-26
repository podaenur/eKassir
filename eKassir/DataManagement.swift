//
//  DataManagement.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 22/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

enum FetchingResult {
    case success(AnyObject?)
    case failure(Error?)
}

protocol DataManagement {
    func fetchOrders(completion: @escaping (FetchingResult) -> Void)
    func fetchCarImage(name: String, completion: @escaping (FetchingResult) -> Void)
}
