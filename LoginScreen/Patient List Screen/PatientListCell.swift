//
//  PatientListCell.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 09/01/25.
//

import Foundation
import UIKit

class PatientListCell: UITableViewCell {
    
    @IBOutlet weak var mrnLabel: UILabel?
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var middleNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel?
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var dobDateLabel: UILabel?
    @IBOutlet weak var admissionNumberLabel: UILabel?
    @IBOutlet weak var admitDateLabel: UILabel?
    
    func configure(with list: PatientDetails) {
        print(list)
        mrnLabel?.text = list.mrn ?? "N/A"
        print("mrn: \(list.mrn ?? "")")
        print("mrnLabel: \(mrnLabel?.text ?? "")")
        firstNameLabel?.text = list.firstName ?? "N/A"
        middleNameLabel?.text = list.middleName ?? "N/A"
        lastNameLabel?.text = list.lastName ?? "N/A"
        genderLabel?.text = list.gender ?? "N/A"
        dobDateLabel?.text = list.dateOfBirth ?? "N/A"
        admissionNumberLabel?.text = list.admissionNo ?? "N/A"
        admitDateLabel?.text = list.admitDate ?? "N/A"
    }
}
