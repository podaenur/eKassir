//
//  MainViewController.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 16/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    
    var viewModel: MainViewModel!
    var emptyView: EmptyView?
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            viewModel.registerCells(for: tableView)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 120
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
        viewModel.fetchData()
    }
    
    private func setupUI() {
        navigationItem.title = NSLocalizedString("MainViewController.title", comment: "")
        
        emptyView = Bundle.main.loadNibNamed(String(describing: EmptyView.self), owner: nil, options: nil)?.first as? EmptyView
        emptyView!.frame =  view.bounds
        emptyView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        emptyView!.isHidden = true
        emptyView!.configure(with: EmptyModel.defaultModel() as AnyObject)
        view.addSubview(emptyView!)
    }
    
    private func bindUI() {
        viewModel.dataDidUpdate = { [unowned self] in
            DispatchQueue.main.async {
                self.showEmptyInfoIfNeeded()
                guard let tableView = self.tableView else { return }
                tableView.reloadData()
            }
        }
        viewModel.dataDidFailUpdate = { [unowned self] (error) in
            self.showEmptyInfoIfNeeded()
        }
    }
    
    //MARK: - Private
    
    private func showEmptyInfoIfNeeded() {
        if viewModel.models.count == 0 {
            tableView.isHidden = true
            emptyView?.isHidden = false
        } else {
            tableView.isHidden = false
            emptyView?.isHidden = true
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        if cell is Configurable {
            let cellModel = viewModel.cellModel(at: indexPath)
            guard let _cellModel = cellModel else { return cell }
            
            (cell as! Configurable).configure(with: _cellModel as AnyObject)
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.openDetailsScreen(at: indexPath) { [unowned self] (controller) in
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
