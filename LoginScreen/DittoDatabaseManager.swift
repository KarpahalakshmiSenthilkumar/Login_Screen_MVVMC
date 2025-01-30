//
//  DittoDatabaseManager.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 09/01/25.
//

import Foundation
import DittoSwift

class DittoDatabaseManager {

    static let shared = DittoDatabaseManager()
    private var ditto: Ditto
    private var store: DittoStore

    init() {
        // Initialize Ditto
        self.ditto = Ditto(identity: .onlinePlayground(
            appID: "32331fd4-c4b7-4b29-8104-a9853da303d8",
            token: "1f48ba1d-300f-4365-b962-29b2b143472d"
        ))
                
        do {
          try ditto.startSync()
        } catch (let err) {
          print(err.localizedDescription)
        }
        self.store = ditto.store
    }
    
    func upsertPatientData(mrn: String, firstName: String, middleName: String, lastName: String, gender: String, dobDate:Date, admissionNumber: String, admitDate: Date) async {
        let newPatient: [String: Any] = [
                "mrn": mrn,
                "firstName": firstName,
                "middleName": middleName,
                "lastName": lastName,
                "gender": gender,
                "dobDate": dobDate,
                "admissionNumber": admissionNumber,
                "admitDate": admitDate,
                "treatment_id": mrn
            ]
            
            do {
                // Check if a document with the given MRN exists
                let existingPatient = try await store.execute(query: "SELECT * FROM patient1 WHERE mrn = :mrn", arguments: ["mrn": mrn])
                
                if existingPatient.items.isEmpty {
                    // If no document exists, insert a new one
                    try await store.execute(query: "INSERT INTO patient1 DOCUMENTS (:patient)", arguments: ["patient": newPatient])
                    print("New patient data inserted successfully.")
                } else {
                    // If the document exists, update it
                    let patientDocID = existingPatient.items[0].value["_id"]  // Get the existing document ID
                    try await store.execute(
                        query: "UPDATE patient1 SET firstName = :firstName, middleName = :middleName, lastName = :lastName, gender = :gender, dobDate = :dobDate, admissionNumber = :admissionNumber, admitDate = :admitDate, treatment_id = :treatment_id WHERE _id = :id",
                        arguments: [
                            "firstName": firstName,
                            "middleName": middleName,
                            "lastName": lastName,
                            "gender": gender,
                            "dobDate": dobDate,
                            "admissionNumber": admissionNumber,
                            "admitDate": admitDate,
                            "treatment_id": mrn,
                            "id": patientDocID
                        ]
                    )
                    print("Existing patient data updated successfully.")
                }
            } catch {
                print("Error upserting patient data: \(error)")
            }
    }

    func queryPatientData() async -> DittoQueryResult? {
        do {
            // Query to select all data from the `cars` collection
            let result = try await store.execute(query: "SELECT * FROM patient1")
            print("Query result: \(result.items)")
            return result
        } catch {
            print("Error querying patient data: \(error)")
            return nil
        }
    }
    
    func queryPatient() {
        let treatmentCollection = ditto.store.collection("treatment")
        let patientCollection = ditto.store.collection("patient1")

        // Fetch all patients
        let allPatients = patientCollection.findAll().exec()
        print("All patient variable is in use")
        print(allPatients)

        for patient in allPatients {
            // Extract the treatment_id from the patient document
            print("Patient \(patient)")
            if let treatmentID = patient["treatment_id"].value as? String {
                
                // Fetch the corresponding treatment document using the treatment_id
                if let treatmentDoc  = treatmentCollection.find(treatmentID).exec() as [DittoDocument]? {
                    
                    // Combine patient and treatment details
//                    var patientWithTreatment = patient
                    let patientWithTreatment = treatmentDoc
                    
                    // Output the combined patient and treatment details
                    print("Patient with treatment details: \(patientWithTreatment)")
                } else {
                    print("No treatment found for treatment_id \(treatmentID)")
                }
            } else {
                print("Treatment id not found")
            }
        }
    }
}
