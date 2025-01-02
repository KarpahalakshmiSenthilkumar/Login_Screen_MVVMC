//
//  homeScreenViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 05/12/24.
//

import Foundation
import Combine

protocol HomeScreenViewModelOutputs {
    var emailValue: CurrentValueSubject<String, Never> { get }
    var passwordValue: CurrentValueSubject<String, Never> { get }
}

class HomeScreenViewModel: HomeScreenViewModelOutputs {
    
    private let authService:AuthServiceInvokable
    private let coordinator: HomeScreenCoordinator
    var outputs: HomeScreenViewModelOutputs { return self }

    var emailValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never> ("")
    var passwordValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never> ("")
    
    init(authService: AuthService, coordinator: HomeScreenCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
        self.emailValue.send(self.authService.currentUsername.value ?? "")
        self.passwordValue.send(self.authService.currentPassword.value ?? "")
    }
    
    deinit {
        print("Object deinitialized")
    }
}
