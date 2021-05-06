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
import FirebaseStorage

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
    }
    
    // MARK: - Outlets and Actions
    
    @IBAction func uploadTapped(_ sender: Any) {
        uploadImageToCloudStorage()
    }
    @IBAction func downloadTapped(_ sender: Any) {
        downloadJeff()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
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
    
    private func uploadImageToCloudStorage() {
        progressView.isHidden = false
        // Get a reference to  firebaseApp Storage
        let storageRef = Storage.storage().reference()
        
        // Create a resource id
        let randomId = UUID().uuidString
        
        // Create a reference to the image
        let resource = "\(randomId).jpg"
        let directory = "images"
        let jeffRef = storageRef.child(directory + "/" + resource)
        
        // Create Metadata
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
     
        // Get the data to upload
        guard let jeffImgData = UIImage(named: "jeff")?.jpegData(compressionQuality: 1.0) else { return }
        
        // Create the upload task with the reference and data
        let uploadTask = jeffRef.putData(jeffImgData, metadata: uploadMetadata) { (metadata, error) in
            // Completion Handler
            guard let metadata = metadata else {
                print("Oh no! Upload Error!")
                return
            }
            print("Upload Successful. We got this back:")
            print(metadata)
            jeffRef.downloadURL { (url, error) in
                if let downloadUrl = url {
                    print(downloadUrl.absoluteURL)
                }
                print("Download url was null")
            }
        }
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            guard let progress = snapshot.progress?.fractionCompleted else { return }
            self?.progressView.progress = Float(progress)
        }
    }
    
    private func downloadJeff() {
        let storageRef = Storage.storage().reference(withPath: "images/69EF383A-0C40-4D76-9C84-61549705FBFF.jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024) {[weak self] (data, error) in
            if let error = error {
                print("ERR: \(error)")
                return
            }
            if let data = data {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }


}

