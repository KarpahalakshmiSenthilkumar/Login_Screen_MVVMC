//
//  UserController.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation

import UIKit
import Combine

class UserController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var viewModel: UserViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            errorLabel.isHidden = true
        }
        
        @IBAction func loginButtonTapped(_ sender: UIButton) {
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            viewModel.login(email: email, password: password)
        }
        
        func showError(message: String) {
            errorLabel.text = message
            errorLabel.isHidden = false
        }
}
