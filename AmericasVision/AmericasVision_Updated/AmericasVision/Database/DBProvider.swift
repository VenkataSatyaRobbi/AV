//
//  DBProvider.swift
//  AmericasVision
//
//  Created by Mohan Dola on 12/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol FetchData: class {
    func dataReceived(contacts: [Contacts])
}

class DBProvider {
    
    private static let _instance = DBProvider()
    weak var delegate:FetchData?
    
    private init(){}
    
    static var instance : DBProvider{
        return _instance
    }
    
    //Start: Start of all Firebase access references
    var databaseRef : DatabaseReference {
        return Database.database().reference()
    }
    
    var storageRef : StorageReference {
        return Storage.storage().reference(forURL: "gs://americasvision-fc7ba.appspot.com")
    }
    //End: End of all Firebase access references
    
    // Start :Contains all database access refernece based on child key .
    var chatContactsRef: DatabaseReference {
        return databaseRef.child(Constants.DB_CHATCONTACTS)
    }
    
    var newsFeedRef: DatabaseReference {
        return databaseRef.child(Constants.DB_POSTS)
    }
    
    var userRef: DatabaseReference {
        return databaseRef.child(Constants.DB_USERS)
    }
    
    var messageRef: DatabaseReference {
        return databaseRef.child(Constants.DB_MESSAGES)
    }
    
    var chatStatusRef: DatabaseReference {
        return databaseRef.child(Constants.DB_PRIVATECHATSTATUS)
    }
    
    var opinionRef: DatabaseReference {
        return databaseRef.child(Constants.DB_OPINION)
    }
    
    var privateMessageRef: DatabaseReference {
        return databaseRef.child(Constants.DB_PRIVATE_MESSAGES)
    }
    
    var mediaPrivateMessageRef: DatabaseReference {
        return databaseRef.child(Constants.DB_PRIVATE_MEDIA_MESSAGES)
    }
    
    var preferenceRef: DatabaseReference {
        return databaseRef.child(Constants.DB_SETTINGS)
    }
    
    var videoStorageRef: StorageReference {
        return storageRef.child(Constants.DB_VIDEO_MESSAGES)
    }
    
    var imageStorageRef: StorageReference {
        return storageRef.child(Constants.DB_IMAGE_MESSAGES)
    }
    
    func getContacts(){
        chatContactsRef.observeSingleEvent(of: DataEventType.value){
            (snapShot:DataSnapshot) in
            var contacts = [Contacts]()
            
            if let myContacts = snapShot.value as? NSDictionary{
                for(key,value) in myContacts{
                    let id = key as! String
                    if id != AVAuthService.getCurrentUserId() {
                        if let contactData = value as? NSDictionary{
                            if let firstName = contactData[Constants.FIRSTNAME] as? String {
                                let lastName = contactData[Constants.LASTNAME] as? String
                                let url = contactData[Constants.PROFILEIMAGEURL] as? String
                                let userName = firstName + " " + lastName!
                                let newContact = Contacts(name :userName,id:id,profileImageUrl:url!,status:"Unavailable")
                                contacts.append(newContact)
                            }
                        }
                    }
                }
            }
            self.delegate?.dataReceived(contacts: contacts)
        }
    }
        
    func updateProfileInfo(userInfo:UserInfo){
        let userId = userInfo.userid
        let imageData = UIImageJPEGRepresentation(userInfo.profileImage, 0.1)
        let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("profileImage").child(userId!)
        AVStorageRef.putData(imageData!, metadata: nil, completion: { (metadata, error) in
            if error != nil{
                return
            }
            let profileImageURL = metadata?.downloadURL()?.absoluteString
            let AVDBnewuserref = self.userRef.child(userId!)
            AVDBnewuserref.setValue(["FirstName": userInfo.firstName, "LastName": userInfo.lastName, "Phone": userInfo.phone, "Email": userInfo.email, "ProfileImageURL": profileImageURL, "UserId": userInfo.userid ])
        })
    }
    
    func getGlobalSettingInfo(key:String) -> String {
       return ""
    }
   
    
}
