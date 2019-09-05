//
//  CategoryViewController.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import RxSwift

class CategoryViewController: UIViewController {

    /// The controller's view, instance of CategoryView
    private unowned var _view:CategoryView { return self.view as! CategoryView }
    
    // MARK: - Constants
    private let disposeBag = DisposeBag()
    private let viewModel  = CategoryViewModel()
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = CategoryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDisplayObservers()
        setupTableViewObservers()
        
        reloadTableView()
    }
    
    // MARK: - Setup
    /// Initial setup for the ViewController
    private func setupView(){
        self.title = viewModel.title
        viewModel.setup(RequestService())
        _view.refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    /// Sets up the observers for feedback
    private func setupDisplayObservers(){
        viewModel.errorMessage.asObservable().subscribe(onNext: { [weak self] (message) in
            self?._view.errorMessage.text = message
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().subscribe(onNext: { [weak self] (isLoading) in
            if isLoading {
                self?._view.refreshControl.beginRefreshing()
            }
            else{
                self?._view.refreshControl.endRefreshing()
            }
        }).disposed(by: disposeBag)
    }
    
    /// Sets up the observers for the UITableView
    private func setupTableViewObservers() {
        viewModel.categories.bind(to: _view.tableview.rx.items(cellIdentifier: CategoryCell.identifier, cellType: CategoryCell.self)) { row, category, cell in
            cell.setupCell(with: category)
            }.disposed(by: disposeBag)
        
        _view.tableview.rx.modelSelected(String.self).subscribe(onNext: { [unowned self] category in
            let detailController = CategoryDetailViewController(category)
            self.navigationController?.pushViewController(detailController, animated: true)
        }).disposed(by: disposeBag)
    }
}

// MARK: - View's actions
extension CategoryViewController{
    
    /// Action to reload the tableView data
    @objc private func reloadTableView(){
        viewModel.requestCategories()
    }
}
