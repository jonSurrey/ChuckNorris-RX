//
//  UIImageView+Utils.swift
//  ChuckNorris
//
//  Created by Jonathan Martins on 04/09/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

extension UIImageView{
    
    /// Loads a given image url to the UImageView
    func load(_ url:String?){
        guard let string = url, let link = URL(string: string) else {
            return
        }
        self.af_setImage(withURL: link)
    }
}
