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

protocol PublicMessageReceivedDelegate: class {
    func messageReceived(senderId:String,senderName:String,text:String)
    func messageReceived(senderId:String,senderName:String,url:String)
}

class PublicMessageHandler {
    private static let _instance = PublicMessageHandler()
    private init(){}
    
    weak var delegate : PublicMessageReceivedDelegate?
    
    static var Instance: PublicMessageHandler{
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
    
    func observeMediaMessages(){
        DBProvider.instance.mediaMessageRef.observe(DataEventType.childAdded){(snapshot:DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let senderId = data[Constants.SENDERID] as? String {
                    if let senderName = data[Constants.SENDERNAME] as? String {
                        if let url = data[Constants.URL] as? String {
                            self.delegate?.messageReceived(senderId: senderId,senderName: senderName ,url: url)
                        }
                    }
                }
            }
        }
    }
    
    func sendMediaMessages(senderId: String, senderName: String, url:String){
        let data :Dictionary<String,Any> = [Constants.SENDERID:senderId,Constants.SENDERNAME: senderName,Constants.URL:url]
        DBProvider.instance.mediaMessageRef.childByAutoId().setValue((data))
    }
    
    func sendMedia(image:Data?,video:URL?, senderId:String, senderName:String){
        if image != nil {
            DBProvider.instance.imageStorageRef.child(senderId + "\(NSUUID().uuidString).jpg").putData(image!, metadata: nil){
                (metadata:StorageMetadata?,err :Error?) in
                if err != nil {
                   print("error")
                }else{
                    self.sendMediaMessages(senderId: senderId, senderName: senderName, url: String (describing: metadata!.downloadURL()))
                }
                
            }
        }else {
            DBProvider.instance.videoStorageRef.child(senderId + "\(NSUUID().uuidString)").putFile(from: video!, metadata:nil){
                (metadata:StorageMetadata?,err:Error?) in
                if err != nil {
                    print("error")
                }else{
                   self.sendMediaMessages(senderId: senderId, senderName: senderName, url: String (describing: metadata!.downloadURL()))
                }
            }
        }
    }
}
