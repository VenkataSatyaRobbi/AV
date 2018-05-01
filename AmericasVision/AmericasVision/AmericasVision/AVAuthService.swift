    //
    //  AVAuthService.swift
    //  AmericasVision
    //
    //  Created by Venkata Satya R Robbi on 4/9/18.
    //  Copyright © 2018 zeroGravity. All rights reserved.
    //
    
    import Foundation
    import FirebaseAuth
    import FirebaseStorage
    import FirebaseDatabase
    
    class AVAuthService{
        
        static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    onError(error!.localizedDescription)
                    return
                }
                onSuccess()
                
            })
        }
        
        
        static func signUp(firstname: String, lastname: String, phone: String, email: String, password: String, confirmpassword: String, imagedata: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error: Error?) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                let AVDBuserid = user?.uid
                
                let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("profileImage").child(AVDBuserid!)
                AVStorageRef.putData(imagedata, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        return
                    }
                    let profileImageURL = metadata?.downloadURL()?.absoluteString
                    self.setAVUserInformation(profileImageUrl: profileImageURL!, firstname: firstname, lastname: lastname, phone: phone, email: email, uid: AVDBuserid!, onSuccess: onSuccess)
                    
                    
                })
                
            })
            
        }
        static func setAVUserInformation(profileImageUrl: String, firstname: String, lastname: String, phone: String, email: String, uid: String, onSuccess: @escaping () -> Void){
            let AVDBref = Database.database().reference()
            let AVDBuserref = AVDBref.child("users")
            let AVDBnewuserref = AVDBuserref.child(uid)
            AVDBnewuserref.setValue(["FirstName": firstname, "LastName": lastname, "Phone": phone, "Email": email, "ProfileImageURL": profileImageUrl, "UserId": uid ])
            onSuccess()
        }
        
    }
