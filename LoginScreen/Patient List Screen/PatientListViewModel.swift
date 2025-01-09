//
//  PatientListViewModel.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 09/01/25.
//

import Foundation
import Combine

protocol PatientListViewModelOutputs {
    var mrn: CurrentValueSubject<String, Never> { get }
    var firstName: CurrentValueSubject<String, Never> { get }
    var middleName: CurrentValueSubject<String, Never> { get }
    var lastName: CurrentValueSubject<String, Never> { get }
    var gender: CurrentValueSubject<String, Never> { get }
    var dobDate: CurrentValueSubject<String, Never> { get }
    var admissionNumber: CurrentValueSubject<String, Never> { get }
    var admitDate: CurrentValueSubject<String, Never> { get }
}

class PatientListViewModel: PatientListViewModelOutputs {
    
    private let authService:AuthServiceInvokable
    private let coordinator: PatientListCoordinator
//    private let homeViewModel: HomeScreenViewModel
//    private let homeCoordinator: HomeScreenCoordinator?
    var outputs: PatientListViewModelOutputs { return self }

    var mrn: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var firstName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var middleName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var lastName: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var gender: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var dobDate: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var admissionNumber: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    var admitDate: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    
    init(authService: AuthService, coordinator: PatientListCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
//        self.homeCoordinator = homeCoordinator
//        self.homeViewModel = HomeScreenViewModel(authService: authService, coordinator: homeCoordinator!)
//        self.mrn.send(self.homeViewModel.mrn.value)
//        self.firstName.send(self.homeViewModel.firstName.value)
//        self.middleName.send(self.homeViewModel.middleName.value)
//        self.lastName.send(self.homeViewModel.lastName.value)
//        self.gender.send(self.homeViewModel.gender.value)
//        self.dobDate.send(self.homeViewModel.dobDate.value)
//        self.admissionNumber.send(self.homeViewModel.admissionNumber.value)
//        self.admitDate.send(self.homeViewModel.admitDate.value)
    }
}
