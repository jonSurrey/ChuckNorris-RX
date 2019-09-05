//
//  RequestService.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestServiceDelegate:class{
    
    /// Notifies when the list of categories is available
    func onCategoriesReceived(_ categories:[String])
    
    /// Notifies when the joke is available
    func onJokeReceived(_ joke:Joke)
    
    /// Notifies when no result is available
    func onFailure(_ error:Error?)
}

/// Default implementation so the functions become optional
extension RequestServiceDelegate{
    
    func onCategoriesReceived(_ categories:[String]){ }
    
    func onJokeReceived(_ joke:Joke){ }
}

class RequestService: RequestBase {

    weak var delegate:RequestServiceDelegate?
    
    /// Requests the list of categories
    func getCategoriesList(){
        get(endpoint: .categories).responseJSON { [weak self] (response) in
            if let result = self?.parseData(response.data, to: [String].self) {
                self?.delegate?.onCategoriesReceived(result)
            }
            else{
                self?.delegate?.onFailure(response.error)
            }
        }
    }
    
    /// Requests a random joke for a given or not given category
    func getRandomJoke(for category:String?=nil){
        var parameters:Parameters? = nil
        if let category = category{
            parameters = Parameters()
            parameters?["category"] = category
        }
        get(endpoint: .random, parameters).responseJSON { [weak self] (response) in
            if let result = self?.parseData(response.data, to: Joke.self) {
                self?.delegate?.onJokeReceived(result)
            }
            else{
                self?.delegate?.onFailure(response.error)
            }
        }
    }
    
    /// Parses a given data to the given Class type
    private func parseData<T:Decodable>(_ data:Data?, to type:T.Type)->T?{
        if let data = data{
            if let result = try? JSONDecoder().decode(type, from: data){
                return result
            }
        }
        return nil
    }
}
