//
//  CacheManagement.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 22/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

protocol CacheManagement {
    func put(_ object: AnyObject, byIdentifier identifier: String)
    func fetch(by identifier: String) -> AnyObject?
}
