//
//  ChatContacts.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class Contacts{
    
    var _name = ""
    var  _id = ""
    var _profileImageUrl: String = ""
    var _status = ""
    
    init(name:String, id:String,profileImageUrl:String,status:String) {
        _name = name
        _id = id
        _profileImageUrl = profileImageUrl
        _status = status
    }
    
    var name :String {
        return _name;
    }
    
    var id :String {
        return _id;
    }
    
    var profileImageUrl :String {
        return _profileImageUrl;
    }
    
    var status:String {
        get{
          return _status
        }
        set(value){
            _status = value
        }
    }
    
    
}
