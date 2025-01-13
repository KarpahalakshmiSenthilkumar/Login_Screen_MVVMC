//
//  PatientListViewController.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 09/01/25.
//

import UIKit

protocol PatientDetailsDelegate: AnyObject {
    func didSavePatient(_ patient: PatientDetails)
}

class PatientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var PatientListTable: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    
    var patientsList: [PatientDetails] = []
    var viewModel: PatientListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PatientListViewController loaded")
        
        PatientListTable.dataSource = self
        PatientListTable.delegate = self
        
        PatientListTable.estimatedRowHeight = 200 // Estimated height
        PatientListTable.rowHeight = UITableView.automaticDimension
        
        PatientListTable.register(PatientListCell.self, forCellReuseIdentifier: "patientListCell")
        
        Task {
            print("queryPatientDetails calling...")
            await queryPatientDetails()
        }
        
        DittoDatabaseManager.shared.queryPatient()
        
//        Task {
//            let result = await databaseManager.queryPatientData()
//            let item = result!.items[0]
////            let itemValue = item.value
//            let itemValueColor = item.value["mrn"]
////            print("itemValueColor \(itemValueColor)")
//            patientsList.append(PatientDetails(mrn: item.value["mrn"] as! String, firstName: item.value["firstName"] as! String, middleName: item.value["middleName"] as! String, lastName: item.value["lastName"] as! String, gender: item.value["gender"] as! String, dateOfBirth: item.value["dobDate"] as! String, admissionNo: item.value["admissionNumber"] as! String, admitDate: item.value["admitDate"] as! String))
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Return the desired height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientListCell", for: indexPath) as! PatientListCell
        let list = patientsList[indexPath.row]
        cell.configure(with: list)
        return cell
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        if let homeVC = self.storyboard?.instantiateViewController(identifier: "homeController") as? HomeScreenViewController {
//            homeVC.delegate = self
//            patientsList.append(patient)
            self.present(homeVC, animated: true)
        } else {
            print("HomeScreenViewController could not be instantiated")
        }
    }
    
    func queryPatientDetails() async {
        do {
            // Execute the query
            let result = await DittoDatabaseManager.shared.queryPatientData()
            
            // Iterate through the items in the result
            for item in result!.items {
                let mrn = item.value["mrn"] as? String ?? "Unknown MRN"
                let firstName = item.value["firstName"] as? String ?? "Unknown First Name"
                let middleName = item.value["middleName"] as? String ?? "Unknown Middle Name"
                let lastName = item.value["lastName"] as? String ?? "Unknown Last Name"
                let gender = item.value["gender"] as? String ?? "Unknown Gender"
                let dateOfBirth = item.value["dobDate"] as? String ?? "Unknown DOB"
                let admissionNo = item.value["admissionNumber"] as? String ?? "Unknown Admission No"
                let admitDate = item.value["admitDate"] as? String ?? "Unknown Admit Date"

                // Initialize the Patient model and append it to the array
                let patient = PatientDetails(mrn: mrn, firstName: firstName, middleName: middleName, lastName: lastName, gender: gender, dateOfBirth: dateOfBirth, admissionNo: admissionNo, admitDate: admitDate)
                print("Patient \(patient)")
                patientsList.append(patient)
            }
        }
    }
//    func navigateToHomeScreen() {
//        if let homeVC = self.storyboard?.instantiateViewController(identifier: "") as? HomeScreenViewController {
//            homeVC.delegate = self
//            self.present(homeVC, animated: true)
//        }
//    }
}

//extension PatientListViewController: PatientDetailsDelegate {
//    func didSavePatient(_ patient: PatientDetails) {
//        patientsList.append(patient)
//        print(patient)
//        PatientListTable.reloadData()
//    }
//}
