//
//  PriceFormatter.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 18/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct PriceFormatter {
    private var formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 9
    }
    
    //MARK: - Public
    
    func priceRepresentation(from number: Double) -> String? {
        return formatter.string(from: number as NSNumber)
    }    
}

