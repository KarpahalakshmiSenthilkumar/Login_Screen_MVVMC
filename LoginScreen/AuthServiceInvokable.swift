//
//  AuthServiceInvokable.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 04/12/24.
//

import Foundation
import Combine

protocol AuthServiceInvokable: AnyObject {
    var currentUsername: CurrentValueSubject<String?, Never> { get }
    var currentPassword: CurrentValueSubject<String?, Never> { get }
    func login(email: String, password: String, completion: @escaping (LoginResponse) -> Void)
}
