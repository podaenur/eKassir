//
//  EmptyView.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 18/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

struct EmptyModel {
    let text: String?
    let icon: UIImage?
    
    static var defaultModel = {
        return EmptyModel(text: NSLocalizedString("EmptyModel.default.text", comment: ""),
                          icon: #imageLiteral(resourceName: "ic_no_data"))
    }
}

class EmptyView: UIView, Configurable {
    
    //MARK: - Outlets
    
    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var noDataTextLabel: UILabel! {
        didSet {
            noDataTextLabel.text = nil
            noDataTextLabel.font = UIFont.ek_main
            noDataTextLabel.textColor = UIColor.ek_mainGray
        }
    }
    @IBOutlet weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textTopConstraint: NSLayoutConstraint!
    
    //MARK: - Configurable
    
    func configure(with model: AnyObject) {
        let _model = model as! EmptyModel
        
        noDataImageView.image = _model.icon
        noDataTextLabel.text = _model.text
        
        imageBottomConstraint.ek_adaptPriorityDepending(on: noDataImageView.image as AnyObject?)
        textTopConstraint.ek_adaptPriorityDepending(on: noDataTextLabel.text as AnyObject?)
        
        layoutIfNeeded()
    }
}
