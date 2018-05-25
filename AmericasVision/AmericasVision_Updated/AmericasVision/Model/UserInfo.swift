//
//  UserInfo.swift
//  AmericasVision
//
//  Created by Mohan Dola on 23/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class UserInfo:NSObject,NSCoding {
    
    var firstName : String? 
    var lastName: String?
    var email: String?
    var dob: String?
    var phone: String?
    var profileImage: UIImage!
    //var profileImageURL: String?
    var userid: String?
    
    required init(_firstName:String,_lastName:String, _email:String,_dob:String,_phone:String, _userid:String,_image:UIImage){
        firstName = _firstName
        lastName = _lastName
        email   = _email
        dob = _dob
        phone = _phone
        userid = _userid
        profileImage = _image
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(userid, forKey: "userid")
        aCoder.encode(profileImage, forKey: "profileImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        userid = aDecoder.decodeObject(forKey: "userid") as? String
        profileImage = aDecoder.decodeObject(forKey: "profileImage") as? UIImage
    }
    
    
    
    
    
}
