//
//  PublicMessageHandler.swift
//  AmericasVision
//
//  Created by Mohan Dola on 21/07/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//
import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol PublicMessageReceivedDelegate: class {
    func messageReceived(senderId:String,senderName:String,text:String,url:String)
    //func messageReceived(senderId:String,senderName:String,url:String)
}

class PublicMessageHandler {
    private static let _instance = PublicMessageHandler()
    private init(){}
    
    weak var delegate : PublicMessageReceivedDelegate?
    
    static var Instance: PublicMessageHandler{
        return _instance
    }
    
    func sendMessage(senderId: String, senderName: String, text:String,url:String) {
        let timestamp = NSDate().timeIntervalSince1970
        let data :Dictionary<String,Any> = [Constants.SENDERID:senderId,Constants.SENDERNAME: senderName,Constants.TEXT:text,Constants.URL:url,Constants.DB_TIMESTAMP:timestamp]
        DBProvider.instance.messageRef.childByAutoId().setValue((data))
    }
    
    func observeMessages(){
        DBProvider.instance.messageRef.observe(DataEventType.childAdded){(snapshot:DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let senderId = data[Constants.SENDERID] as? String {
                    if let senderName = data[Constants.SENDERNAME] as? String {
                        if let text = data[Constants.TEXT] as? String {
                            if let url = data[Constants.URL] as? String {
                                self.delegate?.messageReceived(senderId: senderId,senderName: senderName ,text: text,url:url)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sendMedia(image:Data?,video:URL?, senderId:String, senderName:String){
        if image != nil {
            DBProvider.instance.imageStorageRef.child(senderId + "\(NSUUID().uuidString).jpg").putData(image!, metadata: nil){
                (metadata:StorageMetadata?,err :Error?) in
                if err != nil {
                    print("error")
                }else{
                    self.sendMessage(senderId: senderId, senderName: senderName,text: "", url: (metadata?.downloadURL()?.absoluteString)!)
                }
            }
        }else {
            DBProvider.instance.videoStorageRef.child(senderId + "\(NSUUID().uuidString)").putFile(from: video!, metadata:nil){
                (metadata:StorageMetadata?,err:Error?) in
                if err != nil {
                    print("error")
                }else{
                    self.sendMessage(senderId: senderId, senderName: senderName, text: "",url: (metadata?.downloadURL()?.absoluteString)!)
                }
            }
        }
    }
}
