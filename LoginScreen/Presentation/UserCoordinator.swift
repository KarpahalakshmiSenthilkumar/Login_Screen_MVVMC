//
//  UserCoordinator.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import UIKit

class UserCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        loginScreen()
    }
    
    private func loginScreen() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserController") as! UserController
        let repository = AuthService()
        let loginUseCase = LoginUseCase(repository: repository )
        let viewModel = UserViewModel(loginUseCase: loginUseCase, coordinator: self)
        loginViewController.viewModel = viewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func homeScreen() {
        let homeViewController = UIViewController()
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func displayError(message: String) {
        if let loginVC = navigationController.topViewController as? UserController {
            loginVC.showError(message: message)
        }
    }
}
