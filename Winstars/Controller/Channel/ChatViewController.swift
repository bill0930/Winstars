//
//  MessageViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 14/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import FirebaseFirestore



class ChatViewController: MessagesViewController {
    
    
    private let user: User
    private let channel: Channel
    
    private let db = Firestore.firestore()
     private var reference: CollectionReference?
    
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    
    init(user: User, channel: Channel) {
      self.user = user
      self.channel = channel
      super.init(nibName: nil, bundle: nil)
      title = channel.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
      messageListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self as? MessagesLayoutDelegate
        messagesCollectionView.messagesDisplayDelegate = self as? MessagesDisplayDelegate
        guard let id = channel.id else {
          navigationController?.popViewController(animated: true)
          return
        }
    }
    
}


extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        return Sender(id: "any_unique_id", displayName: "Steven")
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}
