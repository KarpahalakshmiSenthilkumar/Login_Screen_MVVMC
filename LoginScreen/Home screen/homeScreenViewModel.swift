//
//  homeScreenViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 05/12/24.
//

import Foundation
import Combine
import UIKit

protocol HomeScreenViewModelInputs {
    func mrn(mrnValue: String)
    func firstName(firstNameValue: String)
    func middleName(middleNameValue: String)
    func lastName(lastNameValue: String)
    func gender(genderValue: String)
    func dobDate(dobDateValue: String)
    func admissionNumber(admissionNumberValue: String)
    func admitDate(admitDateValue: String)
}

protocol HomeScreenViewModelOutputs {
    var mrn: CurrentValueSubject<String, Never> { get }
    var firstName: CurrentValueSubject<String, Never> { get }
    var middleName: CurrentValueSubject<String, Never> { get }
    var lastName: CurrentValueSubject<String, Never> { get }
    var gender: CurrentValueSubject<String, Never> { get }
    var dobDate: CurrentValueSubject<String, Never> { get }
    var admissionNumber: CurrentValueSubject<String, Never> { get }
    var admitDate: CurrentValueSubject<String, Never> { get }
}

class HomeScreenViewModel: HomeScreenViewModelInputs, HomeScreenViewModelOutputs {
    
    private let authService:AuthServiceInvokable
    private let coordinator: HomeScreenCoordinator
        
    var inputs: HomeScreenViewModelInputs { return self }
    var outputs: HomeScreenViewModelOutputs { return self }

    var mrn: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var firstName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var middleName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var lastName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var gender: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var dobDate: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var admissionNumber: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var admitDate: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    
    init(authService: AuthService, coordinator: HomeScreenCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
//        self.emailValue.send(self.authService.currentUsername.value ?? "")
//        self.passwordValue.send(self.authService.currentPassword.value ?? "")
    }
    
    func mrn(mrnValue: String) {
        outputs.mrn.send(mrnValue)
    }
    
    func firstName(firstNameValue: String) {
        outputs.firstName.send(firstNameValue)
    }
    
    func middleName(middleNameValue: String) {
        outputs.middleName.send(middleNameValue)
    }
    
    func lastName(lastNameValue: String) {
        outputs.lastName.send(lastNameValue)
    }
    
    func gender(genderValue: String) {
        outputs.gender.send(genderValue)
    }
    
    func dobDate(dobDateValue: String) {
        outputs.dobDate.send(dobDateValue)
    }
    
    func admissionNumber(admissionNumberValue: String) {
        outputs.admissionNumber.send(admissionNumberValue)
    }
    
    func admitDate(admitDateValue: String) {
        outputs.admitDate.send(admitDateValue)
    }
}
