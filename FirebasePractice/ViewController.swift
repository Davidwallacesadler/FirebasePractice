//
//  ViewController.swift
//  FirebasePractice
//
//  Created by David Sadler on 4/29/21.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController {
    
    // MARK: - Local Properties:
    // Local firestore db instance:
    var db: Firestore!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase setup:
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        // Firebase Crud practice:
//        createMocWorkout()
    }

    // MARK: - CRUD Practice:
    private func createMocWorkout() {
        // Define the shape of the data:
        let workoutData : [String: Any] = [
            "workouts":
                [
                    [
                        "week_day": "Monday",
                        
                    ],
                
                ],
            "start_date": Timestamp(date: Date()),
            "end_date": Timestamp(date: Date()),
        ]
        
        // Grab the document reference:
        var reference: DocumentReference? = nil
        
        // Use the reference to add a collection / document
        reference = db.collection("workouts").addDocument(data: workoutData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(reference!.documentID)")
            }
        }
    }

}

