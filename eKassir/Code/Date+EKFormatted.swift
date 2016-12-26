//
//  Date+EKFormatted.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 19/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct DateConverter {
    
    static private let formatter = DateFormatter()
    
    //MARK: - Public
    
    static func shortDateString(from date: Date) -> String {
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static func fullTimeDateString(from date: Date) -> String {
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }    
}
