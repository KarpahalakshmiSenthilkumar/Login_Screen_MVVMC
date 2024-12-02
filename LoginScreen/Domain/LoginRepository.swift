//
//  LoginRepository.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 02/12/24.
//

import Foundation

protocol LoginRepository {
    func login(email: String, password: String, completion: @escaping (LoginResponse)->Void)
}
