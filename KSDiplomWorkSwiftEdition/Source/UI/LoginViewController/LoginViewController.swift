//
//  LoginViewController.swift
//  KSDiplomWorkSwiftEdition
//
//  Created by Serhii Kostiuk on 4/24/17.
//  Copyright © 2017 Serhii Kostiuk. All rights reserved.
//

import UIKit
import HSegmentControl

class LoginViewController: UIViewController, HSegmentControlDataSource {

    @IBOutlet weak var segmentControl: HSegmentControl!
    @IBOutlet weak var containerView: UIView!
 
    fileprivate var currentViewController:UIViewController?
    fileprivate lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        buildSegmentioView(segmentioView: segmentioView)
        
//        segmentioView.selectedSegmentioIndex = 0
        
        setupSegmentControl()
        presentController(controller: viewControllers[0])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func preparedViewControllers() -> [UIViewController] {
        let signinVC = SignInViewController.create()
        let signupVC = SignUpViewController.create()
        
        signupVC.delegate = self
        
        return[signinVC, signupVC]
    }
    
    fileprivate func presentController(controller:UIViewController) {
        UIView .animate(withDuration: 0.6, animations: {
            if let _ = self.currentViewController {
                self.removeCurrentViewController()
            }
        }) { _ in
            self.addChildViewController(controller)
            self.containerView .addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
    }
    
    fileprivate func removeCurrentViewController() {
        currentViewController?.willMove(toParentViewController: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParentViewController()
    }
    
    fileprivate func setupSegmentControl() {
        segmentControl.dataSource = self
        segmentControl.numberOfDisplayedSegments = 2
        segmentControl.segmentIndicatorViewContentMode = UIViewContentMode.bottom
        segmentControl.selectedTitleFont = UIFont.boldSystemFont(ofSize: 17)
        segmentControl.selectedTitleColor = UIColor(red: 232/255, green: 76/255, blue: 86/255, alpha: 1)
        segmentControl.unselectedTitleFont = UIFont.systemFont(ofSize: 17)
        segmentControl.unselectedTitleColor = UIColor.darkGray
        segmentControl.segmentIndicatorImage = UIImage(named: "rect_")
        segmentControl.segmentIndicatorView.backgroundColor = UIColor.white
    }
    
    // MARK: - HSegmentControlDataSource protocol
    func numberOfSegments(_ segmentControl: HSegmentControl) -> Int {
        return 2
    }
    
    func segmentControl(_ segmentControl: HSegmentControl, titleOfIndex index: Int) -> String {
        return ["Логин", "Регистрация"][index]
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        if segmentControl.selectedIndex == 0 {
            presentController(controller: viewControllers[0])
        } else {
            presentController(controller: viewControllers[1])
        }
    }
}

extension LoginViewController:signUpDelegate {
    func newUserRegister() {
        let username = UserDefaults.standard.object(forKey: "username")
        let pass = UserDefaults.standard.object(forKey: "password")
        let controller = viewControllers[0] as! SignInViewController
        
        controller.loginTextField.text = username as? String
        controller.passwordTextField.text = pass as? String
        presentController(controller: controller)
    }
}
