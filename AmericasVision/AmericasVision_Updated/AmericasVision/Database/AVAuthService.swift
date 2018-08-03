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
                saveProfileInfoToUserDefaults()
                onSuccess()
            })
        }
        
        static func saveProfileInfoToUserDefaults(){
            let user:UserInfo = UserInfo.init(_firstName:"", _lastName: "", _email:"", _dob: "", _phone:"", _userid: "", _image: UIImage.init(named: "profile")!)
            if Auth.auth().currentUser != nil {
                
                let AVDBref = Database.database().reference()
                let AVDBuserref = AVDBref.child("users")
                AVDBuserref.child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot) in
                    user.firstName = (snapshot.value as! NSDictionary)["FirstName"] as? String
                    user.lastName = (snapshot.value as! NSDictionary)["LastName"] as? String
                    user.email = (snapshot.value as! NSDictionary)["Email"] as? String
                    user.userid = (snapshot.value as! NSDictionary)["UserId"] as? String
                    user.dob = (snapshot.value as! NSDictionary)["DOB"] as? String
                    user.phone = (snapshot.value as! NSDictionary)["Phone"] as? String
                    
                }
                
                let AVStorageRef = Storage.storage().reference(forURL: PropertyConfig.FIRSTORAGE_ROOT_REF).child("profileImage").child((Auth.auth().currentUser?.uid)!)
                AVStorageRef.downloadURL{
                    (url, error) in
                    if error != nil{
                        print(error?.localizedDescription as Any)
                        return
                    }
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        guard let imageData  = UIImage(data: data!) else { return }
                        DispatchQueue.main.async {
                            user.profileImage = imageData
                            NSKeyedArchiver.archivedData(withRootObject: user)
                            UserDefaults.standard.setLoginUserInfo(userInfo: user)
                            
                        }
                    }).resume()
                }
            }
            
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
        
        static func getCurrentUserId() -> String{
            return Auth.auth().currentUser!.uid
        }
        
        static func getCurrentUserName() -> String{
            return UserDefaults.standard.getLoginUserInfo().firstName! + UserDefaults.standard.getLoginUserInfo().lastName!
        }
        
        static func updateUserProfile(phone: String, dob:String,email: String, password: String, confirmpassword: String, imagedata: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
            Auth.auth().sendPasswordReset(withEmail: email, completion: {(error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                let userId = Auth.auth().currentUser?.uid
                let storageRef = DBProvider.instance.storageRef.child("profileImage").child(userId!)
                storageRef.putData(imagedata, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        return
                    }
                    let profileImageURL = metadata?.downloadURL()?.absoluteString
                    let ref = DBProvider.instance.userRef.child(userId!)
                    ref.updateChildValues(["Phone":phone])
                    ref.updateChildValues(["DOB":dob])
                    ref.updateChildValues(["Email":email])
                    ref.updateChildValues(["ProfileImageURL":profileImageURL])
                    onSuccess()
                })
                
            })
            
        }
        
    }
