//
//  MainViewCell.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 17/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

struct MainCellModel {
    let startAddress: String
    let destinationAddress: String
    let dateRepresentation: String
    let cost: String?
}

class MainViewCell: UITableViewCell, Configurable {
    
    //MARK: - Outlets
    
    @IBOutlet weak var startPointLabel: UILabel! {
        didSet {
            startPointLabel.text = nil
            startPointLabel.textColor = UIColor.ek_mainBlack
            startPointLabel.font = UIFont.ek_address
        }
    }
    @IBOutlet weak var finishPointLabel: UILabel! {
        didSet {
            finishPointLabel.text = nil
            finishPointLabel.textColor = UIColor.ek_mainBlack
            finishPointLabel.font = UIFont.ek_address
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = nil
            priceLabel.textColor = UIColor.ek_mainBlack
            priceLabel.font = UIFont.ek_price
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = nil
            dateLabel.textColor = UIColor.ek_mainGray
            dateLabel.font = UIFont.ek_date
        }
    }
    @IBOutlet weak var routeImageView: UIImageView! {
        didSet {
            let resizeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 28, right: 0)
            routeImageView.image = #imageLiteral(resourceName: "ic_route").resizableImage(withCapInsets: resizeInsets, resizingMode: .stretch)
        }
    }
    
    //MARK: - Configurable
    
    func configure(with model: AnyObject) {
        let _model = model as! MainCellModel
        
        startPointLabel.text = _model.startAddress
        finishPointLabel.text = _model.destinationAddress
        priceLabel.text = _model.cost
        dateLabel.text = _model.dateRepresentation
    }
}
