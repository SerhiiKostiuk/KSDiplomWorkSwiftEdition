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
    
}
