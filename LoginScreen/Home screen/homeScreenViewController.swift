//
//  homeScreenViewController.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var mrn: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var admissionNumber: UITextField!
    @IBOutlet weak var admitDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
        
    weak var delegate: PatientDetailsDelegate?
    var viewModel: HomeScreenViewModel!
    var patient: PatientDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patient = patient {
            mrn.text = patient.mrn
            firstName.text = patient.firstName
            middleName.text = patient.middleName
            lastName.text = patient.lastName
            gender.text = patient.gender
            dob.date = stringToDate(patient.dateOfBirth ?? "") ?? Date.now
            admissionNumber.text = patient.admissionNo
            admitDate.date = stringToDate(patient.admitDate ?? "") ?? Date.now
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        Task {
            await DittoDatabaseManager.shared.upsertPatientData(mrn: mrn.text ?? "", firstName: firstName.text ?? "", middleName: middleName.text ?? "", lastName: lastName.text ?? "", gender: gender.text ?? "", dobDate: dob.date, admissionNumber: admissionNumber.text ?? "", admitDate: admitDate.date)
        }
        let patient = PatientDetails(
                    mrn: mrn.text ?? "",
                    firstName: firstName.text ?? "",
                    middleName: middleName.text ?? "",
                    lastName: lastName.text ?? "",
                    gender: gender.text ?? "",
                    dateOfBirth: dateToString(dob.date),
                    admissionNo: admissionNumber.text ?? "",
                    admitDate: dateToString(admitDate.date)
                )
        delegate?.didSavePatient(patient)
        self.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true) {
//            if let delegate = self.delegate {
//                let patient = PatientDetails(
//                    mrn: self.mrn.text ?? "",
//                    firstName: self.firstName.text ?? "",
//                    middleName: self.middleName.text ?? "",
//                    lastName: self.lastName.text ?? "",
//                    gender: "", // Assign based on gender selection
//                    dateOfBirth: self.dateToString(self.dob.date),
//                    admissionNo: self.admissionNumber.text ?? "",
//                    admitDate: self.dateToString(self.admitDate.date)
//                )
//                delegate.didSavePatient(patient)
//            }
        }
    private func dateToString(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
    
    private func stringToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short  // You can adjust the style if needed.
        return formatter.date(from: dateString)
    }
}
