//
//  Mapper.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 20/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct Mapper {
    
    //MARK: - Public
    
    func parse(jsonData: Data) -> [OrderEntity]? {
        let json = convert(jsonData: jsonData)
        
        guard let entitySequence = json as? Array<Any> else { return nil }
        
        var buffer = [OrderEntity]()
        entitySequence.forEach { (element) in
            guard let _element = element as? Dictionary<String, Any>, let entity = parseOrder(from: _element) else { return }
            buffer.append(entity)
        }
        
        return buffer
    }
        
    //MARK: - Private
    
    private func convert(jsonData: Data) -> Any? {
        return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    }
    
    private func parseOrder(from element: Dictionary<String, Any>) -> OrderEntity? {
        guard let id = element["id"] as? Int,
            let startAddress = element["startAddress"] as? Dictionary<String, Any>,
            let endAddress = element["endAddress"] as? Dictionary<String, Any>,
            let price = element["price"] as? Dictionary<String, Any>,
            let orderTime = element["orderTime"] as? String,
            let vehicle = element["vehicle"] as? Dictionary<String, Any> else { return nil }
        
        guard let parsedStartAddress = parseAddress(from: startAddress),
            let parsedEndAddress = parseAddress(from: endAddress),
            let parsedPrice = parsePrice(from: price),
            let parsedVechicle = parseVechicle(from: vehicle) else { return nil }
        
        return OrderEntity(id: id,
                           startAddress: parsedStartAddress,
                           endAddress: parsedEndAddress,
                           price: parsedPrice,
                           orderTime: orderTime,
                           vehicle: parsedVechicle)
    }
    
    private func parseAddress(from element: Dictionary<String, Any>) -> AddressEntiry? {
        guard let city = element["city"] as? String, let address = element["address"] as? String else { return nil }
        return AddressEntiry(city: city, address: address)
    }
    
    private func parsePrice(from element: Dictionary<String, Any>) -> PriceEntity? {
        guard let amount = element["amount"] as? Int, let currency = element["currency"] as? String else { return nil }
        return PriceEntity(amount: amount, currency: currency)
    }
    
    private func parseVechicle(from element: Dictionary<String, Any>) -> VechicleEntity? {
        guard let regNumber = element["regNumber"] as? String,
            let modelName = element["modelName"] as? String,
            let photo = element["photo"] as? String?,
            let driverName = element["driverName"] as? String else { return nil }
        return VechicleEntity(regNumber: regNumber, modelName: modelName, photo: photo, driverName: driverName)
    }
}
