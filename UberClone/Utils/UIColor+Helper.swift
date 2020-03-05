//
//  UIColor+Helper.swift
//  UberClone
//
//  Created by Pushpank Kumar on 11/02/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = rgb(red: 17, green: 154, blue: 237)
}
