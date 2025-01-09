//
//  PatientListCoordinator.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 09/01/25.
//

import Foundation
import UIKit

class PatientListCoordinator {
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
        displayDetails()
    }
    
    private func displayDetails() {
        let patientListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "patientController") as! PatientListViewController
//        let authService = authService
        let viewModel = PatientListViewModel(authService: authService as! AuthService, coordinator: self)
        patientListViewController.viewModel = viewModel
        navigationController.pushViewController(patientListViewController, animated: true)
    }
}
