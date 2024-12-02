//
//  UserViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import Combine

class UserViewModel {
    private let loginUseCase: LoginUseCase
    private let coordinator: UserCoordinator
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCase, coordinator: UserCoordinator) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
    }
    
    func login(email: String, password: String) {
        isLoading = true
        loginUseCase.execute(email: email, password: password) { [weak self] response in
            if response.success {
                self?.isLoading = false
                self?.coordinator.homeScreen()
            } else {
                self?.isLoading = false
                self?.errorMessage = response.message
                self?.coordinator.displayError(message: self?.errorMessage ?? "Login failed")
            }
        }
    }
}
