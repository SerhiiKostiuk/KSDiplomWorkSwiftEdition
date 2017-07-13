//
//  NumPadCollectionViewCell.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 6/1/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

class NumPadCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberButton: UIButton!
    
    var buttonTapped: ((UIButton) -> Void)?
    
    @IBAction func _buttonTapped(_ button: UIButton) {
        buttonTapped?(button)
    }
}
