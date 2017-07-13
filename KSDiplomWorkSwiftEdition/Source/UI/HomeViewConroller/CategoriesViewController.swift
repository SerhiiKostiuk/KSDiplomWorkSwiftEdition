//
//  CategoriesViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 5/19/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categories: [Category]!
    var numPadVC:NumPadViewController?
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getCategories), name: NSNotification.Name(rawValue: "categoriesPreload"), object: nil)
        
        numPadVC = NumPadViewController.create()
        
//        self.view.addSubview(self.numPadVC!.view)

        numPadVC?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func getCategories() {
        categories = CoreDataManager.getPreloadedCategories(type: .ExpenceCategory) as! [Category]
        categoriesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if categories == nil {
            return 0
        } else {
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.fillCellWith(category: categories[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        hideNumPadVC(hide: false)
        numPadVC?.categoryImageView.image = cell.categoryImageView.image
        numPadVC?.cagegoryTitleLabel.text = cell.categoryTitleLabel.text
    }
    
    func hideNumPadVC(hide: Bool) {
        if !hide {
            let frame = CGRect.init(x:view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            numPadVC?.view.frame = frame
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                let frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                self.numPadVC?.view.frame = frame
                
                self.view.addSubview(self.numPadVC!.view)
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                let frame = CGRect.init(x:self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                let numpadView = self.view.subviews[3]
                
                numpadView.frame = frame
            }, completion: nil)
        }
    }
}

extension CategoriesViewController:numPadDelegate {
    func numberTaped(button: UIButton) {
        print("button title \(String(describing: button.titleLabel?.text))")
    }
    
    func hideNumPad() {
        hideNumPadVC(hide: true)
    }
}

