//
//  MessageHandler.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol MessageReceivedDelegate: class {
    func messageReceived(senderId:String,senderName:String,text:String)
}

class MessageHandler {
    private static let _instance = MessageHandler()
    private init(){}
    
    weak var delegate : MessageReceivedDelegate?
    
    static var Instance: MessageHandler{
        return _instance
    }
    
    func sendMessage(senderId: String, senderName: String, text:String) {
        let data :Dictionary<String,Any> = [Constants.SENDERID:senderId,Constants.SENDERNAME: senderName,Constants.TEXT:text]
        DBProvider.instance.messageRef.childByAutoId().setValue((data))
    }
    
    func observeMessages(){
        DBProvider.instance.messageRef.observe(DataEventType.childAdded){(snapshot:DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let senderId = data[Constants.SENDERID] as? String {
                    if let senderName = data[Constants.SENDERNAME] as? String {
                        if let text = data[Constants.TEXT] as? String {
                            self.delegate?.messageReceived(senderId: senderId,senderName: senderName ,text: text)
                        }
                    }
                }
            }
        }
    }
}
