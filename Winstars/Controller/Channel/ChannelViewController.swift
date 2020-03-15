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


class ChannelViewController: UIViewController  {
    
    let db = Firestore.firestore()

    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var navbar: UINavigationItem!
    
    private var currentChannelAlertController: UIAlertController?
//    private var channelReference: CollectionReference {
//        return db.collection("groups").document("8Wxyis3s4RXIaT2qSz9Y")("channels")
//    }
    
    private var reference: CollectionReference?
    
    var data = [
        "groupLabel": "" // the label selected
    ]
    private var channels = [[String: Any]]() {
        didSet {
            channelTableView.reloadData()
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
//        print("add button pressed")
//        let ac = UIAlertController(title: "Create a new Channel", message: nil, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        ac.addTextField { field in
//            field.enablesReturnKeyAutomatically = true
//            field.autocapitalizationType = .words
//            field.clearButtonMode = .whileEditing
//            field.placeholder = "Channel name"
//            field.returnKeyType = .done
//        }
//
//        let createAction = UIAlertAction(title: "Create", style: .default, handler: { _ in
//            self.createChannel()
//        })
//        createAction.isEnabled = false
//        ac.addAction(createAction)
//        ac.preferredAction = createAction
//
//        present(ac, animated: true) {
//            ac.textFields?.first?.becomeFirstResponder()
//        }
//        currentChannelAlertController = ac
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = data["categoryLabel"]
    }
    
    private func createChannel() {
//        guard let ac = currentChannelAlertController else {
//            return
//        }
//        let channel = Channel(name: channelName, author: "testUser")
//        channelReference.addDocument(data: channel.representation) { error in
//            if let e = error {
//                print("Error saving channel: \(e.localizedDescription)")
//            }
//        }
    }
}



extension ChannelViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: "channelCell", for: indexPath) as! ChannelViewTableViewCell
        cell.authorLabel?.text = "posted by: \(channels[indexPath.row]["user"]!)"
        cell.titleLabel?.text = "\(channels[indexPath.row]["title"]!)"
        cell.emojiLabel?.text = Extension.emojiGenerate()!
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(channels[indexPath.row])
        self.performSegue(withIdentifier: "toChatView", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chatViewController = segue.destination as! ChatViewController
        //        messageViewController.data["messages"] = "testMsg"
        
    }
}
