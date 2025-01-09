//
//  homeScreenCoordinator.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 05/12/24.
//

import Foundation
import UIKit

class HomeScreenCoordinator {
    
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
        displayCredentials()
    }
    
    private func displayCredentials() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeController") as? HomeScreenViewController else {
            print("Failed to instantiate HomeScreenViewController")
            return
        }
//        let authService = authService
        let viewModel = HomeScreenViewModel(authService: authService as! AuthService, coordinator: self)
        homeViewController.viewModel = viewModel
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
