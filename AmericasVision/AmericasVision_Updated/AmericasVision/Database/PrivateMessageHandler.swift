//
//  PrivateMessageHandler.swift
//  AmericasVision
//
//  Created by Mohan Dola on 10/06/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

//
//  PrivateMessageHandler.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol PrivateMessageReceivedDelegate: class {
    func messageReceived(senderId:String,senderName:String,text:String,url:String,receiverID:String)
}

class PrivateMessageHandler {
    private static let _instance = PrivateMessageHandler()
    private init(){}
    
    weak var delegate : PrivateMessageReceivedDelegate?
    
    static var Instance: PrivateMessageHandler{
        return _instance
    }
    
    func sendMessage(senderId: String, senderName: String, text:String,url:String,receiverId:String,receiverName:String) {
        let timestamp = NSDate().timeIntervalSince1970
        let data :Dictionary<String,Any> = [Constants.SENDERID:senderId,Constants.SENDERNAME: senderName,Constants.TEXT:text,Constants.URL:url ,Constants.RECEIVERID:receiverId,
                                            Constants.RECEIVERNAME:receiverName,Constants.DB_TIMESTAMP:timestamp]
        DBProvider.instance.privateMessageRef.childByAutoId().setValue((data))
    }
    
    func observeMessages(contactId:String){
        DBProvider.instance.privateMessageRef.observe(DataEventType.childAdded){(snapshot:DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                let senderId = data[Constants.SENDERID] as? String
                let senderName = data[Constants.SENDERNAME] as? String
                var text = data[Constants.TEXT] as? String
                if text == nil {
                    text = ""
                }
                let receiverID = data[Constants.RECEIVERID] as? String
                var url = data[Constants.URL] as? String
                if url == nil {
                    url = ""
                }
                if (contactId == senderId ) || (AVAuthService.getCurrentUserId() == senderId && contactId == receiverID) {
                    self.delegate?.messageReceived(senderId: senderId!,senderName: senderName! ,text: text!,url: url!,receiverID:receiverID!)
                }
            }
        }
    }
    
    func sendMedia(image:Data?,video:URL?, senderId:String, senderName:String,receiverId:String,receiverName:String){
        if image != nil {
            DBProvider.instance.imageStorageRef.child(senderId + "\(NSUUID().uuidString).jpg").putData(image!, metadata: nil){
                (metadata:StorageMetadata?,err :Error?) in
                if err != nil {
                    print("error")
                }else{
                    self.sendMessage(senderId: senderId, senderName: senderName,text: "", url: (metadata?.downloadURL()?.absoluteString)!,receiverId: receiverId,receiverName: receiverName)
                }
                
            }
        }else {
            DBProvider.instance.videoStorageRef.child(senderId + "\(NSUUID().uuidString)").putFile(from: video!, metadata:nil){
                (metadata:StorageMetadata?,err:Error?) in
                if err != nil {
                    print("error")
                }else{
                    self.sendMessage(senderId: senderId, senderName: senderName,text: "", url: (metadata?.downloadURL()?.absoluteString)!,receiverId: receiverId,receiverName: receiverName)
                }
            }
        }
    }
}

