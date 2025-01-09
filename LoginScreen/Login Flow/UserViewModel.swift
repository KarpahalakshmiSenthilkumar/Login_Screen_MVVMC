//
//  UserViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import Combine
import Swinject

protocol LoginViewModelInputs {
    func username(usernameValue: String)
    func password(passwordValue: String)
    func loginTapped()
}

protocol LoginViewModelOutputs {
    var usernameValue: CurrentValueSubject<String, Never> { get }
    var passwordValue: CurrentValueSubject<String, Never> { get }
    var canLogin: AnyPublisher<Bool, Never> { get }
    var loginFailed: PassthroughSubject<(errorMessage: String, errorKey: String, onRetry: Bool), Never> { get }
    var loginSucceeded: PassthroughSubject<Void, Never> { get }
    var usernameInitialValue: CurrentValueSubject<String, Never> { get }
    var passwordInitialValue: CurrentValueSubject<String, Never> { get }
    var isLoginFailed: CurrentValueSubject<Bool, Never> { get }
    var errorMessage: CurrentValueSubject<String, Never> { get }
}

class UserViewModel: LoginViewModelInputs, LoginViewModelOutputs {
    private let authService: AuthServiceInvokable
    private let coordinator: UserCoordinator
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    private var cancellables = Set<AnyCancellable>()
    
//    init(authService: AuthService, coordinator: UserCoordinator) {
//        self.authService = authService
//        self.coordinator = coordinator
//        self.usernameValue.send(self.authService.currentUsername.value ?? "")
//        self.usernameInitialValue.send(self.authService.currentUsername.value ?? "")
//        self.passwordValue.send(self.authService.currentPassword.value ?? "")
//        self.passwordInitialValue.send(self.authService.currentPassword.value ?? "")
//    }
    
    var usernameValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var passwordValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var loginFailedValue: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    var usernameInitialValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var passwordInitialValue: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var loginFailed: PassthroughSubject<(errorMessage: String, errorKey: String, onRetry: Bool), Never> = PassthroughSubject<(errorMessage: String, errorKey: String, onRetry: Bool), Never>()
    var loginSucceeded: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var isLoginFailed: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    var errorMessage: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never> ("")
    var canLogin: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3(usernameValue, passwordValue, isLoginFailed)
            .map { userName, password, logFailed -> Bool in
                let isUsernameValid: Bool = userName.count > 0
                let isPasswordValid: Bool = password.count > 0
                let isLoginFailed: Bool = logFailed

                return isUsernameValid && isPasswordValid && !isLoginFailed
            }.eraseToAnyPublisher()
    }
    
    public init(authService: AuthServiceInvokable? = IoC.resolve(AuthServiceInvokable.self), coordinator: UserCoordinator) {
        
        guard let resolvedAuthService = authService else {
            preconditionFailure("Unable to resolve")
        }
        let service1 = IoC.resolve(AuthServiceInvokable.self)
        let service2 = IoC.resolve(AuthServiceInvokable.self)
        print(service1 === service2)
        self.authService = resolvedAuthService as! AuthService
        self.coordinator = coordinator
        self.usernameValue.send(self.authService.currentUsername.value ?? "")
        self.usernameInitialValue.send(self.authService.currentUsername.value ?? "")
        self.passwordValue.send(self.authService.currentPassword.value ?? "")
        self.passwordInitialValue.send(self.authService.currentPassword.value ?? "")
    }
    
//    deinit {
//        IoC.reset(container: .shared)
//        print("Deinitialized")
//    }
    
    func username(usernameValue: String) {
        outputs.usernameValue.send(usernameValue)
        outputs.isLoginFailed.send(false)
    }
    
    func password(passwordValue: String) {
        outputs.passwordValue.send(passwordValue)
        outputs.isLoginFailed.send(false)
    }
    
    func loginTapped() {
        login(email: usernameValue.value, password: passwordValue.value)
    }
    
    func login(email: String, password: String) {
        authService.login(email: email, password: password) { [weak self] response in
            if response.success {
                self?.isLoginFailed.send(false)
                print(self?.authService.currentUsername.value ?? "No username")
                print(self?.authService.currentPassword.value ?? "No password")
                self?.coordinator.patientListScreen()
            } else {
                self?.isLoginFailed.send(true)
                self?.errorMessage.value = response.message
                self?.coordinator.displayError(message: self?.errorMessage.value ?? "Login failed")
            }
        }
    }
}
