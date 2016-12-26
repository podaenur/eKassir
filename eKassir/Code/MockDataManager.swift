//
//  MockDataManager.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 21/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

class MockDataManager: DataManager {
    override var gateway: GatewayManagement {
        return APIMocksGateway()
    }
}
