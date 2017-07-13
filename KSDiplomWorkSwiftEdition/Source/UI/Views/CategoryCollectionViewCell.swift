//
//  CategoryCollectionViewCell.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 5/26/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    

    func fillCellWith(category:Category) {
        let image = UIImage.init(named: category.imageName!)
        categoryImageView.image = image
        categoryTitleLabel.text = category.title
    }
}
