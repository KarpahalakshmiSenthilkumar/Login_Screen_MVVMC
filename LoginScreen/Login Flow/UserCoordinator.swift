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
    var authService: AuthServiceInvokable
    
    init(navigationController: UINavigationController, authService: AuthServiceInvokable? = IoC.resolve(AuthServiceInvokable.self, from: .shared)) {
        guard let resolvedAuthService = authService else {
            preconditionFailure("Unable to resolve")
        }
        self.authService = resolvedAuthService as! AuthService
        self.navigationController = navigationController
    }
    
    func start() {
        loginScreen()
    }
    
    private func loginScreen() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserController") as! UserController
        let authService = authService
        let viewModel = UserViewModel(authService: authService, coordinator: self)
        loginViewController.viewModel = viewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func patientListScreen() {
        let patientListCoordinator = PatientListCoordinator(navigationController: navigationController)
        patientListCoordinator.start()
    }
    
    func displayError(message: String) {
        if let loginVC = navigationController.topViewController as? UserController {
            loginVC.showError(message: message)
        }
    }
}
