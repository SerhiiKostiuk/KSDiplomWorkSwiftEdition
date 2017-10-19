//
//  String+Currency.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 7/25/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import Foundation

extension String {
    
    func currency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let digits = NSDecimalNumber(string: sanitized())
        let place = NSDecimalNumber(value: powf(10, 2))
        return formatter.string(from: digits.dividing(by: place))
    }
    
    func sanitized() -> String {
        return String(self.characters.filter { "01234567890".characters.contains($0) })
    }
    
}
