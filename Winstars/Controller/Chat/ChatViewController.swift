//
//  ChatViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 16/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import FirebaseFirestore

class ChatViewController: MessagesViewController{
    
    //    var data = [String : Any?]()
    
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    
    private let user: User
    private let channel: Channel
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    
    init(user: User, channel: Channel) {
        self.user = user
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpMultipleLineTitleView(title: String) {
        let label = UILabel(frame: CGRect(x:0, y:0, width:150, height:50))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = UIColor.black
        label.text = title
        self.navigationItem.titleView = label
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMultipleLineTitleView(title: channel.name)
        
    }
}
