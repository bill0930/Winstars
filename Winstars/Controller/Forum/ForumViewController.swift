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
    
    var selectedCategory: String?
    let db = Firestore.firestore()
    
    var categoryList = ["Science", "Technology","Engineering", "Mathmatics", "Coding"]
    
    func addData(list_of_doc: [String]){
        for ele in list_of_doc{
            db.collection("forum").document(ele).setData([:])
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData(list_of_doc: categoryList)
        // Do any additional setup after loading the view.
        
    }
    
}

extension FourmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: "Cell", for: indexPath) as! ForumTableViewCell
        cell.categoryLabel.text = categoryList[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedCategory = categoryList[indexPath.row]
         self.performSegue(withIdentifier: "toPostView", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let postViewController = segue.destination as! ForumPostViewController
        postViewController.data["categoryLabel"] = selectedCategory!
        
       }

}
