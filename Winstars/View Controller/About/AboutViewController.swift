//
//  AboutViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 17/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AboutViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        usernameLabel.text = AppSettings.displayName
        uidLabel.text =  Auth.auth().currentUser?.uid
          // ...
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        do {
               try Auth.auth().signOut()
                
            performSegue(withIdentifier: "toLoginVC", sender: self)
           } catch let error {
               // handle error here
               print("Error trying to sign out of Firebase: \(error.localizedDescription)")
           }
        
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
