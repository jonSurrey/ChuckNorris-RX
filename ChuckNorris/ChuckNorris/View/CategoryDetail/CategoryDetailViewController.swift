//
//  CategoryDetailViewController.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 04/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import RxSwift

class CategoryDetailViewController: UIViewController {
    
    /// The controller's view, instance of CategoryDetailView
    private unowned var _view:CategoryDetailView { return self.view as! CategoryDetailView }
    
    // MARK: - Constants
    private let disposeBag = DisposeBag()
    private let viewModel  = CategoryDetailViewModel()
    
    // MARK: - Custom Init
    convenience init(_ category:String) {
        self.init()
        viewModel.setup(category, service: RequestService())
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = CategoryDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDisplayObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestJoke()
    }
    
    // MARK: - Setup
    /// Initial setup for the ViewController
    private func setupView(){
        self.title = viewModel.title
        self._view.iconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openURL)))
    }
    
    /// Sets up the observers for the feedbacks
    private func setupDisplayObservers(){
        viewModel.feedbackMessage.asObservable().subscribe(onNext: { [weak self] (message) in
            self?._view.showFeedback(message)
        }).disposed(by: disposeBag)
        
        viewModel.joke.asObservable().subscribe(onNext: { [weak self] (joke) in
            self?._view.displayJoke(joke)
        }).disposed(by: disposeBag)
    }
}

// MARK: - General Functions
extension CategoryDetailViewController{
    
    /// Performs the request to fetch the joke's information
    private func requestJoke(){
        viewModel.requestJoke()
    }
}

// MARK: - View's actions
extension CategoryDetailViewController{

    /// Opens the joke's web page when clicked on the icon
    @objc private func openURL(){
        guard let url = viewModel.jokeLink else {
            return
        }
        UIApplication.shared.open(url)
    }
}
