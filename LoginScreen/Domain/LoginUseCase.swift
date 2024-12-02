//
//  LoginUseCase.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 02/12/24.
//

import Foundation

final class LoginUseCase {
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(email: String, password: String, completion: @escaping (LoginResponse)->Void) {
        return repository.login(email: email, password: password, completion: completion)
    }
}
