//
//  NumPadViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/28/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

protocol numPadDelegate: class {
    func addTransaction(transaction: Float)
    func hideNumPad()
}

class NumPadViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet weak var numPadCollectionView: UICollectionView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var cagegoryTitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!

    weak var delegate:numPadDelegate?
    
    // MARK: - Class Func
    
    class func create() -> NumPadViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! NumPadViewController
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: UIButton) {
        delegate?.hideNumPad()
    }
    
    @IBAction func AddValueAction(_ sender: Any) {
        let string = inputTextField.text?.replacingOccurrences(of: "$", with: "")
        
        if string == "0.00" || string == "" {
            return
        }

        self.delegate?.addTransaction(transaction:(string as NSString?)!.floatValue)
        
        self.inputTextField.text = ""
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NumPadCollectionViewCell.self), for: indexPath) as! NumPadCollectionViewCell
        
        let buttonTitle = String(format:"%d",indexPath.item+1)
        
        let image = UIImage(color: UIColor.lightGray)
        
        cell.numberButton.setBackgroundImage(image, for: .highlighted)
        
        switch indexPath.item {
        case 9:
            cell.numberButton.setTitle("00", for: UIControlState())
        case 10:
            cell.numberButton.setTitle("0", for: UIControlState())
        case 11:
            cell.numberButton.setTitle("X", for: UIControlState())
            
        default:
            cell.numberButton.setTitle(buttonTitle, for: UIControlState())
        }
        
        cell.buttonTapped = { [weak self] (button) in
            self?.numberTaped(button: button)
        }
        
        return cell
    }
    
    // TODO: - Add Length limit for input value
    
    // MARK: - numPadDelegate
    
    func numberTaped(button: UIButton) -> Void {
        let buttonTitle = button.titleLabel?.text

        if buttonTitle == "X" {
            if inputTextField.text?.characters.count != 0 {
                inputTextField.text = isDeleteButtonTaped(string: inputTextField.text!)
                return
            }
            return
        }
        
        let inputString = inputTextField.text!.sanitized() + buttonTitle!
        inputTextField.text = inputString.currency()
    }
    
    
    func isDeleteButtonTaped(string: String) -> String {
        
        var curentText = string
        
        curentText.remove(at: curentText.index(before: curentText.endIndex))
        
        return curentText
    }
}



