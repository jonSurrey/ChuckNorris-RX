//
//  CategoryDetailView.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 04/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import Foundation

class CategoryDetailView:UIView{
    
    // MARK: - SubViews
    /// The icon of the joke
    let iconImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    /// The joke's text
    let jokeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The feedback to be displayed when no content is shown or loading the content
    let feedbackMessage:UILabel = {
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
extension CategoryDetailView{
    
    /// Adds the subviews to the parent
    private func addViews(){
        self.addSubview(iconImage)
        self.addSubview(jokeLabel)
        self.addSubview(feedbackMessage)
        self.backgroundColor = .white
    }
    
    /// Sets up the subviews' constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 38),
            iconImage.heightAnchor.constraint(equalToConstant: 38),
            iconImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            iconImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            jokeLabel.centerXAnchor .constraint(equalTo: iconImage.centerXAnchor),
            jokeLabel.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            jokeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            jokeLabel.topAnchor     .constraint(equalTo: iconImage.bottomAnchor, constant: 24),
            
            feedbackMessage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            feedbackMessage.bottomAnchor .constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            feedbackMessage.widthAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 1/1.3),
        ])
    }
    
    /// Constrols the visibility of the feedback
    func showFeedback(_ message:String?){
        feedbackMessage.text = message
        if message != nil{
            iconImage.isHidden = true
            jokeLabel.isHidden = true
        }
        else{
            iconImage.isHidden = false
            jokeLabel.isHidden = false
        }
    }
    
    /// Sets the joke's information on the views
    func displayJoke(_ joke:Joke?){
        jokeLabel.text = joke?.quote
        iconImage.load(joke?.urlIcon)
    }
}

