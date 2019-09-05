//
//  Endpoint.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import Foundation

/// Wraps the acceptable endpoints fo the requests
enum Endpoint:String{
    
    case random     = "random"
    case categories = "categories"
    
    var value:String{
        get{
            return self.rawValue
        }
    }
}
