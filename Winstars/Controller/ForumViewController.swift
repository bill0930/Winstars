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
    
    
    var forumList = ["Engineering", "Mathmatics", "Science", "Technology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("hellowwrold")
        
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
        
        cell.forumLabel?.text = forumList[indexPath.row]
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(forumList[indexPath.row])
    }
    
    
}
