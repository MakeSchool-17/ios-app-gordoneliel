//
//  InboxViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 12/8/15.
//  Copyright © 2015 Saltar Group. All rights reserved.
//

import UIKit
import Foundation
import JSQMessagesViewController
import Firebase
import Bond

class InboxViewController: JSQMessagesViewController {
    
    var user: FAuthData?
    var ref: Firebase!
    var batchMessages = true

    var avatars = Dictionary<String, JSQMessagesAvatarImage>()
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.orangeMelon())
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.whiteColor())
    
    var messages = [Message]()
    var messagesRef: Firebase!
    var outgoingUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = outgoingUser.name
        collectionView!.backgroundColor = UIColor.lighterGrayColor()
//        collectionView!.collectionViewLayout.springinessEnabled = true
//        collectionView?.collectionViewLayout.messageBubbleFont =  UIFont(name: "AvenirNext-Medium", size: 15)
        automaticallyScrollsToMostRecentMessage = true
        
        setupAvatarColor(senderDisplayName, incoming: false)
        setupFirebase()
    }
}

// MARK: FIREBASE
extension InboxViewController {
    func setupFirebase() {
        // *** STEP 2: SETUP FIREBASE
        messagesRef = Firebase(url: "https://officehoursapp.firebaseio.com/messages/")
        messagesRef = messagesRef.childByAppendingPath(senderId + outgoingUser.objectId!)

        // *** STEP 4: RECEIVE MESSAGES FROM FIREBASE (limited to latest 25 messages)
        messagesRef.queryLimitedToLast(50).observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let text = snapshot.value["text"] as? String
            let senderId = snapshot.value["senderId"] as? String
            let senderDisplayName = snapshot.value["senderDisplayName"] as? String
            
            let message = Message(senderId: senderId ?? "", senderDisplayName: senderDisplayName ?? "", text: text ?? "")

            self.messages.append(message)
            self.finishReceivingMessage()
        })
    }
    
    func sendMessage(text: String, senderId: String, senderDisplayName: String) {
        // *** STEP 3: ADD A MESSAGE TO FIREBASE
        messagesRef.childByAutoId().setValue([
            "text":text,
            "senderId":senderId,
            "senderDisplayName": senderDisplayName
            ])
    }
    
    func setupAvatarColor(name: String, incoming: Bool) {
        let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let rgbValue = name.hash
        let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
        let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        let b = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        let color = UIColor(red: r, green: g, blue: b, alpha: 0.8)
        
        let nameLength = name.characters.count
        let initials: String? = name.substringToIndex(senderDisplayName.startIndex.advancedBy(min(3, nameLength)))
        let userImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(CGFloat(11)), diameter: diameter)
        
        avatars[name] = userImage
    }

}
//MARK - Toolbar
extension InboxViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {

        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        sendMessage(text, senderId: senderId, senderDisplayName: senderDisplayName)
        finishSendingMessage()
    }
    
    /*
    *   You can send the media messages from here. Just modify this function call.
    */
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        // Simulate reciving message
        showTypingIndicator = !showTypingIndicator
        scrollToBottomAnimated(true)
    }
}

//MARK - Data Source
extension InboxViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.row]
        
        if message.senderId() == senderId {
            return outgoingBubble
        }

        return incomingBubble
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            cell.textView!.textColor = UIColor.darkGrayColor()
        } else {
            cell.textView!.textColor = UIColor.whiteColor()
        }
        
        let attributes: [String:AnyObject] = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
        cell.textView!.linkTextAttributes = attributes
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        if let avatar = avatars[message.senderDisplayName()] {
            return avatar
        }
        else {
            setupAvatarColor(message.senderDisplayName(), incoming: true)
            return avatars[message.senderDisplayName()]
        }
    }
}
