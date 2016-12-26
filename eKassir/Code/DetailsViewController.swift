//
//  DetailsViewController.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 16/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

struct DetailsModel {
    let startAddress: String
    let endAddress: String
    let tripDateAndTime: String
    let tripCost: String
    let driverFullName: String
    let carModelAndNumber: String
    let carLogoImage: String?
}

class DetailsViewController: BaseViewController {
    
    //MARK: - Outlets
    //  top container
    @IBOutlet weak var routeInfoLabel: UILabel!
    @IBOutlet weak var startAddressLabel: UILabel!
    @IBOutlet weak var endAddressLabel: UILabel!
    
    //  middle container
    @IBOutlet weak var tripInfoLabel: UILabel!
    @IBOutlet weak var willBeInfoLabel: UILabel!
    @IBOutlet weak var willBeValueLabel: UILabel!
    @IBOutlet weak var costInfoLabel: UILabel!
    @IBOutlet weak var costValueLabel: UILabel!
    
    //  bottom container
    @IBOutlet weak var driverInfoLabel: UILabel!
    @IBOutlet weak var driverValueLabel: UILabel!
    @IBOutlet weak var carInfoLabel: UILabel!
    @IBOutlet weak var carValueLabel: UILabel!
    @IBOutlet weak var carLogoImageView: UIImageView!
    
    //MARK: - Properties
    
    var viewModel: DetailsViewModel!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateCarIcon()
        fillUI()
    }
    
    func setupUI() {
        navigationItem.title = NSLocalizedString("DetailsViewController.title", comment: "")
        
        setupTopContainerUI()
        setupMiddleContainerUI()
        setupBottomContainerUI()
    }
    
    func bindUI() {
        viewModel.didUpdateImage = { [weak self] image in
            guard let sSelf = self else { return }
            DispatchQueue.main.async {
                sSelf.carLogoImageView.image = image
            }
        }
    }
    
    //MARK: - Private
    
    private func setupTopContainerUI() {
        routeInfoLabel.text = NSLocalizedString("DetailsViewController.route", comment: "")
        routeInfoLabel.font = UIFont.ek_main
        routeInfoLabel.textColor = UIColor.ek_mainBlack
        
        startAddressLabel.text = nil
        startAddressLabel.font = UIFont.ek_address
        startAddressLabel.textColor = UIColor.ek_mainBlack
        
        endAddressLabel.text = nil
        endAddressLabel.font = UIFont.ek_address
        endAddressLabel.textColor = UIColor.ek_mainBlack
    }
    
    private func setupMiddleContainerUI() {
        tripInfoLabel.text = NSLocalizedString("DetailsViewController.trip", comment: "")
        tripInfoLabel.font = UIFont.ek_main
        tripInfoLabel.textColor = UIColor.ek_mainBlack
        
        willBeInfoLabel.text = NSLocalizedString("DetailsViewController.begin", comment: "")
        willBeInfoLabel.font = UIFont.ek_main
        willBeInfoLabel.textColor = UIColor.ek_mainBlack
        
        willBeValueLabel.text = nil
        willBeValueLabel.font = UIFont.ek_main
        willBeValueLabel.textColor = UIColor.ek_mainBlack
        
        costInfoLabel.text = NSLocalizedString("DetailsViewController.cost", comment: "")
        costInfoLabel.font = UIFont.ek_main
        costInfoLabel.textColor = UIColor.ek_mainBlack
        
        costValueLabel.text = nil
        costValueLabel.font = UIFont.ek_price
        costValueLabel.textColor = UIColor.ek_mainBlack
    }
    
    private func setupBottomContainerUI() {
        driverInfoLabel.text = NSLocalizedString("DetailsViewController.driver", comment: "")
        driverInfoLabel.font = UIFont.ek_main
        driverInfoLabel.textColor = UIColor.ek_mainBlack
        
        driverValueLabel.text = nil
        driverValueLabel.font = UIFont.ek_main
        driverValueLabel.textColor = UIColor.ek_mainBlack
        
        carInfoLabel.text = NSLocalizedString("DetailsViewController.car", comment: "")
        carInfoLabel.font = UIFont.ek_main
        carInfoLabel.textColor = UIColor.ek_mainBlack
        
        carValueLabel.text = nil
        carValueLabel.font = UIFont.ek_main
        carValueLabel.textColor = UIColor.ek_mainBlack
        
        carLogoImageView.image = nil
    }
    
    private func fillUI() {
        let dataModel = viewModel.dataModel
        
        //  top container
        startAddressLabel.text = String.localizedStringWithFormat(NSLocalizedString("DetailsViewController.from", comment: ""), dataModel.startAddress)
        endAddressLabel.text = String.localizedStringWithFormat(NSLocalizedString("DetailsViewController.to", comment: ""), dataModel.endAddress)
        
        //  middle container
        willBeValueLabel.text = dataModel.tripDateAndTime
        costValueLabel.text = dataModel.tripCost
        
        //  bottom container
        driverValueLabel.text = dataModel.driverFullName
        carValueLabel.text = dataModel.carModelAndNumber
    }
}
