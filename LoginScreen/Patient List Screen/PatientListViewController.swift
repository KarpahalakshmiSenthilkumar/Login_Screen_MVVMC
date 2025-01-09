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
        
//        patientsList.append(PatientDetails(mrn: "1234", firstName: "Gayathri", middleName: "Priya", lastName: "Madhavan", gender: "Female", dateOfBirth: "12/12/1985", admissionNo: "1537", admitDate: "12/5/2024"))
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
            homeVC.delegate = self
            self.present(homeVC, animated: true)
        } else {
            print("HomeScreenViewController could not be instantiated")
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
        patientsList.append(patient)
        print(patient)
        PatientListTable.reloadData()
    }
}
