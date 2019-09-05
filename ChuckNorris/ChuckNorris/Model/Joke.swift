//
//  Joke.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 03/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import Foundation

struct Joke:Codable {
    
    private let id:String?
    private let url:String?
    private let value:String?
    private let icon_url:String?
    private let categories:[String]?

    private enum CodingKeys: String, CodingKey {
        case id, url, value, icon_url, categories
    }
    
    /// The URL link to the jokes's page
    var urlPage:String{
        get{
            return url ?? ""
        }
    }
    
    /// The joke itself
    var quote:String{
        get{
            return value ?? ""
        }
    }
    
    /// The URL link to the icon
    var urlIcon:String{
        get{
            return icon_url ?? ""
        }
    }
    
    /// The catgeory that the joke belongs
    var category:String?{
        get{
            return categories?.first
        }
    }
    
    init(value:String, categories:[String]){
        self.id         = "\(Int.random(in: 0...10000))"
        self.url        = ""
        self.value      = value
        self.icon_url   = ""
        self.categories = categories
    }
}
