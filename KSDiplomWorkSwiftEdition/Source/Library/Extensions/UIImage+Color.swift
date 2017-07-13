//
//  UIImage+Color.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 6/1/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init(color: UIColor) {
        let size = CGSize(width: 1, height: 1)
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    
}
