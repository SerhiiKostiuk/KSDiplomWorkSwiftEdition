//
//  UIColor+RGB.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/25/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0) {
        self.init(
            red:CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green:CGFloat((value & 0xFF0000) >> 8) / 255.0,
            blue:CGFloat((value & 0xFF0000) >> 16) / 255.0,
            alpha:alpha
        )
    }
    
}
