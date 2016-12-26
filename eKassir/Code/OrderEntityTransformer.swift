//
//  OrderEntityTransformer.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class OrderEntityToMainCellModelTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return MainCellModel.self as! AnyClass
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard value is OrderEntity else { return nil }
        
        let entity = value as! OrderEntity
        
        return MainCellModel(startAddress: fullAddress(from: entity.startAddress),
                             destinationAddress: fullAddress(from: entity.endAddress),
                             dateRepresentation: DateConverter.shortDateString(from: entity.orderTime.ek_RFC3339Date()),
                             cost: formattedCost(from: entity.price))
    }
}

class OrderEntityToDetailsModelTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return DetailsModel.self as! AnyClass
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard value is OrderEntity else { return nil }
        
        let entity = value as! OrderEntity
        
        return DetailsModel(startAddress: fullAddress(from: entity.startAddress),
                            endAddress: fullAddress(from: entity.endAddress),
                            tripDateAndTime: DateConverter.fullTimeDateString(from: entity.orderTime.ek_RFC3339Date()),
                            tripCost: formattedCost(from: entity.price),
                            driverFullName: entity.vehicle.driverName,
                            carModelAndNumber: entity.vehicle.regNumber + " " + entity.vehicle.modelName,
                            carLogoImage: entity.vehicle.photo)
    }
}

fileprivate let priceFormatter = PriceFormatter()

fileprivate func fullAddress(from entity: AddressEntiry) -> String {
    return entity.city + " " + entity.address
}

fileprivate func formattedCost(from entity: PriceEntity) -> String {
    let amountString = priceFormatter.priceRepresentation(from: Double(entity.amount) / 100)
    return (amountString?.appending(" ").appending(entity.currency)) ?? ""
}
