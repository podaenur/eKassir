//
//  Entities.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct OrderEntity {
    let id: Int
    let startAddress: AddressEntiry
    let endAddress: AddressEntiry
    let price: PriceEntity
    let orderTime: String
    let vehicle: VechicleEntity
}

struct AddressEntiry {
    let city: String
    let address: String
}

struct PriceEntity {
    let amount: Int
    let currency: String
}

struct VechicleEntity {
    let regNumber: String
    let modelName: String
    let photo: String?
    let driverName: String
}
