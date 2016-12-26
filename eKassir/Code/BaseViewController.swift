//
//  BaseViewController.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 25/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var nibName: String? {
        let fullName = String(describing: type(of: self))
        if let charIndex = fullName.characters.index(of: "<") {
            let nameWithoutGeneric = fullName.substring(to: charIndex)
            return nameWithoutGeneric
        }
        return fullName
    }    
}
