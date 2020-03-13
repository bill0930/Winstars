//
//  FourmPostViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 13/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore


class ForumPostViewController: UIViewController  {
    let db = Firestore.firestore()
    
    @IBOutlet weak var navbar: UINavigationItem!
    var data = [
        "categoryLabel" : "" // the label selected
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = data["categoryLabel"]
        
//        addData()
        
//        getData()
    }
    
    func getData(){
        db.collection("forum").document(data["categoryLabel"]!).collection("posts").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func addData(){
        
        let post = Post(title: "test_title", user: "Billy", content: "test_Content");
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref =  db.collection("forum").document(data["categoryLabel"]!).collection("posts").addDocument(data: post.toDict() ?? [:]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        

        
        
    }
}
