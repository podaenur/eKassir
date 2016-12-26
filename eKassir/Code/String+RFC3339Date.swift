//
//  String+RFC3339Date.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 19/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

extension String {
    func ek_RFC3339Date() -> Date {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale.autoupdatingCurrent
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return RFC3339DateFormatter.date(from: self)!
    }
}
