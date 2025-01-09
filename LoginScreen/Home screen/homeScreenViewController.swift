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
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var admissionNumber: UITextField!
    @IBOutlet weak var admitDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: PatientDetailsDelegate?
    var viewModel: HomeScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setDefaultStates()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let delegate = self.delegate {
                let patient = PatientDetails(
                    mrn: self.mrn.text ?? "",
                    firstName: self.firstName.text ?? "",
                    middleName: self.middleName.text ?? "",
                    lastName: self.lastName.text ?? "",
                    gender: "", // Assign based on gender selection
                    dateOfBirth: self.dateToString(self.dob.date),
                    admissionNo: self.admissionNumber.text ?? "",
                    admitDate: self.dateToString(self.admitDate.date)
                )
                delegate.didSavePatient(patient)
            }
        }
    }
    private func dateToString(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
}

extension HomeScreenViewController {
//    func setDefaultStates() {
////        self.usernameLabel.text = self.viewModel.outputs.emailValue.value
////        self.passwordLabel.text = self.viewModel.outputs.passwordValue.value
//    }
}
