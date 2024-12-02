//
//  AuthService.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation

class AuthService: LoginRepository {
    func login (email: String, password: String, completion: @escaping (LoginResponse)->Void) {
        if email == "gayathri@gmail.com" && password == "Gayathri@123" {
            completion(LoginResponse(success: true, message: "Login Successful"))
        } else {
            completion(LoginResponse(success: false, message: "Invalid credentials"))
        }
    }
}
