//
//  LoginViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 17/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        displayNameField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        //logged in
        
        if Auth.auth().currentUser != nil {
            self.signIn()
        } else {
            print( "No user is signed in" )

          // .
          // ...
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func signIn() {
        guard let name = displayNameField.text, !name.isEmpty else {
            showMissingNameAlert()
            return
        }
        
        displayNameField.resignFirstResponder()
        
        AppSettings.displayName = name
        Auth.auth().signInAnonymously(completion: nil)
        self.performSegue(withIdentifier: "toTabbarVC", sender: self)

        
    }
    
    private func showMissingNameAlert() {
        let ac = UIAlertController(title: "Display Name Required", message: "Please enter a display name.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.displayNameField.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        signIn()
    }
    
    
}
