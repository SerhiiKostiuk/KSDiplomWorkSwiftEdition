//
//  Functions.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/25/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import Foundation
import UIKit
//MARK: - display Alert VC
func presentAlertController(delegate: UIViewController, message: String) {
    let alert = UIAlertController (title: nil, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction (title: "Ok", style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    var displayAlert:() {
        delegate.present(alert, animated: true, completion: nil)
    }
    
    if !Thread.isMainThread {
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            displayAlert
        }
    } else {
        displayAlert
    }
}
