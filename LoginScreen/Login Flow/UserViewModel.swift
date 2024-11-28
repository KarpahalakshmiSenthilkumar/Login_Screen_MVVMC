//
//  UserViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import Combine

class UserViewModel {
    private let authService:AuthService
    private let coordinator: UserCoordinator
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService, coordinator: UserCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func login(email: String, password: String) {
        authService.login(email: email, password: password) { [weak self] response in
            if response.success {
                self?.coordinator.homeScreen()
            } else {
                self?.errorMessage = response.message
                self?.coordinator.displayError(message: self?.errorMessage ?? "Login failed")
            }
        }
    }
}
