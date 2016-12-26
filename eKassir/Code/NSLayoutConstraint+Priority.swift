//
//  MainViewModel.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 18/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//


import UIKit

extension NSLayoutConstraint {
    func ek_adaptPriorityDepending(on object: AnyObject?) {
        //  http://stackoverflow.com/questions/31186187/how-can-i-change-constraints-priority-in-run-time
        self.priority = object != nil ? UILayoutPriorityDefaultLow : 999
    }
}
