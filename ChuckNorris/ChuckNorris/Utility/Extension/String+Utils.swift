//
//  String+Utils.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 04/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

extension String {
    
    /// Uppercases the first letter of the String
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
