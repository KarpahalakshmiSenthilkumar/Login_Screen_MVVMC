//
//  PatientDetails.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 02/01/25.
//

import Foundation

struct PatientDetails {
    var mrn: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var gender: String?
    var dateOfBirth: String?
    var admissionNo: String?
    var admitDate: String?
    
    init(mrn: String, firstName: String, middleName: String, lastName: String, gender: String, dateOfBirth: String, admissionNo: String, admitDate: String) {
        self.mrn = mrn
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.admissionNo = admissionNo
        self.admitDate = admitDate
    }
}
