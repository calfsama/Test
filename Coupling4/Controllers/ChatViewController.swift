//
//  ChatViewController.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 23/06/22.
//
import UIKit
import MessageKit

//struct Sender:SenderType{
//    var senderId: String
//
//    var displayName: String
//
//
//}
//
//struct Message: MessageType{
//    var sender: SenderType
//    var messageId: String
//    var sentDate: Date
//    var kind: MessageKind
//}
//
//
//
//class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
//
//    open var messagesCollectionView = MessagesCollectionView()
//
//    var messages = [MessageType]()
//    let currentUser = Sender(senderId: "other", displayName: "John Smith")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello World")))
//
//        messagesCollectionView.messageCellDelegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//    }
//    func currentSender() -> SenderType {
//        return currentUser
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        return messages[indexPath.row]
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messages.count
//    }
//
//
//}
//
