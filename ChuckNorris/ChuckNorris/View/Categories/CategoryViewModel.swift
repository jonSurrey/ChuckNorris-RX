//
//  CategoryViewModel.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import RxCocoa
import Foundation

class CategoryViewModel{
    
    // MARK: - Observables
    let hasError:     BehaviorRelay<Bool>     = BehaviorRelay(value: false)
    let isLoading:    BehaviorRelay<Bool>     = BehaviorRelay(value: false)
    let categories:   BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let errorMessage: BehaviorRelay<String?>  = BehaviorRelay(value: nil)
    
    // MARK: - Constants
    let title = "Categories"
    
    // MARK: - Variables
    /// The service responsible for the requests
    private var service:RequestService!{
        didSet{
            service.delegate = self
        }
    }
    
    // MARK: - Init
    func setup(_ service:RequestService){
        self.service = service
    }
}

// MARK: - General Functions
extension CategoryViewModel{
    
    /// Performs the request to the list of categories
    func requestCategories(){
        isLoading.accept(true)
        service.getCategoriesList()
    }
}

// MARK: - RequestServiceDelegate
extension CategoryViewModel:RequestServiceDelegate{
    
    func onCategoriesReceived(_ categories: [String]) {
        self.hasError    .accept(false)
        self.isLoading   .accept(false)
        self.categories  .accept(categories)
        self.errorMessage.accept(categories.isEmpty ? "No categories were found. Try reloading the page.":nil)
    }
    
    func onFailure(_ error: Error?) {
        self.categories  .accept([])
        self.isLoading   .accept(false)
        self.hasError    .accept(true)
        self.errorMessage.accept("There was an error loading the categories. Please, try again.")
    }
}
