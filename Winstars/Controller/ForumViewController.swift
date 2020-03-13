//
//  ForumViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 4/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore

class FourmViewController: UIViewController  {
    
    var categoryLabel: String?
    let db = Firestore.firestore()
    
    var forumList = ["Engineering", "Mathmatics", "Science", "Technology"]
    
    func addData(list_of_doc: [String]){
        for ele in list_of_doc{
            db.collection("forum").document(ele).setData([:])
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData(list_of_doc: forumList)
        // Do any additional setup after loading the view.
        
    }
    
}

extension FourmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: "Cell", for: indexPath) as! ForumTableViewCell
        cell.forumButton.setTitle(forumList[indexPath.row], for: .normal)
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("clicked")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let post: FourmPostViewController = segue.destination as! FourmPostViewController
//
//        post.postLabe.text! = categoryCell.categoryLabel

       }

}
