//
//  CategoryDetailViewModel.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 04/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import RxCocoa
import Foundation

class CategoryDetailViewModel{
    
    // MARK: - Variable
    /// The Controller's title
    var title:String?{
        get{
            return category.firstUppercased
        }
    }
    
    /// The URL to the joke
    var jokeLink:URL?{
        guard let string = joke.value?.urlPage, let url = URL(string: string) else {
            return nil
        }
        return url
    }
    
    /// The service responsible for the requests
    private var service:RequestService!{
        didSet{
            service.delegate = self
        }
    }
    
    /// The selected category
    private var category:String!
    
    // MARK: - Observables
    let joke:BehaviorRelay<Joke?> = BehaviorRelay(value: nil)
    let feedbackMessage:BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    // MARK: - Setup
    func setup(_ category:String, service:RequestService){
        self.service  = service
        self.category = category
    }
}

// MARK: - General Functions
extension CategoryDetailViewModel{
    
    /// Performs the request to the get a joke
    func requestJoke(){
        feedbackMessage.accept("Loading joke...")
        service.getRandomJoke(for: category)
    }
}

// MARK: - RequestServiceDelegate
extension CategoryDetailViewModel:RequestServiceDelegate{

    func onJokeReceived(_ joke: Joke) {
        self.joke.accept(joke)
        self.feedbackMessage.accept(nil)
    }
    
    func onFailure(_ error: Error?) {
        feedbackMessage.accept("There was an error loading the joke. Please, try again.")
    }
}
