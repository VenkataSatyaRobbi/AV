//
//  ChatContacts.swift
//  AmericasVision
//
//  Created by Mohan Dola on 13/05/18.
//  Copyright © 2018 zeroGravity. All rights reserved.
//

import Foundation

class Contacts{
    
    private var _name = ""
    private var  _id = ""
    private var _profileImageUrl: String = ""
    
    
    init(name:String, id:String,profileImageUrl:String) {
        _name = name
        _id = id
        _profileImageUrl = profileImageUrl
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
    
}
