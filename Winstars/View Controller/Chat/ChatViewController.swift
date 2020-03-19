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
import FirebaseAuth
import PullToRefresh

class ChatViewController: MessagesViewController{
    
    //    var data = [String : Any?]()
    //    let refresher = PullToRefresh()
    
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    
    private let user: User
    private let channel: Channel
    
    private let db = Firestore.firestore()
    private let channelReference: CollectionReference
    private var threadReference: CollectionReference?
    
    let refreshControl = UIRefreshControl()
    
    
    
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
    
    
    init(user: User, channel: Channel, channelReference: CollectionReference) {
        self.user = user
        self.channel = channel
        self.channelReference = channelReference
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMultipleLineTitleView(title: channel.name)
        guard let id = channel.id else {
            navigationController?.popViewController(animated: false)
            return
        }
        
        threadReference = channelReference.document(id).collection("thread")
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .red
        messageInputBar.sendButton.setTitleColor(.primary, for: .normal)
        
        messageListener = threadReference?
            .order(by: "created", descending: false)
            .limit(toLast: 100)
            //to fetch last 100 messages
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                    return
                }
                //            print("the chdocumentChangesange are \(snapshot.documentChanges.debugDescription)")
                
                snapshot.documentChanges.forEach { change in
                    self.handleDocumentChange(change)
                }
        }
        //
        //        self.addPullToRefresh(refresher) {
        //                print("pull to refresh")
        //        }
        
    }
    
    private func insertNewMessage(_ message: Message) {
        print("insertNewMessage")
        guard !messages.contains(message) else {
            return
        }
        
        messages.append(message)
        //        messages.sort()
        
        let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
        
        messagesCollectionView.reloadData()
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        //        print("the document change is being handle ")
        //        print("message[] = \(messages)")
        guard let message = Message(document: change.document) else {
            //            print("cannot initiase")
            return
        }
        
        print("messageId: \(message.messageId)")
        print(change.type)
        switch change.type {
        case .added:
            //            print("added type handled")
            self.insertNewMessage(message)
            
        default:
            print("default")
        }
    }
    
    private func save(_ message: Message) {
        threadReference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
}
// MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        
        return true
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
        
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 20, height: 10)
    }
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 20, height: 10)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath,
                           with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20.0
    }
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20.0
    }
    
    
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id: user.uid, displayName: AppSettings.displayName)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return messages.count
        //        return
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let date = messages[indexPath.section].sentDate.description
        return NSAttributedString(
            string: date,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
      
    func inputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // 1
        let message = Message(user: user, content: text)
        
        // 2
        save(message)
        
        // 3
        inputBar.inputTextView.text = ""
    }
    
    func inputBar(_ inputBar: MessageInputBar, didChangeIntrinsicContentTo size: CGSize) {
        
    }
    
    func inputBar(_ inputBar: MessageInputBar, textViewTextDidChangeTo text: String) {
        
    }
    
}


extension ChatViewController{
}
