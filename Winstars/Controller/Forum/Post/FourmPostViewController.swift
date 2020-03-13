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
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var navbar: UINavigationItem!
    var data = [
        "categoryLabel" : "" // the label selected
    ]
    var db_data = [[String: Any]]() {
        didSet {
            postTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = data["categoryLabel"]
        
        fetchData()
        
        
    }
    
    func fetchData(){

            self.db.collection("forum").document(self.data["categoryLabel"]!).collection("posts").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.db_data.append(document.data())
                }
            }
        }

    }
    
    func addData(){
        
        let post = Post(title: "test_title", user: "Billy", content: "test_Content")
        var post_with_timestamp = post.toDict() ?? [:]
        post_with_timestamp["created_at"] = Timestamp()
        
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref =  db.collection("forum").document(data["categoryLabel"]!).collection("posts").addDocument(data: post_with_timestamp) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
        
        
    }
    
}



extension ForumPostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: "postCell", for: indexPath) as! ForumPostiVIewTableViewCell
        cell.authorLabel?.text = "posted by: \(db_data[indexPath.row]["user"]!)"
        cell.titleLabel?.text = "\(db_data[indexPath.row]["title"]!)"
        cell.emojiLabel?.text = Extension.emojiGenerate()!
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(db_data[indexPath.row])
    }
    
}
