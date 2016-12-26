//
//  GatewayManagement.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

typealias APIGatewayCompletion = (Data?, URLResponse?, Error?) -> Void

protocol GatewayManagement {
    func fetchData(completion: @escaping APIGatewayCompletion)
    func fetchCarIcon(name: String, completion: @escaping APIGatewayCompletion)
}
