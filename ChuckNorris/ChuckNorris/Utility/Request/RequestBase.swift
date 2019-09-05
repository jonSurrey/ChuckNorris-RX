//
//  RequestBase.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import Alamofire
import Foundation

// Class responsible for all the requests performed inside the app
class RequestBase {
    
    /// Controls the session configuration
    private static let session: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        return SessionManager(configuration: configuration)
    }()
    
    /// Returns the Base URL
    private var baseURL:String {
        get{
            guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                fatalError("BASE_URL not set in info.plist")
            }
            return url
        }
    }
    
    init() {

    }
    
    func get(endpoint:Endpoint, _ parameters: Parameters?=nil) -> DataRequest {
        printAccess(to: endpoint, parameters)
        return RequestBase.session.request("\(baseURL)\(endpoint.value)", method: .get, parameters: parameters, headers:nil)
    }
    
    // Request logs
    private func printAccess(to endpoint:Endpoint, _ parameters: Parameters?){
        let param: Any = parameters ?? "--"
        print("\n ======== URL SENDO ACESSADA ======== \n\n - URL:\n \(baseURL)\(endpoint.value) \n\n - PARAMETROS:\n \(param)\n ==================================== \n")
    }
}
