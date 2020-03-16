//
//  AddChannelViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 16/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore
import FirebaseAuth

class AddChannelViewController: UIViewController, UITextFieldDelegate {
    
    var channelReference: CollectionReference? = nil
    var selectedEmoji: String = "😀"
    @IBOutlet weak var tittleTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    let emojiArray = [
        "😀","😅","😎", "😭", "🤔", "🤑","😂", "🥳"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tittleTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private func createChannel(channel: Channel) {
        
        channelReference?.addDocument(data: channel.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 0 { //cancel pressed
            print("cancel pressed")
            dismiss(animated: true, completion: nil)
            
        }
            
        else if sender.tag == 1 { // add Pressed
            print("add pressed")
            if tittleTextField.text!.isEmpty {
                let controller = UIAlertController(title: "Warning", message: "Please type the title", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true, completion: nil)
                
            } else{
                
                createChannel(channel: Channel(name: tittleTextField.text!, author: AppSettings.displayName, emoji: selectedEmoji))
                
                dismiss(animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
}

extension AddChannelViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.emojiArray.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80.0
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont (name: "Helvetica Neue", size: 80)
        label.text =  emojiArray[row]
        label.textAlignment = .center
        return label
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEmoji = emojiArray[row]
        print(selectedEmoji)
        
    }
    
}
