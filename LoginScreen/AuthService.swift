//
//  AuthService.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import Combine

class AuthService: AuthServiceInvokable {

//    static let shared = AuthService()
    var currentUsername: CurrentValueSubject<String?, Never> = CurrentValueSubject<String?, Never> ("")
    var currentPassword: CurrentValueSubject<String?, Never> = CurrentValueSubject<String?, Never> ("")
    
    func login (email: String, password: String, completion: @escaping (LoginResponse)->Void) {
        if email != "" && password != "" {
            currentUsername.send(email)
            currentPassword.send(password)
            completion(LoginResponse(success: true, message: "Login Successful"))
        } else {
            completion(LoginResponse(success: false, message: "Invalid credentials"))
        }
    }
}
