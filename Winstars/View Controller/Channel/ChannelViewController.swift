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
import FirebaseAuth

class ChannelViewController: UIViewController  {
    
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var navbar: UINavigationItem!
    
    
    // the data we get from segue
    var data = [
        "group_id": nil ,
        "group_name": nil
        ] as [String : Any?]
    var selectedChannel: Channel? = nil
    
    private let channelCellIdentifier = "channelCell"
    private var currentChannelAlertController: UIAlertController?
    
    private let db = Firestore.firestore()
    
    private var channelReference: CollectionReference {
        return db.collection("groups").document(data["group_id"] as! String
        ).collection("channels")
    }
    
    private var channels = [Channel]()
    private var channelListener: ListenerRegistration?
    let currentUser: User? = Auth.auth().currentUser
    
    deinit {
        channelListener?.remove()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = (data["group_name"] as! String)
        
        channelListener = channelReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
        
    }
    // MARK: - Helpers
    
    private func createChannel() {
        guard let ac = currentChannelAlertController else {
            return
        }
        
        guard let channelName = ac.textFields?.first?.text else {
            return
        }
        
        let channel = Channel(name: channelName, author: AppSettings.displayName, emoji: "😆")
        channelReference.addDocument(data: channel.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
    }
    
    private func addChannelToTable(_ channel: Channel) {
        guard !channels.contains(channel) else {
            return
        }
        
        channels.append(channel)
        channels.sort()
        
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        channelTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func updateChannelInTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        
        channels[index] = channel
        channelTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func removeChannelFromTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else {
            return
        }
        
        channels.remove(at: index)
        channelTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        guard let channel = Channel(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            addChannelToTable(channel)
            
        case .modified:
            updateChannelInTable(channel)
            
        case .removed:
            removeChannelFromTable(channel)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddChannelView", sender: self)
    }
}



extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: "channelCell", for: indexPath) as! ChannelViewTableViewCell
        cell.authorLabel?.text = "posted by: \(channels[indexPath.row].author)"
        cell.titleLabel?.text = "\(channels[indexPath.row].name)"
        if let image = UIImage(named: (channels[indexPath.row].icon)){
            cell.imageView?.image = image
            cell.imageView?.contentMode = .scaleToFill
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy HH:mm"
        let date = channels[indexPath.row].timestamp.dateValue()
        
        cell.timestampLabel?.text = dateFormatter.string(from: date)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(channels[indexPath.row].representation)
        selectedChannel = channels[indexPath.row]
        let vc = ChatViewController(user: currentUser!, channel: selectedChannel!, channelReference: channelReference)
        navigationController?.pushViewController(vc, animated: true)
        //        self.performSegue(withIdentifier: "toChatView", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAddChannelView") {
            let addChannelVC = segue.destination as? AddChannelViewController
            addChannelVC!.channelReference = channelReference
        }
        
        
    }
}

extension ChannelViewController {
    
}
