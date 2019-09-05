//
//  CategoryCell.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import Foundation

class CategoryCell:UITableViewCell{
    
    static let identifier = "CategoryCell"
    
    // MARK: - SubViews
    /// The name of the category
    private let name:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellStyle()
        addCellSubViews()
        setupCellConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the cell with the given Category
    func setupCell(with category:String){
        name.text = category.firstUppercased
    }
}

// MARK: - Private Functions
extension CategoryCell{
    
    ///
    private func setupCellStyle(){
        selectionStyle = .none
        accessoryType  = .disclosureIndicator
    }
    
    ///
    private func addCellSubViews(){
        self.contentView.addSubview(name)
    }
    
    ///
    private func setupCellConstraints(){
        NSLayoutConstraint.activate([
            name.centerYAnchor .constraint(equalTo: self.contentView.centerYAnchor),
            name.topAnchor     .constraint(equalTo: self.contentView.topAnchor, constant: 20),
            name.bottomAnchor  .constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            name.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor , constant: 12),
            name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
        ])
    }
}
