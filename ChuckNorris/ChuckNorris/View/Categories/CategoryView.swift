//
//  CategoryView.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import Foundation

class CategoryView:UIView{
    
    // MARK: - SubViews
    /// The list of the lines' status
    lazy var tableview:UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView()
        tableview.refreshControl = refreshControl
        tableview.registerCell(CategoryCell.self)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    /// Indicates if the UITableView is refreshed
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .appColor(.mainColour)
        return refreshControl
    }()
    
    /// The error message to be displayed if the UITableView does not load the content
    let errorMessage:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init's
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension CategoryView{
    
    /// Adds the subviews to the parent
    private func addViews(){
        self.addSubview(tableview)
        self.addSubview(errorMessage)
        self.backgroundColor = .white
    }
    
    /// Sets up the subviews' constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            errorMessage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            errorMessage.bottomAnchor .constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            errorMessage.widthAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 1/1.3),

            tableview.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableview.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableview.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
