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

class GroupViewController: UIViewController  {
    
    var selectedGroup: Group?
    let db = Firestore.firestore()
    
    
    let groupCellIdentifier = "groupCell"
    private var currentGroupAlertController: UIAlertController?
    
    
    private var groupReference: CollectionReference {
        return db.collection("groups")
    }
    
    private var groupListener: ListenerRegistration?
    
    deinit {
        groupListener?.remove()
    }
    
    private var groups = [Group](){
        didSet{
            //            print(groups)
        }
    } // [id: String?, name: String]
    
    
    @IBOutlet weak var groupLabelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        addGroupToTable(Group(name: "test"))
        
        groupListener = groupReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
                
            }
        }
        
        //        self.createGroup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func addGroupToTable(_ group: Group) {
        guard !groups.contains(group) else {
            return
        }
        
        groups.append(group)
        groups.sort()
        
        guard let index = groups.firstIndex(of: group) else {
            return
        }
        groupLabelTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    private func updateGroupToTable(_ group: Group) {
        guard let index = groups.firstIndex(of: group) else {
            return
        }
        
        groups[index] = group
        groupLabelTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    private func removeGroupFromTable(_ group: Group) {
        guard let index = groups.firstIndex(of: group) else {
            return
        }
        
        groups.remove(at: index)
        groupLabelTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    
    // MARK: -Helpers
    private func handleDocumentChange(_ change: DocumentChange) {
        guard let group = Group(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            addGroupToTable(group)
            
        case .modified:
            updateGroupToTable(group)
            
        case .removed:
            removeGroupFromTable(group)
            
        }
    }
}

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell( withIdentifier: groupCellIdentifier, for: indexPath) as! GroupViewTableViewCell
        if let image = UIImage(named: groups[indexPath.row].name){
            cell.buttonImageView.image = image
            cell.buttonImageView.contentMode = .scaleAspectFill
        }
        
        //
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = groups[indexPath.row]
        print("you selected \(groups[indexPath.row].representation)")
        self.performSegue(withIdentifier: "toChannelView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let channelVC = segue.destination as! ChannelViewController
        channelVC.data["group_id"] = selectedGroup?.id!
        channelVC.data["group_name"] = selectedGroup?.name
    }
    
}
