//
//  SignUpViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/24/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit

protocol signUpDelegate: class {
    func newUserRegister()
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPassTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    weak var delegate:signUpDelegate?

    // MARK: - Class Func
    
    class func create() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SignUpViewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            reEnterPassTextField.becomeFirstResponder()
        case reEnterPassTextField:
            emailTextField.becomeFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }

        return true
    }

    @IBAction func onSignUpAction(_ sender: Any) {
        if loginTextField.text == "" || passwordTextField.text == "" {
            presentAlertController(delegate: self, message: "Need to fill all fields")
            return
        }
        
        if checkPasswordMatch() == true {
            registerNewUser()
        }
    }
    // TODO: - email verification
    
    func checkPasswordMatch()-> Bool {
        if passwordTextField.text == reEnterPassTextField.text {
            return true
        }
        presentAlertController(delegate: self, message: "Password don't match")
        
        return false
    }

    func registerNewUser() {
        UserDefaults.standard.setValue(loginTextField.text, forKey: "username")
        UserDefaults.standard.setValue(passwordTextField.text, forKey: "password")
        
        delegate?.newUserRegister()
    }
    
}
