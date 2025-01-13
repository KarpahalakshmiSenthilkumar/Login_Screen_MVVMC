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
        
        Task {
            print("queryPatientDetails calling...")
            await queryPatientDetails()
            
            DispatchQueue.main.async {
                self.PatientListTable.reloadData()  // Reload table data
            }
        }
        
//        PatientListTable.register(PatientListCell.self, forCellReuseIdentifier: "patientListCell")
        
        PatientListTable.dataSource = self
        PatientListTable.delegate = self
        
        PatientListTable.estimatedRowHeight = 100 // Estimated height
        PatientListTable.rowHeight = UITableView.automaticDimension
                
        DittoDatabaseManager.shared.queryPatient()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Patient List: \(patientsList.count)")
        return patientsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Return the desired height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedPatient = patientsList[indexPath.row]
            
            // Instantiate the HomeScreenViewController
            if let homeVC = storyboard?.instantiateViewController(identifier: "homeController") as? HomeScreenViewController {
                homeVC.delegate = self
                // Pass the selected patient data to the home controller
                homeVC.patient = selectedPatient  // Assuming you have a patient property in HomeScreenViewController
                
                // Present the home controller
                self.present(homeVC, animated: true, completion: nil)
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "patientListCell", for: indexPath) as? PatientListCell else {
                fatalError("Cell should be of type PatientListCell")
            }
            
            let patient = patientsList[indexPath.row]
            print("Configuring cell with mrn: \(patient.mrn ?? "")") // Debugging

            // Configure the cell with the patient data
            cell.configure(with: patient)
            
            return cell
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        if let homeVC = self.storyboard?.instantiateViewController(identifier: "homeController") as? HomeScreenViewController {
            homeVC.delegate = self
//            patientsList.append(patient)
            self.present(homeVC, animated: true)
        } else {
            print("HomeScreenViewController could not be instantiated")
        }
    }
    
    func queryPatientDetails() async {
        do {
            // Execute the query
            if let result = await DittoDatabaseManager.shared.queryPatientData() {
                
                // Iterate through the items in the result
                for item in result.items {
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
            } else {
                print("No data fetched")
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

extension PatientListViewController: PatientDetailsDelegate {
    func didSavePatient(_ patient: PatientDetails) {
        if let index = patientsList.firstIndex(where: { $0.mrn == patient.mrn }) {
                    // If the patient exists, update the patient at that index
                    patientsList[index] = patient
                    print("Updated patient: \(patient)")
                } else {
                    // If the patient doesn't exist, append the new patient
                    patientsList.append(patient)
                    print("New patient added: \(patient)")
                }
                
                // Reload the table view to reflect the changes
                PatientListTable.reloadData()
    }
}
